using RemoteAdmin.Communication;
using TMPro;
using ToggleableMenus;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	public class RemoteAdminUIController : SimpleToggleableMenu
	{
		public static RemoteAdminUIController Singleton;

		public static bool? PendingLogin;

		public GameObject UIRoot;

		public GameObject RootLogin;

		public GameObject RootPanel;

		public GameObject RootTbra;

		public Texture WrongPasswordTexture;

		public Button ConfirmButton;

		public InputField PasswordField;

		public Canvas RACanvas;

		public GameObject ConsoleToolTip;

		public RectTransform ConsoleToolTipBackground;

		public TMP_Text ConsoleToolTipText;

		public Text PasswordPlaceholder;

		[SerializeField]
		private Vector3 _toolTipOffset = new Vector3(12f, -12f, 0f);

		[SerializeField]
		private float _toolTipPadding = 4f;

		private bool _textBasedVersion;

		private float _toolTipHideTime;

		private TMP_InputField[] _allTmpFields;

		private InputField[] _allRegularFields;

		[field: SerializeField]
		public TMP_Dropdown PlayerSortingDropdown { get; set; }

		[field: SerializeField]
		public SubmenuSelector SubmenuSelector { get; set; }

		public bool LoggedIn { get; private set; }

		public static bool DescendingSort { get; set; }

		public override bool CanToggle => !IsAnyInputFieldFocused();

		public override bool LockMovement
		{
			get
			{
				if (!IsEnabled)
				{
					return false;
				}
				// "Toggle Movement" in the RA settings lets the player keep walking with the panel open.
				Menus.RaSettings singleton = Menus.RaSettings.Singleton;
				if (singleton != null && !singleton.ToggleMovement.Value)
				{
					return true;
				}
				return IsAnyInputFieldFocused();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			Singleton = this;
			_allTmpFields = GetComponentsInChildren<TMP_InputField>(includeInactive: true);
			_allRegularFields = GetComponentsInChildren<InputField>(includeInactive: true);
			if (PendingLogin.HasValue)
			{
				LoggedIn = PendingLogin.Value;
				PendingLogin = null;
			}
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (Singleton == this)
			{
				Singleton = null;
			}
		}

		private void Start()
		{
			RefreshStatus();
		}

		private void Update()
		{
			if (ConsoleToolTip != null && ConsoleToolTip.activeSelf)
			{
				if (Time.unscaledTime > _toolTipHideTime)
				{
					ConsoleToolTip.SetActive(value: false);
				}
				else
				{
					MoveToolTip();
				}
			}
		}

		private void MoveToolTip()
		{
			if (ConsoleToolTipBackground == null)
			{
				return;
			}
			Vector3 vector = Input.mousePosition + _toolTipOffset;
			float num = ((RACanvas != null) ? RACanvas.scaleFactor : 1f);
			float num2 = ConsoleToolTipBackground.rect.width * num * 0.5f;
			float num3 = ConsoleToolTipBackground.rect.height * num * 0.5f;
			vector.x = Mathf.Clamp(vector.x, num2, (float)Screen.width - num2);
			vector.y = Mathf.Clamp(vector.y, num3, (float)Screen.height - num3);
			Camera cam = ((RACanvas != null && RACanvas.renderMode != RenderMode.ScreenSpaceOverlay) ? RACanvas.worldCamera : null);
			if (RectTransformUtility.ScreenPointToWorldPointInRectangle(ConsoleToolTipBackground, vector, cam, out var worldPoint))
			{
				ConsoleToolTipBackground.position = worldPoint;
				if (ConsoleToolTipText != null)
				{
					ConsoleToolTipText.transform.position = worldPoint;
				}
			}
		}

		private bool IsAnyInputFieldFocused()
		{
			if (_allTmpFields != null)
			{
				TMP_InputField[] allTmpFields = _allTmpFields;
				foreach (TMP_InputField tMP_InputField in allTmpFields)
				{
					if (tMP_InputField != null && tMP_InputField.isFocused)
					{
						return true;
					}
				}
			}
			if (_allRegularFields != null)
			{
				InputField[] allRegularFields = _allRegularFields;
				foreach (InputField inputField in allRegularFields)
				{
					if (inputField != null && inputField.isFocused)
					{
						return true;
					}
				}
			}
			return false;
		}

		public static RaPlayerList.PlayerSorting GetSorting()
		{
			if (Singleton == null || Singleton.PlayerSortingDropdown == null || Singleton.PlayerSortingDropdown.options.Count == 0)
			{
				return RaPlayerList.PlayerSorting.Ids;
			}
			return (RaPlayerList.PlayerSorting)Mathf.Clamp(Singleton.PlayerSortingDropdown.value, 0, 3);
		}

		public void SetSorting(int sorting)
		{
			if (LoggedIn)
			{
				RaPlayerList.Request(isSilent: true, GetSorting(), DescendingSort);
			}
		}

		public void SetLoggedIn(bool state)
		{
			LoggedIn = state;
			RefreshStatus();
			if (state)
			{
				RaPlayerList.Request(isSilent: true, GetSorting(), DescendingSort);
			}
		}

		public void ChangeConsoleStage()
		{
			IsEnabled = !IsEnabled;
		}

		public void ChangeTextMode(bool textMode)
		{
			if (_textBasedVersion && !textMode)
			{
				PlayerInfoQR.Clear();
			}
			_textBasedVersion = textMode;
			RefreshStatus();
		}

		public void CallSendPassword()
		{
			GameCore.Console.AddLog("Remote Admin password login is not supported in this build. Use a permission group from config_remoteadmin.txt.", Color.yellow);
			if (PasswordField != null && WrongPasswordTexture != null && PasswordField.TryGetComponent<RawImage>(out var component))
			{
				component.texture = WrongPasswordTexture;
			}
		}

		public void RefreshStatus()
		{
			bool isEnabled = IsEnabled;
			if (RootPanel != null)
			{
				RootPanel.SetActive(isEnabled && LoggedIn && !_textBasedVersion);
			}
			if (RootTbra != null)
			{
				RootTbra.SetActive(isEnabled && LoggedIn && _textBasedVersion);
			}
			if (RootLogin != null)
			{
				RootLogin.SetActive(isEnabled && !LoggedIn);
			}
		}

		protected override void OnToggled()
		{
			base.OnToggled();
			if (IsEnabled && !LoggedIn && ReferenceHub.TryGetLocalHub(out var hub) && hub.serverRoles.RemoteAdmin)
			{
				LoggedIn = true;
			}
			RefreshStatus();
			if (IsEnabled && LoggedIn)
			{
				RaPlayerList.Request(isSilent: true, GetSorting(), DescendingSort);
			}
		}

		public void SetToolTip(string tip, float blockSeconds = 0.1f, bool delayedDisplay = false)
		{
			if (ConsoleToolTip == null || ConsoleToolTipText == null)
			{
				return;
			}
			ConsoleToolTip.SetActive(value: true);
			ConsoleToolTipText.text = tip;
			_toolTipHideTime = Time.unscaledTime + Mathf.Max(0.1f, blockSeconds) + 0.1f;
			if (ConsoleToolTipBackground != null)
			{
				Vector2 preferredValues = ConsoleToolTipText.GetPreferredValues(tip);
				ConsoleToolTipBackground.sizeDelta = new Vector2(preferredValues.x + _toolTipPadding * 2f, preferredValues.y + _toolTipPadding * 2f);
			}
			MoveToolTip();
		}
	}
}

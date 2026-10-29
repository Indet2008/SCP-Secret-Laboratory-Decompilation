using PlayerRoles;
using TMPro;
using ToggleableMenus;
using UnityEngine;

public class SpectatorInterface : SimpleToggleableMenu
{
	public GameObject RootPanel;

	public static SpectatorInterface Singleton;

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public TextMeshProUGUI PlayerList;

	public TextMeshProUGUI PlayerInfo;

	[SerializeField]
	private TextMeshProUGUI _attachmentsEditorText;

	private Canvas _spectatorCanvas;

	public bool SpectatorCanvasActive { get; set; }

	public override bool CanToggle
	{
		get
		{
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				return hub.GetRoleId() == RoleTypeId.Spectator;
			}
			return false;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		Singleton = this;
		_spectatorCanvas = GetComponent<Canvas>();
	}

	private void OnEnable()
	{
		if (_attachmentsEditorText != null)
		{
			_attachmentsEditorText.text = "Press " + new ReadableKeyCode(NewInput.GetKey(ActionName.Inventory)) + " to edit attachment preferences while spectating.";
		}
	}

	private void Update()
	{
		if (SpectatorCanvasActive && HideHUDController.IsHUDVisible)
		{
			_spectatorCanvas.enabled = true;
			return;
		}
		_spectatorCanvas.enabled = false;
		IsEnabled = false;
	}
}

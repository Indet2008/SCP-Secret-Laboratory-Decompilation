using OperationalGuide.ModelSpawners;
using PlayerRoles;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class OperationalGuide : MonoBehaviour
	{
		public static readonly float MinZoom = 1.1f;

		public static readonly float MaxZoom = 49f;

		public static Vector3 ScaleModifier = new Vector3(0.05f, 0.05f, 0.05f);

		public static OperationalGuide Instance;

		public OperationalTabController[] Tabs;

		public Camera Camera;

		public Animator FadeAnimator;

		public GameObject Back;

		public GameObject FullscreenPannable;

		public RawImage FullscreenPannableImage;

		public GameObject MainButtonPage;

		public SpawnerHandler ModelSpawner;

		public PageButton ButtonPrefab;

		public RectTransform ButtonRootPrefab;

		public Sprite Arrow;

		[SerializeField]
		private RenderTexture _regularRenderTexture;

		[SerializeField]
		private RenderTexture _fullscreenRenderTexture;

		private const float ZoomIn = 1f;

		private const float ZoomOut = -1f;

		private Scene _facilityScene;

		public bool IsInFacilityScene => SceneManager.GetActiveScene() == _facilityScene;

		public bool AnyPageOpen => GetActiveTab() != null;

		public static bool IsActive
		{
			get
			{
				if (Instance != null)
				{
					return Instance.gameObject.activeSelf;
				}
				return false;
			}
		}

		public void ButtonChangeTab(int index)
		{
			if (GetActiveTab() != null)
			{
				return;
			}
			for (int i = 0; i < Tabs.Length; i++)
			{
				Tabs[i].gameObject.SetActive(i == index);
				if (i == index)
				{
					Tabs[i].IncrementIndex(0);
				}
			}
			MainButtonPage.SetActive(value: false);
		}

		public static void ChangeZoom(Transform transform, bool increase, bool panImage = false)
		{
			Vector3 localScale = transform.localScale;
			float sqrMagnitude = localScale.sqrMagnitude;
			if (panImage)
			{
				Vector3 localPosition = transform.localPosition;
				transform.localPosition = new Vector3(localPosition.x + Input.GetAxis("Mouse X") * 50f, localPosition.y + Input.GetAxis("Mouse Y") * 50f, localPosition.z);
			}
			else if (!(increase ? (MinZoom > sqrMagnitude) : (sqrMagnitude > MaxZoom)))
			{
				transform.localScale = transform.localScale + ScaleModifier * (increase ? (-1f) : 1f);
			}
		}

		private void Update()
		{
			if (Input.GetKeyDown(KeyCode.Escape) && !IsInFacilityScene)
			{
				BackCurrentPage();
			}
			if (Input.GetKeyDown(KeyCode.LeftArrow))
			{
				GetActiveTab()?.IncrementIndex(-1);
			}
			if (Input.GetKeyDown(KeyCode.RightArrow))
			{
				GetActiveTab()?.IncrementIndex(1);
			}
			if (FullscreenPannable.activeSelf && (Input.GetMouseButton(2) || Input.GetAxis("Mouse ScrollWheel") != 0f))
			{
				ChangeZoom(FullscreenPannableImage.transform, 0f > Input.GetAxis("Mouse ScrollWheel"), Input.GetMouseButton(2));
			}
		}

		public void SetFullscreen(bool state)
		{
			FullscreenPannable.SetActive(state);
			(state ? _fullscreenRenderTexture : _regularRenderTexture).Release();
			Camera.targetTexture = (FullscreenPannable.activeSelf ? _fullscreenRenderTexture : _regularRenderTexture);
		}

		public OperationalTabController GetActiveTab()
		{
			OperationalTabController[] tabs = Tabs;
			foreach (OperationalTabController operationalTabController in tabs)
			{
				if (operationalTabController.gameObject.activeSelf)
				{
					return operationalTabController;
				}
			}
			return null;
		}

		// Closes the fullscreen view, then the open tab; on the main page (in game) closes the guide.
		public void BackCurrentPage()
		{
			if (FullscreenPannable.activeSelf)
			{
				SetFullscreen(state: false);
				return;
			}
			bool flag = false;
			OperationalTabController[] tabs = Tabs;
			foreach (OperationalTabController operationalTabController in tabs)
			{
				if (!operationalTabController.gameObject.activeSelf)
				{
					continue;
				}
				OperationalPage[] pages = operationalTabController.Pages;
				foreach (OperationalPage operationalPage in pages)
				{
					if (operationalPage.gameObject.activeSelf)
					{
						operationalPage.ForceTurnOff();
						operationalTabController.gameObject.SetActive(value: false);
						flag = true;
					}
				}
			}
			Back.SetActive(IsInFacilityScene);
			MainButtonPage.SetActive(value: true);
			if (!flag && IsInFacilityScene)
			{
				Instance.gameObject.SetActive(value: false);
			}
		}

		public void ToggleCurrentPage()
		{
			OperationalTabController[] tabs = Tabs;
			foreach (OperationalTabController operationalTabController in tabs)
			{
				if (!operationalTabController.gameObject.activeSelf)
				{
					continue;
				}
				OperationalPage[] pages = operationalTabController.Pages;
				foreach (OperationalPage operationalPage in pages)
				{
					if (!(operationalPage.DescriptionPage == null) && operationalPage.gameObject.activeSelf)
					{
						operationalPage.ToggleDescriptionMenu();
					}
				}
			}
		}

		public PannableObject SpawnModelRoleForCamera(RoleTypeId role)
		{
			return ModelSpawner.SpawnRole(role);
		}

		private void Awake()
		{
			Instance = this;
			_facilityScene = SceneManager.GetSceneByName("facility");
		}

		private void OnEnable()
		{
			Camera.gameObject.SetActive(value: true);
			MainButtonPage.SetActive(value: true);
			Back.SetActive(IsInFacilityScene || AnyPageOpen);
		}

		private void OnDisable()
		{
			Camera.gameObject.SetActive(value: false);
			_regularRenderTexture.Release();
			_fullscreenRenderTexture.Release();
		}
	}
}

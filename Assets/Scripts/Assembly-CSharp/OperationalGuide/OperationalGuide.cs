namespace OperationalGuide
{
	public class OperationalGuide : global::UnityEngine.MonoBehaviour
	{
		public static readonly float MinZoom;

		public static readonly float MaxZoom;

		public static global::UnityEngine.Vector3 ScaleModifier;

		public static global::OperationalGuide.OperationalGuide Instance;

		public global::OperationalGuide.OperationalTabController[] Tabs;

		public global::UnityEngine.Camera Camera;

		public global::UnityEngine.Animator FadeAnimator;

		public global::UnityEngine.GameObject Back;

		public global::UnityEngine.GameObject FullscreenPannable;

		public global::UnityEngine.UI.RawImage FullscreenPannableImage;

		public global::UnityEngine.GameObject MainButtonPage;

		public global::OperationalGuide.ModelSpawners.SpawnerHandler ModelSpawner;

		public global::OperationalGuide.PageButton ButtonPrefab;

		public global::UnityEngine.RectTransform ButtonRootPrefab;

		public global::UnityEngine.Sprite Arrow;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RenderTexture _regularRenderTexture;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RenderTexture _fullscreenRenderTexture;

		private const float ZoomIn = 1f;

		private const float ZoomOut = -1f;

		private global::UnityEngine.SceneManagement.Scene _facilityScene;

		public bool IsInFacilityScene
		{
			get
			{
				return default;
			}
		}

		public bool AnyPageOpen
		{
			get
			{
				return default;
			}
		}

		public static bool IsActive
		{
			get
			{
				return default;
			}
		}

		public void ButtonChangeTab(int index)
		{
		}

		public static void ChangeZoom(global::UnityEngine.Transform transform, bool increase, bool panImage = false)
		{
		}

		private void Update()
		{
		}

		public void SetFullscreen(bool state)
		{
		}

		public global::OperationalGuide.OperationalTabController GetActiveTab()
		{
			return default;
		}

		public void BackCurrentPage()
		{
		}

		public void ToggleCurrentPage()
		{
		}

		public global::OperationalGuide.PannableObject SpawnModelRoleForCamera(global::PlayerRoles.RoleTypeId role)
		{
			return default;
		}

		private void Awake()
		{
		}

		private void OnEnable()
		{
		}

		private void OnDisable()
		{
		}

		public OperationalGuide()
		{
		}
	}
}

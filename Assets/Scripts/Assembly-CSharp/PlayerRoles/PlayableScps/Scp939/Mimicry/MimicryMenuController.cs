using ToggleableMenus;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryMenuController : ToggleableMenuBase
	{
		[SerializeField]
		private float _fadeSpeed;

		[SerializeField]
		private CanvasGroup _fader;

		[SerializeField]
		private CanvasGroup[] _inverseFaders;

		private bool _canvasCacheSet;

		private Canvas _cachedCanvas;

		public static MimicryMenuController Singleton { get; private set; }

		public static bool SingletonSet { get; private set; }

		public static bool FullyClosed
		{
			get
			{
				if (SingletonSet)
				{
					return !Singleton.gameObject.activeSelf;
				}
				return false;
			}
		}

		public override bool CanToggle
		{
			get
			{
				if (ReferenceHub.TryGetLocalHub(out var hub))
				{
					return hub.roleManager.CurrentRole is Scp939Role;
				}
				return false;
			}
		}

		public static float ScaleFactor
		{
			get
			{
				if (!SingletonSet)
				{
					return 1f;
				}
				if (!Singleton._canvasCacheSet)
				{
					Singleton._cachedCanvas = Singleton.GetComponentInParent<Canvas>();
					Singleton._canvasCacheSet = true;
				}
				return Singleton._cachedCanvas.scaleFactor;
			}
		}

		private void Update()
		{
			float num = (IsEnabled ? 1f : (-1f));
			float newAlpha = _fader.alpha + num * Time.deltaTime * _fadeSpeed;
			newAlpha = Mathf.Clamp01(newAlpha);
			_fader.alpha = newAlpha;
			_inverseFaders.ForEach((CanvasGroup x) =>
			{
				x.alpha = 1f - newAlpha;
			});
			if (newAlpha <= 0f)
			{
				base.gameObject.SetActive(value: false);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			Singleton = this;
			SingletonSet = true;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (!(Singleton != this))
			{
				Singleton = null;
				SingletonSet = false;
			}
		}

		protected override void OnToggled()
		{
			if (IsEnabled)
			{
				base.gameObject.SetActive(value: true);
			}
		}
	}
}

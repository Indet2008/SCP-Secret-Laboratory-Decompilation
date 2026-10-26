using System.Linq;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.GUI;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public class OverconManager : MonoBehaviour
	{
		[SerializeField]
		private OverconRendererBase[] _renderers;

		private Scp079CurrentCameraSync _curCamSync;

		private const string OverconLayer = "Viewmodel";

		private const float Range = 200f;

		private static int _raycastMask;

		private static int RaycastMask
		{
			get
			{
				if (_raycastMask == 0)
				{
					_raycastMask = LayerMask.GetMask("Viewmodel");
				}
				return _raycastMask;
			}
		}

		public OverconBase HighlightedOvercon { get; private set; }

		public static OverconManager Singleton { get; private set; }

		private void OnCameraChanged()
		{
			Scp079Camera currentCamera = _curCamSync.CurrentCamera;
			OverconRendererBase[] renderers = _renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].SpawnOvercons(currentCamera);
			}
		}

		private void Start()
		{
			Singleton = this;
			Scp079Hud.Instance.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
			_curCamSync.OnCameraChanged += OnCameraChanged;
			OnCameraChanged();
		}

		private void OnDestroy()
		{
			OverconBase[] array = OverconBase.ActiveInstances.ToArray();
			foreach (OverconBase overconBase in array)
			{
				if (!(overconBase == null))
				{
					Object.Destroy(overconBase.gameObject);
				}
			}
			OverconBase.ActiveInstances.Clear();
			if (_curCamSync != null)
			{
				_curCamSync.OnCameraChanged -= OnCameraChanged;
			}
		}

		private void Update()
		{
			if (!Scp079Role.LocalInstanceActive)
			{
				return;
			}
			OverconBase overconBase = (Physics.Raycast(Scp079Hud.MainCamera.ScreenPointToRay(Input.mousePosition), out var hitInfo, 200f, RaycastMask) ? hitInfo.collider.GetComponent<OverconBase>() : null);
			if (!(overconBase == HighlightedOvercon))
			{
				if (HighlightedOvercon != null)
				{
					HighlightedOvercon.IsHighlighted = false;
				}
				if (overconBase != null)
				{
					overconBase.IsHighlighted = true;
				}
				HighlightedOvercon = overconBase;
			}
		}
	}
}

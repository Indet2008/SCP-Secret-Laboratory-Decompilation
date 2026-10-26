using System;
using System.Collections.Generic;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class Scp079PingInstance : MonoBehaviour
	{
		public static readonly HashSet<Scp079PingInstance> Instances = new HashSet<Scp079PingInstance>();

		private const float MaxRangeSqr = 3000f;

		[SerializeField]
		private float _destroyTime;

		[SerializeField]
		private Transform _icon;

		[SerializeField]
		private SpriteRenderer _spriteRenderer;

		[SerializeField]
		private AnimationCurve _sizeOverDistance;

		[SerializeField]
		private float _distanceCap;

		[SerializeField]
		private Renderer[] _renderers;

		[SerializeField]
		private AudioSource _src;

		private Vector3 _startPos;

		private bool _wasVisible;

		public Sprite IconSprite
		{
			set
			{
				_spriteRenderer.sprite = value;
			}
		}

		private bool IsVisible
		{
			get
			{
				if (!ReferenceHub.TryGetLocalHub(out var hub))
				{
					return false;
				}
				if (hub.IsSCP())
				{
					return true;
				}
				if (!SpectatorTargetTracker.TryGetTrackedPlayer(out var hub2))
				{
					return false;
				}
				if ((_startPos - MainCameraController.CurrentCamera.position).sqrMagnitude > 3000f)
				{
					return false;
				}
				return hub2.IsSCP();
			}
		}

		public static event Action<Scp079PingInstance> OnSpawned;

		private void Start()
		{
			_startPos = base.transform.position;
			UnityEngine.Object.Destroy(base.gameObject, _destroyTime);
			_wasVisible = true;
			UpdateVisibility();
			Instances.Add(this);
			OnSpawned?.Invoke(this);
		}

		private void OnDestroy()
		{
			Instances.Remove(this);
		}

		private void Update()
		{
			Transform currentCamera = MainCameraController.CurrentCamera;
			float num = Mathf.Max(_distanceCap, Vector3.Distance(currentCamera.position, _icon.position));
			_icon.LookAt(currentCamera);
			_icon.localScale = _sizeOverDistance.Evaluate(num) * num * Vector3.one;
			UpdateVisibility();
		}

		private void OnValidate()
		{
			_renderers = GetComponentsInChildren<Renderer>();
		}

		private void UpdateVisibility()
		{
			if (_wasVisible != IsVisible)
			{
				_src.mute = _wasVisible;
				_wasVisible = !_wasVisible;
				_renderers.ForEach((Renderer x) =>
				{
					x.enabled = _wasVisible;
				});
			}
		}
	}
}

using System;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.GUI;
using UnityEngine;
using UserSettings.ControlsSettings;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public class Scp079MapGui : Scp079GuiElementBase
	{
		[Serializable]
		private struct MapAnimation
		{
			public AnimationCurve Background;

			public AnimationCurve Horizontal;

			public AnimationCurve Vertical;

			public AnimationCurve Compressor;
		}

		[SerializeField]
		private float _animDuration;

		[SerializeField]
		private CanvasGroup _background;

		[SerializeField]
		private CanvasGroup _compressor;

		[SerializeField]
		private RectTransform _scalable;

		[SerializeField]
		private MapAnimation _closeAnim;

		[SerializeField]
		private MapAnimation _openAnim;

		[SerializeField]
		private MonoBehaviour[] _zoneMaps;

		[SerializeField]
		private RectTransform _mapMover;

		[SerializeField]
		private RectTransform _mapScaler;

		private float _animValue;

		private float _prevAnimVal;

		private float _zoom;

		private bool _prevOpen;

		private Scp079CurrentCameraSync _curCamSync;

		private Vector3 _prevOffset;

		private Vector3 _moverPosition;

		private const string AxisX = "Mouse X";

		private const string AxisY = "Mouse Y";

		private const string AxisScroll = "Mouse ScrollWheel";

		private const float MouseSensitivity = 30f;

		private const float SpectatorLerp = 15f;

		public static Scp079Camera HighlightedCamera { get; private set; }

		public static Vector3 SyncVars { get; internal set; }

		private void Update()
		{
			bool isOpen = Scp079ToggleMenuAbilityBase<Scp079MapToggler>.IsOpen;
			float num = Time.deltaTime * (float)(isOpen ? 1 : (-1));
			_animValue = Mathf.Clamp(_animValue + num, 0f, _animDuration);
			if (isOpen)
			{
				if (!_prevOpen)
				{
					OnOpened();
				}
				UpdateOpen();
			}
			else if (_prevOpen)
			{
				HighlightedCamera = null;
			}
			_prevOpen = isOpen;
			if (_prevAnimVal != _animValue)
			{
				EvaluateAll(isOpen, _animValue);
				_prevAnimVal = _animValue;
			}
		}

		private void OnOpened()
		{
			if (!Scp079Role.LocalInstanceActive)
			{
				_moverPosition = (Vector2)SyncVars;
				_mapScaler.localScale = Vector3.one * SyncVars.z;
				return;
			}
			_zoom = 1f;
			_mapScaler.localScale = Vector3.one;
			Scp079Camera currentCamera = _curCamSync.CurrentCamera;
			MonoBehaviour[] zoneMaps = _zoneMaps;
			for (int i = 0; i < zoneMaps.Length; i++)
			{
				if (((IZoneMap)zoneMaps[i]).TryGetCenterTransform(currentCamera, out var center))
				{
					_prevOffset = center;
					break;
				}
			}
			_mapMover.anchoredPosition = _prevOffset;
			_moverPosition = _mapMover.localPosition;
		}

		private void UpdateOpen()
		{
			HighlightedCamera = null;
			bool flag = !Scp079Role.LocalInstanceActive;
			bool flag2 = !Cursor.visible && !flag;
			bool visible = Scp079ToggleMenuAbilityBase<Scp079ScannerMenuToggler>.Visible;
			if (flag2 && !visible)
			{
				float axisRaw = Input.GetAxisRaw("Mouse ScrollWheel");
				_zoom = Mathf.Clamp(_zoom + axisRaw, 0.3f, 2.1f);
				Vector2 vector = new Vector2(Input.GetAxisRaw("Mouse X"), Input.GetAxisRaw("Mouse Y"));
				_moverPosition -= 30f * SensitivitySettings.SensMultiplier * (Vector3)vector / _zoom;
				SyncVars = new Vector3(_moverPosition.x, _moverPosition.y, _zoom);
			}
			if (flag)
			{
				_zoom = SyncVars.z;
				_mapScaler.localScale = Vector3.one * _zoom;
				_moverPosition = Vector3.Lerp(_moverPosition, SyncVars, Time.deltaTime * 15f);
				_mapMover.localPosition = (Vector2)_moverPosition;
			}
			float animInterpolant = Scp079ScannerGui.AnimInterpolant;
			_mapScaler.localScale = Vector3.one * Mathf.Lerp(_zoom, Scp079ScannerGui.MapZoom, animInterpolant);
			_mapMover.localPosition = Vector3.Lerp((Vector2)_moverPosition, Scp079ScannerGui.MapPos, animInterpolant);
			MonoBehaviour[] zoneMaps;
			if (!visible && (flag2 | flag))
			{
				zoneMaps = _zoneMaps;
				for (int i = 0; i < zoneMaps.Length; i++)
				{
					if (((IZoneMap)zoneMaps[i]).TryGetCamera(out var target))
					{
						HighlightedCamera = target;
					}
				}
			}
			Scp079Camera currentCamera = _curCamSync.CurrentCamera;
			zoneMaps = _zoneMaps;
			for (int i = 0; i < zoneMaps.Length; i++)
			{
				((IZoneMap)zoneMaps[i]).UpdateOpened(currentCamera);
			}
		}

		private void EvaluateAll(bool open, float val)
		{
			MapAnimation mapAnimation = (open ? _openAnim : _closeAnim);
			_background.alpha = mapAnimation.Background.Evaluate(val);
			_compressor.alpha = mapAnimation.Compressor.Evaluate(val);
			_scalable.localScale = new Vector3(mapAnimation.Horizontal.Evaluate(val), mapAnimation.Vertical.Evaluate(val), 1f);
		}

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
			MonoBehaviour[] zoneMaps = _zoneMaps;
			for (int i = 0; i < zoneMaps.Length; i++)
			{
				((IZoneMap)zoneMaps[i]).Generate();
			}
		}
	}
}

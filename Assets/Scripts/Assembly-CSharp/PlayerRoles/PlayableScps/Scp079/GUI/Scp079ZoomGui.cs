using PlayerRoles.PlayableScps.Scp079.Cameras;
using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079ZoomGui : Scp079GuiElementBase
	{
		private const float RoundingAccuracy = 10f;

		private Scp079CurrentCameraSync _curCamSync;

		private string _format;

		[SerializeField]
		private Vector2 _minPos;

		[SerializeField]
		private Vector2 _maxPos;

		[SerializeField]
		private RectTransform _slider;

		[SerializeField]
		private TextMeshProUGUI _text;

		[SerializeField]
		private GameObject _root;

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			_format = Translations.Get(Scp079HudTranslation.Zoom);
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
		}

		private void Update()
		{
			if (_curCamSync.TryGetCurrentCamera(out var cam))
			{
				CameraZoomAxis zoomAxis = cam.ZoomAxis;
				float num = Mathf.InverseLerp(zoomAxis.MinValue, zoomAxis.MaxValue, zoomAxis.CurValue);
				float num2 = Mathf.Round(10f * zoomAxis.CurrentZoom) / 10f;
				if (num <= 0f)
				{
					_root.SetActive(value: false);
					return;
				}
				_slider.localPosition = Vector2.Lerp(_minPos, _maxPos, num);
				_text.text = string.Format(_format, num2.ToString("0.0"));
				_root.SetActive(value: true);
			}
		}
	}
}

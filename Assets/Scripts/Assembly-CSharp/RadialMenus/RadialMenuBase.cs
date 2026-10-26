using UnityEngine;
using UnityEngine.UI;

namespace RadialMenus
{
	public abstract class RadialMenuBase : MonoBehaviour
	{
		private int _slotsNum;

		private float _slotsAngleStep;

		[SerializeField]
		private RadialMenuSettings _settings;

		[SerializeField]
		private Vector2 _ringWidth = new Vector2(0.41f, 1.1f);

		[SerializeField]
		private Image _slotTemplate;

		[SerializeField]
		protected Image RingImage;

		protected Image[] Highlights = new Image[32];

		public abstract int Slots { get; }

		public int HighlightedSlot { get; private set; }

		protected Image GetHighlightSafe(int index)
		{
			Image image = Highlights[index];
			if (image != null)
			{
				return image;
			}
			image = Object.Instantiate(_slotTemplate, RingImage.transform);
			Highlights[index] = image;
			return image;
		}

		protected virtual void OnSlotsNumberChanged(int prev, int cur)
		{
			for (int i = 0; i < prev; i++)
			{
				Highlights[i].enabled = false;
			}
			for (int j = 0; j < cur; j++)
			{
				Image highlightSafe = GetHighlightSafe(j);
				highlightSafe.rectTransform.SetAsFirstSibling();
				highlightSafe.rectTransform.localPosition = Vector3.zero;
				highlightSafe.rectTransform.localEulerAngles = _slotsAngleStep * (float)j * Vector3.back;
				highlightSafe.sprite = _settings.HighlightTemplates[cur];
				highlightSafe.enabled = true;
			}
			RingImage.sprite = _settings.MainRings[cur];
		}

		protected bool InRingRange(out float angle)
		{
			float num = (float)Screen.width / (float)Screen.height;
			Vector2 vector = new Vector2(Mathf.Lerp(-1f, 1f, Mathf.Clamp01(Input.mousePosition.x / (float)Screen.width)) * num, Mathf.Lerp(-1f, 1f, Input.mousePosition.y / (float)Screen.height));
			angle = Vector2.Angle(Vector2.up, vector.normalized);
			if (vector.x < 0f)
			{
				angle = 360f - angle;
			}
			float magnitude = vector.magnitude;
			if (magnitude < _ringWidth.y)
			{
				return magnitude > _ringWidth.x;
			}
			return false;
		}

		protected virtual void Update()
		{
			int num = Mathf.Clamp(Slots, 1, _settings.HighlightTemplates.Length + 1);
			if (num != _slotsNum)
			{
				int slotsNum = _slotsNum;
				_slotsNum = num;
				_slotsAngleStep = 360f / (float)num;
				OnSlotsNumberChanged(slotsNum, num);
			}
			if (InRingRange(out var angle))
			{
				HighlightedSlot = 0;
				while (angle > _slotsAngleStep)
				{
					angle -= _slotsAngleStep;
					HighlightedSlot++;
				}
			}
			else
			{
				HighlightedSlot = -1;
			}
		}
	}
}

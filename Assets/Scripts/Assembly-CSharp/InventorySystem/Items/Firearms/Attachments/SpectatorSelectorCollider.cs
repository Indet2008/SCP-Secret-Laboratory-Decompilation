using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Firearms.Attachments
{
	public class SpectatorSelectorCollider : MonoBehaviour, IAttachmentSelectorButton
	{
		private const float DefaultColor = 0.7f;

		private const float CurrentColor = 1f;

		private const float LerpSpeed = 12f;

		[SerializeField]
		private RawImage _image;

		[SerializeField]
		private SpectatorAttachmentSelector _selector;

		private Firearm _firearm;

		private AttachmentSlot _mySlot;

		public RectTransform RectTransform => _image.rectTransform;

		public byte ButtonId { get; set; }

		public void Setup(Texture icon, AttachmentSlot slot, Vector2? pos, Firearm fa)
		{
			if (icon != null)
			{
				Vector2 sizeDelta = new Vector2(icon.width, icon.height);
				_firearm = fa;
				_mySlot = slot;
				_image.texture = icon;
				_image.rectTransform.sizeDelta = sizeDelta;
				if (pos.HasValue)
				{
					_image.rectTransform.localPosition = pos.Value;
				}
			}
			else
			{
				_image.rectTransform.sizeDelta = Vector2.zero;
			}
		}

		public void Click()
		{
			_selector.ProcessCollider(ButtonId);
		}

		public void Hover(bool isHovering)
		{
			if (isHovering)
			{
				_selector.ShowStats(ButtonId);
			}
			else
			{
				_selector.ShowStats(-1);
			}
		}

		public void UpdateColors(AttachmentSlot slot)
		{
			if (base.gameObject.activeSelf)
			{
				bool flag = slot == _mySlot || (_firearm != null && ButtonId < _firearm.Attachments.Length && _firearm.Attachments[ButtonId].IsEnabled);
				_image.color = Color.Lerp(_image.color, Color.Lerp(Color.black, Color.white, flag ? 1f : 0.7f), 12f * Time.deltaTime);
			}
		}
	}
}

using Interactables;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Firearms.Attachments
{
	public class WorkstationSelectorCollider : InteractableCollider, IAttachmentSelectorButton
	{
		private const float HighlightColor = 0.71f;

		private const float DefaultColor = 0.38f;

		private const float CurrentColor = 0.54f;

		private const float LerpSpeed = 12f;

		private const float SizeRatio = 1f;

		private const float MinColliderWidth = 40f;

		private const float MinColliderDepth = 0.2f;

		[SerializeField]
		private BoxCollider _collider;

		[SerializeField]
		private RawImage _image;

		private Firearm _firearm;

		private AttachmentSlot _mySlot;

		private bool _prevHighlighted;

		public RectTransform RectTransform => _image.rectTransform;

		public byte ButtonId
		{
			get
			{
				return ColliderId;
			}
			set
			{
				ColliderId = value;
			}
		}

		public void Setup(Texture icon, AttachmentSlot slot, Vector2? pos, Firearm fa)
		{
			if (icon != null)
			{
				_firearm = fa;
				_mySlot = slot;
				_image.texture = icon;
				_image.rectTransform.sizeDelta = new Vector2(icon.width, icon.height);
				if (pos.HasValue)
				{
					_image.rectTransform.localPosition = pos.Value;
				}
			}
			else
			{
				_image.rectTransform.sizeDelta = Vector2.zero;
				_collider.size = Vector3.zero;
			}
		}

		public void UpdateColors(AttachmentSlot slot)
		{
			if (!base.gameObject.activeSelf)
			{
				return;
			}
			Vector2 sizeDelta = _image.rectTransform.sizeDelta;
			_collider.size = new Vector3(Mathf.Max(sizeDelta.x * 1f, 40f), Mathf.Max(sizeDelta.y * 1f, 40f), 0.2f);
			bool flag = CenterScreenRaycast.LastRaycastHit.collider == _collider && CenterScreenRaycast.LastRaycastHit.distance < 3.35f;
			bool flag2 = slot == _mySlot || (_firearm != null && ColliderId < _firearm.Attachments.Length && _firearm.Attachments[ColliderId].IsEnabled);
			if (_prevHighlighted != flag && ButtonId < _firearm.Attachments.Length && Target.TryGetComponent<AttachmentSelectorBase>(out var component))
			{
				if (flag)
				{
					component.ShowStats(ButtonId);
				}
				else
				{
					component.ShowStats(-1);
				}
				_prevHighlighted = flag;
			}
			float t = (flag ? 0.71f : (flag2 ? 0.54f : 0.38f));
			_image.color = Color.Lerp(_image.color, Color.Lerp(Color.black, Color.white, t), 12f * Time.deltaTime);
		}
	}
}

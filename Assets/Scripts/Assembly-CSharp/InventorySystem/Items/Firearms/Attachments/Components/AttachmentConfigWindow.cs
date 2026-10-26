using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public abstract class AttachmentConfigWindow : MonoBehaviour
	{
		private bool _wasActive;

		[SerializeField]
		private RectTransform _exitTransform;

		public Action OnDestroyed;

		protected AttachmentSelectorBase Selector { get; private set; }

		protected Attachment Attachment { get; private set; }

		private void DestroySelf()
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}

		private bool Validate()
		{
			if (Attachment == null)
			{
				return false;
			}
			if (_wasActive)
			{
				if (!Attachment.IsEnabled)
				{
					return false;
				}
				Firearm firearm = Attachment.Firearm;
				if (firearm.HasOwner && firearm.OwnerInventory.CurInstance != firearm)
				{
					return false;
				}
			}
			return true;
		}

		protected virtual void OnDestroy()
		{
			AttachmentSelectorBase selector = Selector;
			selector.OnSummaryToggled = (Action)Delegate.Remove(selector.OnSummaryToggled, new Action(DestroySelf));
			OnDestroyed?.Invoke();
		}

		protected virtual void OnDisable()
		{
			DestroySelf();
		}

		protected virtual void Update()
		{
			if (!Validate())
			{
				DestroySelf();
				return;
			}
			_wasActive = Attachment.IsEnabled;
			SafeUpdate();
		}

		protected virtual void SafeUpdate()
		{
		}

		public virtual void Setup(AttachmentSelectorBase selector, Attachment attachment, RectTransform transformToFit)
		{
			Selector = selector;
			Attachment = attachment;
			AttachmentSelectorBase selector2 = Selector;
			selector2.OnSummaryToggled = (Action)Delegate.Combine(selector2.OnSummaryToggled, new Action(DestroySelf));
			Selector.RegisterAction(_exitTransform, (Vector2 _) =>
			{
				DestroySelf();
			});
			SetLayout(transformToFit);
		}

		protected virtual void SetLayout(RectTransform transformToFit)
		{
			RectTransform component = GetComponent<RectTransform>();
			float num = transformToFit.sizeDelta.y / component.sizeDelta.y;
			component.localPosition = transformToFit.localPosition;
			component.localRotation = Quaternion.identity;
			component.localScale = Vector3.one * num;
			component.sizeDelta = transformToFit.sizeDelta / num;
		}
	}
}

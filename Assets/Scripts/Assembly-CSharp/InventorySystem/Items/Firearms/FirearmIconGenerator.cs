using System;
using InventorySystem.Items.Firearms.Attachments.Components;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Firearms
{
	public static class FirearmIconGenerator
	{
		public static Vector2 GenerateIcon(this Firearm firearm, RawImage rootImage, RawImage[] imagePool, Vector2 maxSize, Func<int, Color> colorFunction)
		{
			Bounds bounds = firearm.GenerateIcon(rootImage, imagePool, colorFunction);
			RectTransform rectTransform = rootImage.rectTransform;
			float num = Mathf.Min(maxSize.y / bounds.size.y, maxSize.x / bounds.size.x);
			rectTransform.localScale = Vector3.one * num;
			rectTransform.localPosition = -bounds.center * num;
			return bounds.size * num;
		}

		public static Bounds GenerateIcon(this Firearm firearm, RawImage rootImage, RawImage[] imagePool, Func<int, Color> colorFunction)
		{
			int num = 0;
			int num2 = firearm.Attachments.Length;
			rootImage.texture = firearm.BodyIconTexture;
			rootImage.SetNativeSize();
			for (int i = 0; i < num2; i++)
			{
				if (firearm.Attachments[i].IsEnabled && firearm.Attachments[i] is IDisplayableAttachment displayableAttachment)
				{
					RawImage obj = imagePool[num];
					obj.gameObject.SetActive(value: true);
					obj.texture = displayableAttachment.Icon;
					obj.SetNativeSize();
					obj.color = colorFunction(i);
					Vector2 iconOffset = displayableAttachment.IconOffset;
					if (firearm.Attachments[Mathf.Clamp(displayableAttachment.ParentId, 0, num2)].IsEnabled)
					{
						iconOffset += displayableAttachment.ParentOffset;
					}
					obj.rectTransform.localPosition = iconOffset;
					num++;
				}
			}
			for (int j = num; j < imagePool.Length; j++)
			{
				imagePool[j].gameObject.SetActive(value: false);
			}
			RectTransform rectTransform = rootImage.rectTransform;
			Bounds b = new Bounds(rectTransform.localPosition, Vector3.zero);
			EncapsulateRect(ref b, rectTransform);
			for (int k = 0; k < num; k++)
			{
				EncapsulateRect(ref b, imagePool[k].rectTransform);
			}
			return b;
		}

		private static void EncapsulateRect(ref Bounds b, RectTransform rct)
		{
			Vector2 vector = rct.sizeDelta / 2f;
			b.Encapsulate(rct.localPosition + Vector3.up * vector.y + Vector3.left * vector.x);
			b.Encapsulate(rct.localPosition + Vector3.down * vector.y + Vector3.right * vector.x);
		}
	}
}

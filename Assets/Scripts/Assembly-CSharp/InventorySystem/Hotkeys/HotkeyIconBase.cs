using System.Collections.Generic;
using InventorySystem.GUI;
using InventorySystem.Hotkeys.Customization;
using InventorySystem.Items;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Hotkeys
{
	public abstract class HotkeyIconBase : MonoBehaviour
	{
		private class HighlightHandler
		{
			public bool IsPlaying;

			public float Timer;
		}

		[SerializeField]
		protected Image Outline;

		[SerializeField]
		protected Image HighlightImage;

		[SerializeField]
		protected TextMeshProUGUI KeycodeText;

		private KeyCode _prevKeyCode;

		private Color _highlightTransparentColor;

		private static readonly AnimationCurve HighlightAnimation = new AnimationCurve(new Keyframe(0f, 0f, 0f, 0f, 0f, 0.3f)
		{
			weightedMode = WeightedMode.Both
		}, new Keyframe(0.15f, 0.8f, 0.2f, 0.2f, 0.3f, 0.2f)
		{
			weightedMode = WeightedMode.Both
		}, new Keyframe(1f, 0f, 0f, 0f, 1f, 0f)
		{
			weightedMode = WeightedMode.Both
		});

		private static readonly Dictionary<KeyCode, HighlightHandler> ActiveHighlights = new Dictionary<KeyCode, HighlightHandler>();

		public KeyCode Key
		{
			get
			{
				return _prevKeyCode;
			}
			set
			{
				if (value != _prevKeyCode)
				{
					_prevKeyCode = value;
					KeycodeText.text = new ReadableKeyCode(value).ShortVersion;
				}
			}
		}

		public abstract void SetItem(ItemBase item);

		public abstract bool CheckCompatibility(ItemBase item, HotkeyApperance apperance);

		public void UpdateAnimations()
		{
			if (ActiveHighlights.TryGetValue(_prevKeyCode, out var value) && value.IsPlaying)
			{
				if (!InventoryGuiController.InventoryVisible)
				{
					value.Timer += Time.deltaTime;
				}
				HighlightImage.enabled = true;
				Color color = Outline.color;
				float t = Mathf.Clamp01(HighlightAnimation.Evaluate(value.Timer));
				HighlightImage.color = Color.Lerp(_highlightTransparentColor, color, t);
				if (!(1f >= value.Timer))
				{
					HighlightImage.enabled = false;
					value.IsPlaying = false;
				}
			}
		}

		public void PlayHighlightAnimation()
		{
			HighlightHandler orAdd = ActiveHighlights.GetOrAdd(_prevKeyCode, () => new HighlightHandler());
			orAdd.Timer = 0f;
			orAdd.IsPlaying = true;
		}

		public void CancelHighlightAnimation()
		{
			HighlightImage.color = _highlightTransparentColor;
			HighlightImage.enabled = false;
			if (ActiveHighlights.TryGetValue(_prevKeyCode, out var value))
			{
				value.IsPlaying = false;
			}
		}

		public virtual void SetColors(Color color)
		{
			Outline.color = color;
			KeycodeText.color = color;
			_highlightTransparentColor = new Color(color.r, color.g, color.b, 0f);
		}
	}
}

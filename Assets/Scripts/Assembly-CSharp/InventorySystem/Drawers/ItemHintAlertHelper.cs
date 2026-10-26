using System.Text;
using InventorySystem.GUI;
using InventorySystem.Items;
using UnityEngine;

namespace InventorySystem.Drawers
{
	public class ItemHintAlertHelper
	{
		private static readonly StringBuilder SbNonAlloc = new StringBuilder();

		private readonly string _content;

		private readonly float _fadeTransitionDur;

		private readonly float _fadeInDelay;

		private readonly float _fadeOutDelay;

		private const float DefaultFadeTransition = 0.3f;

		private const float DefaultFadeInDelay = 1f;

		private float _equipElapsed;

		private bool _aborted;

		private bool _forceHidden;

		public AlertContent Alert
		{
			get
			{
				if (_forceHidden)
				{
					return default;
				}
				if (_equipElapsed < _fadeInDelay)
				{
					return default;
				}
				if (_equipElapsed > _fadeOutDelay + _fadeTransitionDur)
				{
					return default;
				}
				float num = Mathf.InverseLerp(_fadeInDelay, _fadeInDelay + _fadeTransitionDur, _equipElapsed);
				float num2 = Mathf.InverseLerp(_fadeOutDelay + _fadeTransitionDur, _fadeOutDelay, _equipElapsed);
				float alpha = num * num2;
				return new AlertContent(_content, alpha);
			}
		}

		public void Update(ReferenceHub interactingUser)
		{
			Update(interactingUser.HasBlock(BlockedInteraction.ItemPrimaryAction));
		}

		public void Update(bool forceHide)
		{
			if (!_aborted)
			{
				_forceHidden = forceHide;
				_equipElapsed += Time.deltaTime;
				if (!(_equipElapsed < _fadeOutDelay + _fadeTransitionDur))
				{
					Hide();
				}
			}
		}

		public void Hide()
		{
			_aborted = true;
			_equipElapsed = _fadeOutDelay + _fadeTransitionDur + 1f;
		}

		public void Reset()
		{
			_aborted = false;
			_equipElapsed = 0f;
		}

		public ItemHintAlertHelper(InventoryGuiTranslation translation, ActionName? key, float fadeTransitionDuration = 0.3f, float fadeInDelay = 1f, float fadeOutDelay = 6f)
		{
			_content = ProcessTranslation(translation, key);
			_fadeTransitionDur = fadeTransitionDuration;
			_fadeInDelay = fadeInDelay;
			_fadeOutDelay = fadeOutDelay;
		}

		public ItemHintAlertHelper(InventoryGuiTranslation translation0, ActionName? key0, InventoryGuiTranslation translation1, ActionName? key1, float fadeTransitionDuration = 0.3f, float fadeInDelay = 1f, float fadeOutDelay = 8f)
		{
			SbNonAlloc.Clear();
			SbNonAlloc.AppendLine(ProcessTranslation(translation0, key0));
			SbNonAlloc.AppendLine(ProcessTranslation(translation1, key1));
			_content = SbNonAlloc.ToString();
			_fadeTransitionDur = fadeTransitionDuration;
			_fadeInDelay = fadeInDelay;
			_fadeOutDelay = fadeOutDelay;
		}

		public ItemHintAlertHelper(InventoryGuiTranslation translation0, ActionName? key0, InventoryGuiTranslation translation1, ActionName? key1, InventoryGuiTranslation translation2, ActionName? key2, float fadeTransitionDuration = 0.3f, float fadeInDelay = 1f, float fadeOutDelay = 10f)
		{
			SbNonAlloc.Clear();
			SbNonAlloc.AppendLine(ProcessTranslation(translation0, key0));
			SbNonAlloc.AppendLine(ProcessTranslation(translation1, key1));
			SbNonAlloc.AppendLine(ProcessTranslation(translation2, key2));
			_content = SbNonAlloc.ToString();
			_fadeTransitionDur = fadeTransitionDuration;
			_fadeInDelay = fadeInDelay;
			_fadeOutDelay = fadeOutDelay;
		}

		private static string ProcessTranslation(InventoryGuiTranslation translation, ActionName? key)
		{
			if (!TranslationReader.EverLoaded)
			{
				return string.Empty;
			}
			if (!key.HasValue)
			{
				return Translations.Get(translation);
			}
			return string.Format(arg0: $"${new ReadableKeyCode(key.Value)}$", format: Translations.Get(translation));
		}
	}
}

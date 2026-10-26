using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace UserSettings.GUIElements
{
	public class UserSettingsEntryDescription : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
	{
		private bool _potentiallyCurrent;

		private TextLanguageReplacer _tlr;

		private Type _secondaryTranslationType;

		private Enum _secondaryTranslationValue;

		public static UserSettingsEntryDescription CurrentDescription { get; private set; }

		public virtual string Text
		{
			get
			{
				if (UsesReplacer)
				{
					return _tlr.DisplayText;
				}
				if (_secondaryTranslationType == null)
				{
					return string.Empty;
				}
				Type secondaryTranslationType = _secondaryTranslationType;
				int index = ((IConvertible)_secondaryTranslationValue).ToInt32((IFormatProvider)null);
				if (!Translations.TryGet(secondaryTranslationType, index, out var str))
				{
					return _secondaryTranslationValue.ToString();
				}
				return str;
			}
		}

		public bool UsesReplacer { get; private set; }

		public void SetTranslation<T>(T translation) where T : Enum
		{
			UsesReplacer = false;
			_secondaryTranslationType = typeof(T);
			_secondaryTranslationValue = translation;
		}

		public void OnPointerEnter(PointerEventData eventData)
		{
			_potentiallyCurrent = true;
			CurrentDescription = this;
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			Deselect();
		}

		private void Awake()
		{
			UsesReplacer = TryGetComponent<TextLanguageReplacer>(out _tlr);
		}

		private void OnDisable()
		{
			Deselect();
		}

		private void Deselect()
		{
			if (_potentiallyCurrent && !(CurrentDescription != this))
			{
				CurrentDescription = null;
				_potentiallyCurrent = false;
			}
		}
	}
}

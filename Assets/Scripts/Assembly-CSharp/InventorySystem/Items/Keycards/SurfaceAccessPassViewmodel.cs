using TMPro;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class SurfaceAccessPassViewmodel : KeycardViewmodel
	{
		[SerializeField]
		private TMP_Text _labelText;

		[SerializeField]
		private int _maxCharacters;

		[SerializeField]
		private int _fixedUpdatesDelay;

		[SerializeField]
		private int _startMargin;

		[SerializeField]
		private int _endMargin;

		[SerializeField]
		private Renderer _renderer;

		[SerializeField]
		private Material _usedMaterial;

		[SerializeField]
		private float _materialReplaceDelay;

		private int _remainingDelay;

		private int _textLength;

		private bool _replaceMaterialWhenReady;

		private int _startCharacter;

		protected override void PlayUseAnimation(bool success)
		{
			if (success)
			{
				_replaceMaterialWhenReady = true;
				base.PlayUseAnimation(success);
			}
		}

		public override void InitAny()
		{
			base.InitAny();
			SetText(TranslatedLabelDetail.KeycardLabelTranslation.SurfaceAccessPassNormal);
		}

		private void Update()
		{
			if (_replaceMaterialWhenReady)
			{
				_materialReplaceDelay -= Time.deltaTime;
				if (!(_materialReplaceDelay > 0f))
				{
					_renderer.sharedMaterial = _usedMaterial;
					SetText(TranslatedLabelDetail.KeycardLabelTranslation.SurfaceAccessPassUsed);
					_replaceMaterialWhenReady = false;
				}
			}
		}

		private void SetText(TranslatedLabelDetail.KeycardLabelTranslation translation)
		{
			string text = Translations.Get(translation);
			_textLength = text.Length;
			_startCharacter = -_startMargin;
			_labelText.text = text;
			_labelText.firstVisibleCharacter = 0;
			_labelText.maxVisibleCharacters = _maxCharacters;
		}

		private void FixedUpdate()
		{
			if (--_remainingDelay <= 0)
			{
				if (_startCharacter > _textLength + _endMargin)
				{
					_startCharacter = -_startMargin;
				}
				else
				{
					_startCharacter++;
				}
				int num = Mathf.Clamp(_startCharacter, 0, _textLength);
				_labelText.firstVisibleCharacter = num;
				_labelText.maxVisibleCharacters = _maxCharacters + num;
				_remainingDelay = _fixedUpdatesDelay;
			}
		}
	}
}

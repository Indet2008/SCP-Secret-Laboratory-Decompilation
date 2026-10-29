using System;
using System.Collections.Generic;
using System.Text;
using TMPro;
using UnityEngine;

namespace OperationalGuide
{
	public class SecretPhrase : MonoBehaviour
	{
		public Action<bool> OnSecretChanged;

		public GameObject Secret;

		public GameObject Default;

		public GameObject DefaultPannable;

		public GameObject SecretPannable;

		public string Phrase;

		public List<TextMeshProUGUI> TextToReplace = new List<TextMeshProUGUI>();

		public bool CaseSensitive = true;

		private List<string> _orginalText = new List<string>();

		private int _phraseMatchIndex;

		private void Update()
		{
			if (!Secret.activeSelf)
			{
				string inputString = Input.inputString;
				for (int i = 0; i < inputString.Length; i++)
				{
					CheckForSecretWord(inputString[i]);
				}
			}
		}

		// Typing the phrase highlights the matched part in the page texts; completing it reveals the secret.
		private void CheckForSecretWord(char character)
		{
			char c = Phrase[_phraseMatchIndex];
			if (!CaseSensitive)
			{
				c = char.ToUpperInvariant(c);
				character = char.ToUpperInvariant(character);
			}
			if (c == character)
			{
				StringBuilder stringBuilder = new StringBuilder("<color=\"red\">", 16);
				for (int i = 0; i <= Phrase.Length - 1; i++)
				{
					stringBuilder.Append(Phrase[i]);
					if (i == _phraseMatchIndex)
					{
						stringBuilder.Append("</color>");
					}
				}
				for (int j = 0; j < TextToReplace.Count; j++)
				{
					TextToReplace[j].text = _orginalText[j].Replace(Phrase, stringBuilder.ToString());
				}
				_phraseMatchIndex++;
				if (_phraseMatchIndex >= Phrase.Length)
				{
					_phraseMatchIndex = 0;
					SetSecretState(state: true);
				}
			}
			else
			{
				_phraseMatchIndex = 0;
				SetOriginalText();
			}
		}

		private void SetSecretState(bool state)
		{
			if (Secret != null)
			{
				Secret.SetActive(state);
			}
			if (SecretPannable != null)
			{
				SecretPannable.SetActive(state);
			}
			if (Default != null)
			{
				Default.SetActive(!state);
			}
			if (DefaultPannable != null)
			{
				DefaultPannable.SetActive(!state);
			}
			OnSecretChanged?.Invoke(state);
		}

		private void OnDisable()
		{
			SetOriginalText();
			SetSecretState(state: false);
			_phraseMatchIndex = 0;
		}

		private void OnEnable()
		{
			_orginalText.Clear();
			foreach (TextMeshProUGUI item in TextToReplace)
			{
				_orginalText.Add(item.text);
			}
			if (Secret != null)
			{
				Secret.SetActive(value: false);
			}
			if (SecretPannable != null)
			{
				SecretPannable.SetActive(value: false);
			}
			if (Default != null)
			{
				Default.SetActive(value: true);
			}
			if (DefaultPannable != null)
			{
				DefaultPannable.SetActive(value: true);
			}
			_phraseMatchIndex = 0;
		}

		private void SetOriginalText()
		{
			for (int i = 0; i < TextToReplace.Count && i < _orginalText.Count; i++)
			{
				TextToReplace[i].text = _orginalText[i];
			}
		}
	}
}

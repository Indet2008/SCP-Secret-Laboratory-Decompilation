namespace OperationalGuide
{
	public class SecretPhrase : global::UnityEngine.MonoBehaviour
	{
		public global::System.Action<bool> OnSecretChanged;

		public global::UnityEngine.GameObject Secret;

		public global::UnityEngine.GameObject Default;

		public global::UnityEngine.GameObject DefaultPannable;

		public global::UnityEngine.GameObject SecretPannable;

		public string Phrase;

		public global::System.Collections.Generic.List<global::TMPro.TextMeshProUGUI> TextToReplace;

		public bool CaseSensitive;

		private global::System.Collections.Generic.List<string> _orginalText;

		private int _phraseMatchIndex;

		private void Update()
		{
		}

		private void CheckForSecretWord(char letter)
		{
		}

		public void SetSecretState(bool status)
		{
		}

		private void OnDisable()
		{
		}

		private void OnEnable()
		{
		}

		public void SetOriginalText()
		{
		}

		public SecretPhrase()
		{
		}
	}
}

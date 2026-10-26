namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079IntroCutscene : Scp079GuiElementBase
	{
		[global::System.Serializable]
		private class Entry
		{
			[global::UnityEngine.Multiline]
			[global::UnityEngine.SerializeField]
			private string _text;

			[global::UnityEngine.SerializeField]
			private float _timeToType;

			[global::UnityEngine.SerializeField]
			private float _duration;

			[global::UnityEngine.SerializeField]
			private bool _clear;

			[global::UnityEngine.SerializeField]
			private global::UnityEngine.AudioClip _sound;

			private string _textToPrint;

			private float _elapsed;

			private float _lettersPerSecond;

			private int _lettersOffset;

			private int _totalWritten;

			private bool _isSetup;

			private bool _tagOpen;

			private const char NewLineSymbol = '$';

			private const char OpenTagSymbol = '<';

			private const char CloseTagSymbol = '>';

			public float RemainingDuration
			{
				get
				{
					return default;
				}
				set
				{
				}
			}

			public void AppendText(global::System.Text.StringBuilder sb, global::UnityEngine.Transform soundTr)
			{
			}

			private void Setup(global::System.Text.StringBuilder sb, global::UnityEngine.Transform t)
			{
			}

			private void AppendCharacters(global::System.Text.StringBuilder sb)
			{
			}

			public Entry()
			{
			}
		}

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079IntroCutscene.Entry[] _entries;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _text;

		[global::UnityEngine.SerializeField]
		private float _normalSpeed;

		[global::UnityEngine.SerializeField]
		private float _fastIntroSpeed;

		[global::UnityEngine.SerializeField]
		private float _minSkipTime;


		public static bool IsPlaying { get; private set; }
	}
}

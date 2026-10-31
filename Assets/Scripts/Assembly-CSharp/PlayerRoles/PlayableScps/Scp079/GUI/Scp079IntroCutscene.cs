using System.Diagnostics;
using System.Text;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	// Restored from the client build (IL2CPP): typewriter intro shown to the local SCP-079, skippable after a delay;
	// when it ends the regular role start screen is shown.
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
					return _timeToType + _duration - _elapsed;
				}
				set
				{
					_elapsed = _timeToType + _duration - value;
				}
			}

			public void Advance(float time)
			{
				_elapsed = Mathf.Min(_elapsed + time, _timeToType + _duration);
			}

			public void AppendText(StringBuilder sb, Transform soundTr)
			{
				if (!_isSetup)
				{
					Setup(sb, soundTr);
				}
				AppendCharacters(sb);
			}

			private void Setup(StringBuilder sb, Transform t)
			{
				_isSetup = true;
				if (_clear)
				{
					sb.Clear();
				}
				_textToPrint = _text ?? string.Empty;
				_lettersPerSecond = _timeToType > 0f ? _textToPrint.Length / _timeToType : float.MaxValue;
				_lettersOffset = 0;
				_totalWritten = 0;
				_tagOpen = false;
				if (_sound != null)
				{
					AudioPooling.AudioSourcePoolManager.Play2DWithParent(_sound, t);
				}
			}

			private void AppendCharacters(StringBuilder sb)
			{
				int target = Mathf.Min(_textToPrint.Length, _lettersPerSecond == float.MaxValue ? _textToPrint.Length : Mathf.FloorToInt(_lettersPerSecond * _elapsed));
				while (_lettersOffset < _textToPrint.Length && (_totalWritten < target || _tagOpen))
				{
					char c = _textToPrint[_lettersOffset];
					_lettersOffset++;
					switch (c)
					{
					case OpenTagSymbol:
						_tagOpen = true;
						sb.Append(c);
						continue;
					case CloseTagSymbol:
						_tagOpen = false;
						sb.Append(c);
						continue;
					case NewLineSymbol:
						sb.Append('\n');
						break;
					default:
						sb.Append(c);
						break;
					}
					if (!_tagOpen)
					{
						_totalWritten++;
					}
				}
			}

			public Entry()
			{
			}
		}

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

		private readonly Stopwatch _stopwatch = new Stopwatch();

		private readonly StringBuilder _sb = new StringBuilder();

		private int _curEntry;

		private float _speed;

		private Scp079LostSignalHandler _lostSignalHandler;

		public static bool IsPlaying { get; private set; }

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			if (!role.IsLocalPlayer || _entries == null || _entries.Length == 0)
			{
				base.gameObject.SetActive(false);
				return;
			}
			_stopwatch.Restart();
			_curEntry = 0;
			_sb.Clear();
			IsPlaying = true;
			if (role.SubroutineModule.TryGetSubroutine(out _lostSignalHandler))
			{
				_lostSignalHandler.OnStatusChanged += StopPlaying;
			}
		}

		private void Start()
		{
			_speed = _normalSpeed > 0f ? _normalSpeed : 1f;
		}

		private void OnDestroy()
		{
			if (_lostSignalHandler != null)
			{
				_lostSignalHandler.OnStatusChanged -= StopPlaying;
			}
			IsPlaying = false;
		}

		private void Update()
		{
			if (!IsPlaying)
			{
				return;
			}
			if (CheckSkipping() || _curEntry >= _entries.Length)
			{
				StopPlaying();
				return;
			}
			Entry entry = _entries[_curEntry];
			entry.Advance(Time.deltaTime * _speed);
			entry.AppendText(_sb, base.transform);
			_text.text = _sb.ToString();
			if (entry.RemainingDuration <= 0f)
			{
				_curEntry++;
			}
		}

		private void StopPlaying()
		{
			if (!IsPlaying)
			{
				return;
			}
			IsPlaying = false;
			StartScreen.Show(base.Role);
			base.gameObject.SetActive(false);
		}

		private bool CheckSkipping()
		{
			if (_stopwatch.Elapsed.TotalSeconds < _minSkipTime || !Input.anyKeyDown)
			{
				return false;
			}
			if (_allKeyCodes == null)
			{
				_allKeyCodes = (KeyCode[])global::System.Enum.GetValues(typeof(KeyCode));
			}
			KeyCode[] allKeyCodes = _allKeyCodes;
			for (int i = 0; i < allKeyCodes.Length; i++)
			{
				if (CheckKey(allKeyCodes[i]))
				{
					return true;
				}
			}
			return false;
		}

		private static KeyCode[] _allKeyCodes;

		private bool CheckKey(KeyCode key)
		{
			if (!Input.GetKeyDown(key))
			{
				return false;
			}
			if (key >= KeyCode.Mouse0 && key <= KeyCode.Mouse6)
			{
				return false;
			}
			if (ToggleableMenus.ToggleableMenuController.AnyEnabled)
			{
				return false;
			}
			NewInput.ActionDefinition[] definedActions = NewInput.DefinedActions;
			foreach (NewInput.ActionDefinition actionDefinition in definedActions)
			{
				if (NewInput.GetKey(actionDefinition.Name) == key && (actionDefinition.Category == ActionCategory.Communication || actionDefinition.Category == ActionCategory.System))
				{
					return false;
				}
			}
			return true;
		}

		[ContextMenu("Print total time")]
		private void PrintTotalTime()
		{
			UnityEngine.Debug.Log(string.Format("Total (unscaled) cutscene time is {0}s", System.Linq.Enumerable.Sum(_entries, (Entry x) => x.RemainingDuration)));
		}
	}
}

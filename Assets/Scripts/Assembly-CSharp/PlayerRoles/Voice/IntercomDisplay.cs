using System.Linq;
using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

namespace PlayerRoles.Voice
{
	public class IntercomDisplay : NetworkBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _text;


		private enum IcomText
		{
			Ready = 0,
			Transmitting = 1,
			TrasmittingBypass = 2,
			Restarting = 3,
			AdminUsing = 4,
			Muted = 5,
			Unknown = 6,
			Wait = 7
		}

		private static IntercomDisplay _singleton;

		[SyncVar]
		private string _overrideText;

		private Intercom _icom;

		private string[] _translations;

		private bool[] _translationsSet;

		public string Network_overrideText
		{
			get
			{
				return _overrideText;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _overrideText, 1uL, null);
			}
		}

		private void Awake()
		{
			_icom = GetComponent<Intercom>();
			_singleton = this;
			int num = 0;
			foreach (int item in EnumUtils<IcomText>.Values.ToArray().Cast<int>())
			{
				num = Mathf.Max(num, item + 1);
			}
			_translations = new string[num];
			_translationsSet = new bool[num];
		}

		private string GetTranslation(IcomText text)
		{
			if (!_translationsSet[(int)text])
			{
				_translations[(int)text] = TranslationReader.Get("Intercom", (int)text, text.ToString());
				_translationsSet[(int)text] = true;
			}
			return _translations[(int)text];
		}

		private void Update()
		{
			if (!string.IsNullOrEmpty(_overrideText))
			{
				_text.text = _overrideText;
				return;
			}
			switch (Intercom.State)
			{
			case IntercomState.Ready:
				_text.text = GetTranslation((global::VoiceChat.VoiceChatMuteIndicator.ReceivedFlags != global::VoiceChat.VcMuteFlags.None) ? IcomText.Muted : IcomText.Ready);
				break;
			case IntercomState.Starting:
				_text.text = GetTranslation(IcomText.Wait);
				break;
			case IntercomState.InUse:
				_text.text = (_icom.BypassMode ? GetTranslation(IcomText.TrasmittingBypass) : string.Format(GetTranslation(IcomText.Transmitting), Mathf.Ceil(_icom.RemainingTime)));
				break;
			case IntercomState.Cooldown:
				_text.text = string.Format(GetTranslation(IcomText.Restarting), Mathf.Ceil(_icom.RemainingTime));
				break;
			case IntercomState.NotFound:
				_text.text = GetTranslation(IcomText.Unknown);
				break;
			}
		}

		public static bool TrySetDisplay(string str)
		{
			if (_singleton == null)
			{
				return false;
			}
			_singleton.Network_overrideText = str;
			return true;
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteString(_overrideText);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteString(_overrideText);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _overrideText, null, reader.ReadString());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _overrideText, null, reader.ReadString());
			}
		}
	}
}

using System;
using Mirror;
using TMPro;

namespace UserSettings.ServerSpecific
{
	public class SSPlaintextSetting : ServerSpecificSettingBase
	{
		private enum UpdateType : byte
		{
			None = 0,
			Clear = 1,
			Text = 2,
			Settings = 3
		}

		private int? _characterLimitOriginalCache;

		public string SyncInputText { get; internal set; }

		public string Placeholder { get; private set; }

		public string DefaultText { get; private set; }

		public TMP_InputField.ContentType ContentType { get; private set; }

		public int CharacterLimit { get; private set; }

		public override string DebugValue => SyncInputText;

		private int CharacterLimitOriginal
		{
			get
			{
				int valueOrDefault = _characterLimitOriginalCache.GetValueOrDefault();
				if (!_characterLimitOriginalCache.HasValue)
				{
					valueOrDefault = (base.OriginalDefinition as SSPlaintextSetting).CharacterLimit;
					_characterLimitOriginalCache = valueOrDefault;
				}
				return _characterLimitOriginalCache.Value;
			}
		}

		internal event Action OnClearRequested;

		internal event Action OnTextUpdated;

		public SSPlaintextSetting(int? id, string label, string placeholder = "...", int characterLimit = 64, TMP_InputField.ContentType contentType = TMP_InputField.ContentType.Standard, string hint = null, byte collectionId = byte.MaxValue, bool isServerOnly = false)
		{
			SetId(id, label);
			base.Label = label;
			base.HintDescription = hint;
			base.CollectionId = collectionId;
			base.IsServerOnly = isServerOnly;
			Placeholder = placeholder;
			CharacterLimit = characterLimit;
			ContentType = contentType;
		}

		public void SendValueUpdate(string text, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (!base.IsServerOnly)
			{
				return;
			}
			text = ValidateInputText(text);
			if (applyOverride)
			{
				DefaultText = text;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(2);
				writer.WriteString(text);
			});
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((receiveFilter == null || receiveFilter(allHub)) && ServerSpecificSettingsSync.TryGetSettingOfUser<SSPlaintextSetting>(allHub, base.SettingId, out var result))
				{
					result.SyncInputText = text;
				}
			}
		}

		public void SendClearRequest(Func<ReferenceHub, bool> receiveFilter = null)
		{
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(1);
			});
		}

		public void SendPlaintextUpdate(string placeholder, ushort characterLimit, TMP_InputField.ContentType contentType, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (applyOverride)
			{
				Placeholder = placeholder;
				CharacterLimit = characterLimit;
				ContentType = contentType;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(3);
				writer.WriteString(placeholder);
				writer.WriteUShort(characterLimit);
				writer.WriteByte((byte)contentType);
			});
		}

		public override void ApplyDefaultValues()
		{
			SyncInputText = (base.IsServerOnly ? DefaultText : string.Empty);
		}

		public override void TransferValue(ServerSpecificSettingBase other)
		{
			if (other is SSPlaintextSetting sSPlaintextSetting)
			{
				sSPlaintextSetting.SyncInputText = SyncInputText;
			}
		}

		public override void SerializeEntry(NetworkWriter writer)
		{
			base.SerializeEntry(writer);
			writer.WriteString(DefaultText);
			writer.WriteString(Placeholder);
			writer.WriteUShort((ushort)CharacterLimit);
			writer.WriteByte((byte)ContentType);
		}

		public override void DeserializeEntry(NetworkReader reader)
		{
			base.DeserializeEntry(reader);
			DefaultText = reader.ReadString();
			Placeholder = reader.ReadString();
			CharacterLimit = reader.ReadUShort();
			ContentType = (TMP_InputField.ContentType)reader.ReadByte();
		}

		public override void SerializeValue(NetworkWriter writer)
		{
			base.SerializeValue(writer);
			writer.WriteString(SyncInputText);
		}

		public override void DeserializeValue(NetworkReader reader)
		{
			base.DeserializeValue(reader);
			SyncInputText = ValidateInputText(reader.ReadString());
		}

		public override bool DeserializeUpdate(NetworkReader reader)
		{
			if (base.DeserializeUpdate(reader))
			{
				return true;
			}
			switch ((UpdateType)reader.ReadByte())
			{
			case UpdateType.Clear:
				OnClearRequested?.Invoke();
				break;
			case UpdateType.Text:
				if (base.IsServerOnly)
				{
					SyncInputText = ValidateInputText(reader.ReadString());
					OnTextUpdated?.Invoke();
				}
				break;
			case UpdateType.Settings:
				Placeholder = reader.ReadString();
				CharacterLimit = reader.ReadUShort();
				ContentType = (TMP_InputField.ContentType)reader.ReadByte();
				OnSettingUpdate?.Invoke();
				if (base.IsServerOnly)
				{
					SyncInputText = ValidateInputText(SyncInputText);
					OnTextUpdated?.Invoke();
				}
				break;
			default:
				return reader.Remaining == 0;
			}
			return reader.Remaining == 0;
		}

		private string ValidateInputText(string text)
		{
			if (text == null)
			{
				return string.Empty;
			}
			int characterLimitOriginal = CharacterLimitOriginal;
			if (text.Length > characterLimitOriginal)
			{
				text = text.Remove(characterLimitOriginal);
			}
			return text;
		}
	}
}

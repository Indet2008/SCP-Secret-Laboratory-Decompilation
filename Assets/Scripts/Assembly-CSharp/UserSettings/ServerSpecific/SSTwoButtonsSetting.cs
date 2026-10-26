using System;
using Mirror;

namespace UserSettings.ServerSpecific
{
	public class SSTwoButtonsSetting : ServerSpecificSettingBase
	{
		private enum UpdateType : byte
		{
			None = 0,
			Value = 1,
			Options = 2
		}

		internal Action OnValueUpdated;

		public bool SyncIsB { get; internal set; }

		public bool SyncIsA => !SyncIsB;

		public string OptionA { get; private set; }

		public string OptionB { get; private set; }

		public bool DefaultIsB { get; private set; }

		public override string DebugValue
		{
			get
			{
				if (!SyncIsB)
				{
					return "A";
				}
				return "B";
			}
		}

		public SSTwoButtonsSetting(int? id, string label, string optionA, string optionB, bool defaultIsB = false, string hint = null, byte collectionId = byte.MaxValue, bool isServerOnly = false)
		{
			SetId(id, label);
			base.Label = label;
			base.CollectionId = collectionId;
			base.IsServerOnly = isServerOnly;
			OptionA = optionA;
			OptionB = optionB;
			DefaultIsB = defaultIsB;
			base.HintDescription = hint;
		}

		public void SendValueUpdate(bool isB, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (!base.IsServerOnly)
			{
				return;
			}
			if (applyOverride)
			{
				DefaultIsB = isB;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(1);
				writer.WriteBool(isB);
			});
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((receiveFilter == null || receiveFilter(allHub)) && ServerSpecificSettingsSync.TryGetSettingOfUser<SSTwoButtonsSetting>(allHub, base.SettingId, out var result))
				{
					result.SyncIsB = isB;
				}
			}
		}

		public void SendTwoButtonUpdate(string optionA, string optionB, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (applyOverride)
			{
				OptionA = optionA;
				OptionB = optionB;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(2);
				writer.WriteString(optionA);
				writer.WriteString(optionB);
			});
		}

		public override void ApplyDefaultValues()
		{
			SyncIsB = DefaultIsB;
		}

		public override void TransferValue(ServerSpecificSettingBase other)
		{
			if (other is SSTwoButtonsSetting sSTwoButtonsSetting)
			{
				sSTwoButtonsSetting.SyncIsB = SyncIsB;
			}
		}

		public override void DeserializeValue(NetworkReader reader)
		{
			SyncIsB = reader.ReadBool();
		}

		public override void SerializeValue(NetworkWriter writer)
		{
			writer.WriteBool(SyncIsB);
		}

		public override void DeserializeEntry(NetworkReader reader)
		{
			base.DeserializeEntry(reader);
			OptionA = reader.ReadString();
			OptionB = reader.ReadString();
			DefaultIsB = reader.ReadBool();
		}

		public override void SerializeEntry(NetworkWriter writer)
		{
			base.SerializeEntry(writer);
			writer.WriteString(OptionA);
			writer.WriteString(OptionB);
			writer.WriteBool(DefaultIsB);
		}

		public override bool DeserializeUpdate(NetworkReader reader)
		{
			if (base.DeserializeUpdate(reader))
			{
				return true;
			}
			switch ((UpdateType)reader.ReadByte())
			{
			case UpdateType.Value:
				if (base.IsServerOnly)
				{
					SyncIsB = reader.ReadBool();
					OnValueUpdated?.Invoke();
				}
				break;
			case UpdateType.Options:
				OptionA = reader.ReadString();
				OptionB = reader.ReadString();
				OnSettingUpdate?.Invoke();
				break;
			default:
				return reader.Remaining == 0;
			}
			return reader.Remaining == 0;
		}
	}
}

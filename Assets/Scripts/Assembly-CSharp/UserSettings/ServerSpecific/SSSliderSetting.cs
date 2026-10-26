using System;
using Mirror;
using UnityEngine;

namespace UserSettings.ServerSpecific
{
	public class SSSliderSetting : ServerSpecificSettingBase
	{
		private enum UpdateType : byte
		{
			None = 0,
			Value = 1,
			Constraints = 2
		}

		internal Action OnValueUpdated;

		public float SyncFloatValue { get; set; }

		public int SyncIntValue => Mathf.RoundToInt(SyncFloatValue);

		public bool SyncDragging { get; set; }

		public float DefaultValue { get; private set; }

		public float MinValue { get; private set; }

		public float MaxValue { get; private set; }

		public bool Integer { get; private set; }

		public string ValueToStringFormat { get; private set; }

		public string FinalDisplayFormat { get; private set; }

		public override string DebugValue => SyncFloatValue.ToString();

		public SSSliderSetting(int? id, string label, float minValue, float maxValue, float defaultValue = 0f, bool integer = false, string valueToStringFormat = "0.##", string finalDisplayFormat = "{0}", string hint = null, byte collectionId = byte.MaxValue, bool isServerOnly = false)
		{
			SetId(id, label);
			base.Label = label;
			base.HintDescription = hint;
			base.CollectionId = collectionId;
			base.IsServerOnly = isServerOnly;
			DefaultValue = Mathf.Clamp(defaultValue, minValue, maxValue);
			MinValue = minValue;
			MaxValue = maxValue;
			Integer = integer;
			ValueToStringFormat = valueToStringFormat;
			FinalDisplayFormat = finalDisplayFormat;
			if (!finalDisplayFormat.Contains("0"))
			{
				FinalDisplayFormat += "{0}";
			}
		}

		public void SendValueUpdate(float newValue, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (!base.IsServerOnly)
			{
				return;
			}
			if (applyOverride)
			{
				DefaultValue = newValue;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(1);
				writer.WriteFloat(newValue);
			});
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((receiveFilter == null || receiveFilter(allHub)) && ServerSpecificSettingsSync.TryGetSettingOfUser<SSSliderSetting>(allHub, base.SettingId, out var result))
				{
					result.SyncFloatValue = newValue;
				}
			}
		}

		public void SendSliderUpdate(float min, float max, bool integer, string valueToStringFormat, string finalDisplayFormat, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (applyOverride)
			{
				MinValue = min;
				MaxValue = max;
				Integer = integer;
				ValueToStringFormat = valueToStringFormat;
				FinalDisplayFormat = finalDisplayFormat;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(2);
				writer.WriteFloat(min);
				writer.WriteFloat(max);
				writer.WriteBool(integer);
				writer.WriteString(valueToStringFormat);
				writer.WriteString(finalDisplayFormat);
			});
		}

		public override void ApplyDefaultValues()
		{
			SyncFloatValue = DefaultValue;
		}

		public override void TransferValue(ServerSpecificSettingBase other)
		{
			if (other is SSSliderSetting sSSliderSetting)
			{
				sSSliderSetting.SyncFloatValue = SyncFloatValue;
			}
		}

		public override void DeserializeValue(NetworkReader reader)
		{
			SyncFloatValue = reader.ReadFloat();
			SyncDragging = reader.ReadBool();
		}

		public override void SerializeValue(NetworkWriter writer)
		{
			writer.WriteFloat(SyncFloatValue);
			writer.WriteBool(SyncDragging);
		}

		public override void SerializeEntry(NetworkWriter writer)
		{
			base.SerializeEntry(writer);
			writer.WriteFloat(DefaultValue);
			writer.WriteFloat(MinValue);
			writer.WriteFloat(MaxValue);
			writer.WriteBool(Integer);
			writer.WriteString(ValueToStringFormat);
			writer.WriteString(FinalDisplayFormat);
		}

		public override void DeserializeEntry(NetworkReader reader)
		{
			base.DeserializeEntry(reader);
			DefaultValue = reader.ReadFloat();
			MinValue = reader.ReadFloat();
			MaxValue = reader.ReadFloat();
			Integer = reader.ReadBool();
			ValueToStringFormat = reader.ReadString();
			FinalDisplayFormat = reader.ReadString();
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
					SyncFloatValue = reader.ReadFloat();
					OnValueUpdated?.Invoke();
				}
				break;
			case UpdateType.Constraints:
				MinValue = reader.ReadFloat();
				MaxValue = reader.ReadFloat();
				Integer = reader.ReadBool();
				ValueToStringFormat = reader.ReadString();
				FinalDisplayFormat = reader.ReadString();
				OnSettingUpdate?.Invoke();
				if (base.IsServerOnly)
				{
					SyncFloatValue = Mathf.Clamp(SyncFloatValue, MinValue, MaxValue);
					OnValueUpdated?.Invoke();
				}
				break;
			default:
				return reader.Remaining == 0;
			}
			return reader.Remaining == 0;
		}
	}
}

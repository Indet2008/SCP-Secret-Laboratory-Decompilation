using System;
using Mirror;
using UnityEngine;

namespace UserSettings.ServerSpecific
{
	public class SSDropdownSetting : ServerSpecificSettingBase
	{
		public enum DropdownEntryType
		{
			Regular = 0,
			Scrollable = 1,
			ScrollableLoop = 2,
			Hybrid = 3,
			HybridLoop = 4
		}

		private enum UpdateType : byte
		{
			None = 0,
			Selection = 1,
			Options = 2
		}

		public string[] Options { get; private set; }

		public int DefaultOptionIndex { get; private set; }

		public DropdownEntryType EntryType { get; private set; }

		public int SyncSelectionIndexRaw { get; internal set; }

		public string SyncSelectionText
		{
			get
			{
				if (!(base.OriginalDefinition is SSDropdownSetting sSDropdownSetting))
				{
					return string.Empty;
				}
				int max = sSDropdownSetting.Options.Length - 1;
				int num = Mathf.Clamp(SyncSelectionIndexRaw, 0, max);
				return sSDropdownSetting.Options[num];
			}
		}

		public int SyncSelectionIndexValidated
		{
			get
			{
				if (!(base.OriginalDefinition is SSDropdownSetting sSDropdownSetting))
				{
					return 0;
				}
				int max = sSDropdownSetting.Options.Length - 1;
				return Mathf.Clamp(SyncSelectionIndexRaw, 0, max);
			}
		}

		public override string DebugValue => $"{SyncSelectionIndexRaw} ({SyncSelectionText})";

		internal event Action OnSelectionUpdated;

		public SSDropdownSetting(int? id, string label, string[] options, int defaultOptionIndex = 0, DropdownEntryType entryType = DropdownEntryType.Regular, string hint = null, byte collectionId = byte.MaxValue, bool isServerOnly = false)
		{
			SetId(id, label);
			if (options == null || options.Length == 0)
			{
				options = new string[0];
			}
			base.Label = label;
			base.HintDescription = hint;
			base.CollectionId = collectionId;
			base.IsServerOnly = isServerOnly;
			Options = options;
			EntryType = entryType;
			DefaultOptionIndex = defaultOptionIndex;
		}

		public void SendValueUpdate(int newSelectionIndex, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (!base.IsServerOnly)
			{
				return;
			}
			if (applyOverride)
			{
				DefaultOptionIndex = newSelectionIndex;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(1);
				writer.WriteByte((byte)newSelectionIndex);
			});
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((receiveFilter == null || receiveFilter(allHub)) && ServerSpecificSettingsSync.TryGetSettingOfUser<SSDropdownSetting>(allHub, base.SettingId, out var result))
				{
					result.SyncSelectionIndexRaw = newSelectionIndex;
				}
			}
		}

		public void SendDropdownUpdate(string[] newOptions, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (applyOverride)
			{
				Options = newOptions;
			}
			SendUpdate(receiveFilter, (NetworkWriter writer) =>
			{
				writer.WriteByte(2);
				writer.WriteByte((byte)newOptions.Length);
				newOptions.ForEach(writer.WriteString);
			});
		}

		public override void ApplyDefaultValues()
		{
			SyncSelectionIndexRaw = DefaultOptionIndex;
		}

		public override void TransferValue(ServerSpecificSettingBase other)
		{
			if (other is SSDropdownSetting sSDropdownSetting)
			{
				sSDropdownSetting.SyncSelectionIndexRaw = SyncSelectionIndexRaw;
			}
		}

		public override void SerializeEntry(NetworkWriter writer)
		{
			base.SerializeEntry(writer);
			writer.WriteByte((byte)DefaultOptionIndex);
			writer.WriteByte((byte)EntryType);
			writer.WriteByte((byte)Options.Length);
			Options.ForEach(writer.WriteString);
		}

		public override void DeserializeEntry(NetworkReader reader)
		{
			base.DeserializeEntry(reader);
			DefaultOptionIndex = reader.ReadByte();
			EntryType = (DropdownEntryType)reader.ReadByte();
			DeserializeOptions(reader);
		}

		public override void SerializeValue(NetworkWriter writer)
		{
			base.SerializeValue(writer);
			writer.WriteByte((byte)SyncSelectionIndexRaw);
		}

		public override void DeserializeValue(NetworkReader reader)
		{
			base.DeserializeValue(reader);
			SyncSelectionIndexRaw = reader.ReadByte();
		}

		public override bool DeserializeUpdate(NetworkReader reader)
		{
			if (base.DeserializeUpdate(reader))
			{
				return true;
			}
			switch ((UpdateType)reader.ReadByte())
			{
			case UpdateType.Selection:
				if (base.IsServerOnly)
				{
					SyncSelectionIndexRaw = reader.ReadByte();
					OnSelectionUpdated?.Invoke();
				}
				break;
			case UpdateType.Options:
				DeserializeOptions(reader);
				OnSettingUpdate?.Invoke();
				if (base.IsServerOnly)
				{
					SyncSelectionIndexRaw = Mathf.Clamp(SyncSelectionIndexRaw, 0, Options.Length - 1);
					OnSelectionUpdated?.Invoke();
				}
				break;
			default:
				return reader.Remaining == 0;
			}
			return reader.Remaining == 0;
		}

		private void DeserializeOptions(NetworkReader reader)
		{
			int num = reader.ReadByte();
			if (num > 0)
			{
				Options = new string[num];
				for (int i = 0; i < Options.Length; i++)
				{
					Options[i] = reader.ReadString();
				}
			}
			else
			{
				Options = new string[1] { string.Empty };
			}
		}
	}
}

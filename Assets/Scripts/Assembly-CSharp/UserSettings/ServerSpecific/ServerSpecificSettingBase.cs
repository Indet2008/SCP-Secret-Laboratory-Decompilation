using System;
using System.Text;
using Mirror;
using Utils.Networking;

namespace UserSettings.ServerSpecific
{
	public abstract class ServerSpecificSettingBase
	{
		public enum UserResponseMode
		{
			None = 0,
			ChangeOnly = 1,
			AcquisitionAndChange = 2
		}

		private const byte MaxCollections = 20;

		private static readonly StringBuilder KeyGeneratorSb = new StringBuilder();

		internal Action OnSettingUpdate;

		public int SettingId { get; private set; }

		public string Label { get; protected set; }

		public string HintDescription { get; protected set; }

		public byte CollectionId { get; protected set; } = byte.MaxValue;

		public bool IsServerOnly { get; protected set; }

		public string PlayerPrefsKey { get; private set; }

		public virtual UserResponseMode ResponseMode => UserResponseMode.AcquisitionAndChange;

		public abstract string DebugValue { get; }

		public ServerSpecificSettingBase OriginalDefinition
		{
			get
			{
				ServerSpecificSettingBase[] definedSettings = ServerSpecificSettingsSync.DefinedSettings;
				foreach (ServerSpecificSettingBase serverSpecificSettingBase in definedSettings)
				{
					if (serverSpecificSettingBase.SettingId == SettingId && !(serverSpecificSettingBase.GetType() != GetType()))
					{
						return serverSpecificSettingBase;
					}
				}
				return null;
			}
		}

		public void SendHintUpdate(string newHintDescription, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			SendUpdate(Label, newHintDescription, applyOverride, receiveFilter);
		}

		public void SendLabelUpdate(string newLabel, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			SendUpdate(newLabel, HintDescription, applyOverride, receiveFilter);
		}

		public void SendUpdate(string newLabel, string newHintDescription, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			if (applyOverride)
			{
				Label = newLabel;
				HintDescription = newHintDescription;
			}
			SendUpdate(receiveFilter, null, updateBase: true, newLabel, newHintDescription);
		}

		public void ClientSendValue()
		{
			if (NetworkClient.active)
			{
				NetworkClient.Send(new SSSClientResponse(this));
			}
		}

		public virtual void SerializeEntry(NetworkWriter writer)
		{
			writer.WriteInt(SettingId);
			writer.WriteString(Label);
			writer.WriteString(HintDescription);
			writer.WriteByte(CollectionId);
			writer.WriteBool(IsServerOnly);
		}

		public virtual void DeserializeEntry(NetworkReader reader)
		{
			SettingId = reader.ReadInt();
			Label = reader.ReadString();
			HintDescription = reader.ReadString();
			CollectionId = reader.ReadByte();
			PlayerPrefsKey = GeneratePrefsKey();
			IsServerOnly = reader.ReadBool();
		}

		public virtual void OnUpdate()
		{
		}

		public virtual void SerializeValue(NetworkWriter writer)
		{
		}

		public virtual void DeserializeValue(NetworkReader reader)
		{
		}

		public abstract void ApplyDefaultValues();

		public virtual void TransferValue(ServerSpecificSettingBase other)
		{
		}

		public override string ToString()
		{
			return $"{GetType().Name} [ID: {SettingId}] Value: {DebugValue}";
		}

		internal void SetId(int? id, string labelFallback)
		{
			if (!id.HasValue)
			{
				id = labelFallback.GetStableHashCode();
			}
			SettingId = id.Value;
		}

		protected void SendUpdate(Func<ReferenceHub, bool> receiveFilter, Action<NetworkWriter> writeDerived, bool updateBase = false, string newLabel = null, string newHintDescription = null)
		{
			SSSUpdateMessage sSSUpdateMessage = new SSSUpdateMessage(this, (NetworkWriter writer) =>
			{
				writer.WriteBool(updateBase);
				if (updateBase)
				{
					writer.WriteString(newLabel);
					writer.WriteString(newHintDescription);
				}
				writeDerived?.Invoke(writer);
			});
			if (receiveFilter == null)
			{
				sSSUpdateMessage.SendToAuthenticated();
			}
			else
			{
				sSSUpdateMessage.SendToHubsConditionally(receiveFilter);
			}
		}

		public virtual bool DeserializeUpdate(NetworkReader reader)
		{
			if (reader.ReadBool())
			{
				Label = reader.ReadString();
				HintDescription = reader.ReadString();
				OnSettingUpdate?.Invoke();
			}
			return reader.Remaining == 0;
		}

		private string GeneratePrefsKey()
		{
			KeyGeneratorSb.Clear();
			KeyGeneratorSb.Append("SrvSp_");
			if (CollectionId < 20)
			{
				string value = FavoriteAndHistory.AccountIDLastJoined;
				if (string.IsNullOrEmpty(value))
				{
					value = ServerSpecificSettingsSync.CurServerPrefsKey;
				}
				KeyGeneratorSb.Append(value);
				KeyGeneratorSb.Append('_');
				KeyGeneratorSb.Append(CollectionId);
			}
			else
			{
				KeyGeneratorSb.Append(ServerSpecificSettingsSync.CurServerPrefsKey);
			}
			KeyGeneratorSb.Append('_');
			KeyGeneratorSb.Append(ServerSpecificSettingsSync.GetCodeFromType(GetType()));
			KeyGeneratorSb.Append('_');
			KeyGeneratorSb.Append(SettingId);
			return KeyGeneratorSb.ToString();
		}
	}
}

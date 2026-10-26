namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Team/Network Team")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/guides/interest-management")]
	public class NetworkTeam : global::Mirror.NetworkBehaviour
	{
		[global::UnityEngine.Tooltip("Set this to the same value on all networked objects that belong to a given team")]
		[global::Mirror.SyncVar]
		public string teamId = string.Empty;

		[global::UnityEngine.Tooltip("When enabled this object is visible to all clients. Typically this would be true for player objects")]
		[global::Mirror.SyncVar]
		public bool forceShown;

		public string NetworkteamId
		{
			get
			{
				return teamId;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref teamId, 1uL, null);
			}
		}

		public bool NetworkforceShown
		{
			get
			{
				return forceShown;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref forceShown, 2uL, null);
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(global::Mirror.NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteString(teamId);
				writer.WriteBool(forceShown);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteString(teamId);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteBool(forceShown);
			}
		}

		protected override void DeserializeSyncVars(global::Mirror.NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref teamId, null, reader.ReadString());
				GeneratedSyncVarDeserialize(ref forceShown, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref teamId, null, reader.ReadString());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref forceShown, null, reader.ReadBool());
			}
		}
	}
}

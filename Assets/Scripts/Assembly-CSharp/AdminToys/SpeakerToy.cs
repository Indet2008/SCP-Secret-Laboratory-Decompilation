using System;
using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;
using VoiceChat.Playbacks;

namespace AdminToys
{
	public class SpeakerToy : AdminToyBase
	{
		public SpeakerToyPlaybackBase Playback;

		[SyncVar(hook = "OnControllerIdChanged")]
		public byte ControllerId;

		[SyncVar(hook = "OnIsSpatialChanged")]
		public bool IsSpatial = true;

		[SyncVar(hook = "OnVolumeChanged")]
		public float Volume = 1f;

		[SyncVar(hook = "OnMinDistanceChanged")]
		public float MinDistance = 1f;

		[SyncVar(hook = "OnMaxDistanceChanged")]
		public float MaxDistance = 15f;

		public override string CommandName => "Speaker";

		public byte NetworkControllerId
		{
			get
			{
				return ControllerId;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref ControllerId, 32uL, OnControllerIdChanged);
			}
		}

		public bool NetworkIsSpatial
		{
			get
			{
				return IsSpatial;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref IsSpatial, 64uL, OnIsSpatialChanged);
			}
		}

		public float NetworkVolume
		{
			get
			{
				return Volume;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Volume, 128uL, OnVolumeChanged);
			}
		}

		public float NetworkMinDistance
		{
			get
			{
				return MinDistance;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref MinDistance, 256uL, OnMinDistanceChanged);
			}
		}

		public float NetworkMaxDistance
		{
			get
			{
				return MaxDistance;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref MaxDistance, 512uL, OnMaxDistanceChanged);
			}
		}

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			base.OnSpawned(admin, arguments);
			base.transform.position = admin.PlayerCameraReference.position;
			base.transform.localScale = Vector3.one;
			Playback.ControllerId = ControllerId;
			Playback.Source.spatialBlend = (IsSpatial ? 1f : 0f);
			Playback.VolumeScale = Volume;
			Playback.Source.minDistance = MinDistance;
			Playback.Source.maxDistance = MaxDistance;
		}

		private void OnControllerIdChanged(byte _, byte id)
		{
			Playback.ControllerId = id;
		}

		private void OnIsSpatialChanged(bool _, bool isSpatial)
		{
			Playback.Source.spatialBlend = (isSpatial ? 1f : 0f);
		}

		private void OnVolumeChanged(float _, float volume)
		{
			Playback.VolumeScale = volume;
		}

		private void OnMinDistanceChanged(float _, float distance)
		{
			Playback.Source.minDistance = distance;
		}

		private void OnMaxDistanceChanged(float _, float distance)
		{
			Playback.Source.maxDistance = distance;
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
				NetworkWriterExtensions.WriteByte(writer, ControllerId);
				writer.WriteBool(IsSpatial);
				writer.WriteFloat(Volume);
				writer.WriteFloat(MinDistance);
				writer.WriteFloat(MaxDistance);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, ControllerId);
			}
			if ((base.syncVarDirtyBits & 0x40L) != 0L)
			{
				writer.WriteBool(IsSpatial);
			}
			if ((base.syncVarDirtyBits & 0x80L) != 0L)
			{
				writer.WriteFloat(Volume);
			}
			if ((base.syncVarDirtyBits & 0x100L) != 0L)
			{
				writer.WriteFloat(MinDistance);
			}
			if ((base.syncVarDirtyBits & 0x200L) != 0L)
			{
				writer.WriteFloat(MaxDistance);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref ControllerId, OnControllerIdChanged, NetworkReaderExtensions.ReadByte(reader));
				GeneratedSyncVarDeserialize(ref IsSpatial, OnIsSpatialChanged, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref Volume, OnVolumeChanged, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref MinDistance, OnMinDistanceChanged, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref MaxDistance, OnMaxDistanceChanged, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref ControllerId, OnControllerIdChanged, NetworkReaderExtensions.ReadByte(reader));
			}
			if ((num & 0x40L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref IsSpatial, OnIsSpatialChanged, reader.ReadBool());
			}
			if ((num & 0x80L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Volume, OnVolumeChanged, reader.ReadFloat());
			}
			if ((num & 0x100L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref MinDistance, OnMinDistanceChanged, reader.ReadFloat());
			}
			if ((num & 0x200L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref MaxDistance, OnMaxDistanceChanged, reader.ReadFloat());
			}
		}
	}
}

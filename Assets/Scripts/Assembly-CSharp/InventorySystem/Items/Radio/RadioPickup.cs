using System.Runtime.InteropServices;
using InventorySystem.Items.Pickups;
using Mirror;
using Scp914;
using UnityEngine;
using VoiceChat.Playbacks;

namespace InventorySystem.Items.Radio
{
	public class RadioPickup : CollisionDetectionPickup, IUpgradeTrigger
	{
		[SyncVar]
		public bool SavedEnabled;

		[SyncVar]
		public byte SavedRange;

		public float SavedBattery;

		private static RadioItem _radioCache;

		private static bool _radioCacheSet;

		[SerializeField]
		private Material _enabledMat;

		[SerializeField]
		private Material _disabledMat;

		[SerializeField]
		private Renderer _targetRenderer;

		[SerializeField]
		private GameObject _activeObject;

		[SerializeField]
		private SpatializedRadioPlaybackBase _playback;

		private bool _prevEnabled;

		public bool NetworkSavedEnabled
		{
			get
			{
				return SavedEnabled;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref SavedEnabled, 2uL, null);
			}
		}

		public byte NetworkSavedRange
		{
			get
			{
				return SavedRange;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref SavedRange, 4uL, null);
			}
		}

		private void Update()
		{
			_playback.RangeId = SavedRange;
			if (_prevEnabled != SavedEnabled)
			{
				bool flag = (_prevEnabled = SavedEnabled);
				_activeObject.SetActive(flag);
				_targetRenderer.sharedMaterial = (flag ? _enabledMat : _disabledMat);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			if (!_radioCacheSet)
			{
				_radioCacheSet = InventoryItemLoader.TryGetItem<RadioItem>(ItemType.Radio, out _radioCache);
			}
		}

		private void LateUpdate()
		{
			if (NetworkServer.active && SavedEnabled && _radioCacheSet)
			{
				float num = _radioCache.Ranges[SavedRange].MinuteCostWhenIdle / 60f;
				float num2 = SavedBattery - Time.deltaTime * num / 100f;
				if (num2 <= 0f)
				{
					NetworkSavedEnabled = false;
					num2 = 0f;
				}
				SavedBattery = num2;
			}
		}

		public void ServerOnUpgraded(Scp914KnobSetting setting)
		{
			SavedBattery = 1f;
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
				writer.WriteBool(SavedEnabled);
				NetworkWriterExtensions.WriteByte(writer, SavedRange);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteBool(SavedEnabled);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, SavedRange);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref SavedEnabled, null, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref SavedRange, null, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref SavedEnabled, null, reader.ReadBool());
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref SavedRange, null, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}

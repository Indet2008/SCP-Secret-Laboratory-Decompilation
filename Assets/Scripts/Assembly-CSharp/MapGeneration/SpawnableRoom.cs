using System;
using MapGeneration.Holidays;
using Mirror;
using UnityEngine;

namespace MapGeneration
{
	public class SpawnableRoom : MonoBehaviour
	{
		[Serializable]
		public struct OriginalNetIdentity
		{
			public GameObject Target;

			public uint AssetId;
		}

		private RoomIdentifier _roomIdentifier;

		private bool _roomIdentifierSet;

		private bool _netIdCacheSet;

		private uint _assetIdOffset;

		private const int MaxRegistrations = 12;

		private static uint _nextAssetId = 1u;

		public int MinAmount;

		public int MaxAmount;

		public float ChanceMultiplier = 1f;

		public float AdjacentChanceMultiplier = 0.1f;

		public float FirstChanceMultiplier = 100f;

		public bool SpecialRoom;

		[HideInInspector]
		public OriginalNetIdentity[] OriginalIdentities;

		public HolidayRoomVariant[] HolidayVariants;

		public int DuplicateId { get; private set; }

		public RoomIdentifier Room
		{
			get
			{
				if (!_roomIdentifierSet)
				{
					_roomIdentifier = GetComponent<RoomIdentifier>();
					_roomIdentifierSet = true;
				}
				return _roomIdentifier;
			}
		}

		public void RegisterIdentities()
		{
			if (!_netIdCacheSet)
			{
				NetworkIdentity[] componentsInChildren = GetComponentsInChildren<NetworkIdentity>(includeInactive: true);
				OriginalIdentities = new OriginalNetIdentity[componentsInChildren.Length];
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					OriginalIdentities[i] = new OriginalNetIdentity
					{
						AssetId = (uint)(_nextAssetId + i),
						Target = componentsInChildren[i].gameObject
					};
				}
				int num = Mathf.Clamp(MaxAmount, 1, 12);
				_nextAssetId += (uint)(num * componentsInChildren.Length);
				_netIdCacheSet = true;
			}
		}

		public void SetupNetIdHandlers(int prevSpawnedCnt)
		{
			DuplicateId = prevSpawnedCnt;
			int num = OriginalIdentities.Length;
			_assetIdOffset = (uint)(num * prevSpawnedCnt);
			for (int i = 0; i < num; i++)
			{
				OriginalNetIdentity originalNetIdentity = OriginalIdentities[i];
				uint assetId = originalNetIdentity.AssetId + _assetIdOffset;
				if (NetworkServer.active)
				{
					NetworkServer.Spawn(originalNetIdentity.Target, assetId);
					continue;
				}
				originalNetIdentity.Target.SetActive(value: false);
				originalNetIdentity.Target.hideFlags = HideFlags.NotEditable;
				NetworkClient.RegisterSpawnHandler(assetId, SpawnNetIdentity, UnityEngine.Object.Destroy);
			}
		}

		private GameObject SpawnNetIdentity(SpawnMessage spawnMessage)
		{
			OriginalNetIdentity[] originalIdentities = OriginalIdentities;
			for (int i = 0; i < originalIdentities.Length; i++)
			{
				OriginalNetIdentity originalNetIdentity = originalIdentities[i];
				if (originalNetIdentity.AssetId + _assetIdOffset == spawnMessage.assetId)
				{
					originalNetIdentity.Target.SetActive(value: true);
					originalNetIdentity.Target.hideFlags = HideFlags.None;
					return originalNetIdentity.Target;
				}
			}
			throw new InvalidOperationException("Failed to spawn sub-identity with asset ID " + spawnMessage.assetId);
		}
	}
}

using CustomPlayerEffects;
using Hazards;
using Mirror.LiteNetLib4Mirror;
using PlayerRoles.FirstPersonControl;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyRainbow : ICandy
	{
		private const float RayMaxDistance = 100f;

		private const float CloudHeight = 1.25f;

		private static readonly int Layer = LayerMask.GetMask("Default");

		private bool _initialized;

		private PrismaticCloud _cloudPrefab;

		public PrismaticCloud Cloud
		{
			get
			{
				if (!_initialized)
				{
					foreach (GameObject spawnPrefab in LiteNetLib4MirrorNetworkManager.singleton.spawnPrefabs)
					{
						if (spawnPrefab.TryGetComponent<PrismaticCloud>(out _cloudPrefab))
						{
							_initialized = true;
							break;
						}
					}
				}
				return _cloudPrefab;
			}
		}

		public CandyKindID Kind => CandyKindID.Rainbow;

		public float SpawnChanceWeight { get; private set; } = 11f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			if (hub.roleManager.CurrentRole is IFpcRole fpcRole && Physics.Raycast(fpcRole.FpcModule.Position, Vector3.down, out var hitInfo, 100f, Layer))
			{
				PrismaticCloud prismaticCloud = Object.Instantiate(Cloud);
				Vector3 targetPos = hitInfo.point + Vector3.up * 1.25f;
				prismaticCloud.SynchronizedPosition = new RelativePosition(targetPos);
				hub.playerEffectsController.EnableEffect<Prismatic>(3f).OriginCloud = prismaticCloud;
			}
		}
	}
}

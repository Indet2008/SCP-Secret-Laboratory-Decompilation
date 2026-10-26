using System.Diagnostics;
using CustomPlayerEffects;
using GameObjectPools;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieBloodlustAbility : SubroutineBase, IPoolResettable
	{
		[SerializeField]
		private float _maxViewDistance;

		private float _simulatedStareTime;

		private readonly Stopwatch _simulatedStareSw = Stopwatch.StartNew();

		public bool LookingAtTarget { get; private set; }

		public float SimulatedStare
		{
			get
			{
				return Mathf.Max(0f, _simulatedStareTime - (float)_simulatedStareSw.Elapsed.TotalSeconds);
			}
			set
			{
				_simulatedStareTime = value;
				_simulatedStareSw.Restart();
			}
		}

		private void Update()
		{
			RefreshChaseState();
		}

		public void RefreshChaseState()
		{
			if (NetworkServer.active && base.Role.TryGetOwner(out var hub))
			{
				bool flag = SimulatedStare > 0f;
				LookingAtTarget = flag || AnyTargets(hub, hub.PlayerCameraReference);
				ServerSendRpc(toAll: true);
			}
		}

		private bool AnyTargets(ReferenceHub owner, Transform camera)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsHuman() && !allHub.playerEffectsController.GetEffect<Invisible>().IsEnabled && allHub.roleManager.CurrentRole is IFpcRole fpcRole && VisionInformation.GetVisionInformation(owner, camera, fpcRole.FpcModule.Position, fpcRole.FpcModule.CharacterControllerSettings.Radius, _maxViewDistance, checkFog: true, checkLineOfSight: true, 0, checkInDarkness: false).IsLooking)
				{
					return true;
				}
			}
			return false;
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBool(LookingAtTarget);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			LookingAtTarget = reader.ReadBool();
		}

		public void ResetObject()
		{
			_simulatedStareTime = 0f;
		}
	}
}

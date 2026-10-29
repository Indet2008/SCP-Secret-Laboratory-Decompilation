using CustomPlayerEffects;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using PlayerRoles;

namespace Hazards
{
	public class SinkholeEnvironmentalHazard : EnvironmentalHazard
	{
		public override bool OnEnter(ReferenceHub player)
		{
			if (!IsActive || player.IsSCP())
			{
				return false;
			}
			if (!base.OnEnter(player))
			{
				return false;
			}
			player.playerEffectsController.EnableEffect<Sinkhole>(1f);
			PlayerEvents.OnEnteredHazard(new PlayerEnteredHazardEventArgs(player, this));
			return true;
		}

		public override void OnStay(ReferenceHub player)
		{
			player.playerEffectsController.EnableEffect<Sinkhole>(1f);
		}

		public override bool OnExit(ReferenceHub player)
		{
			if (!base.OnExit(player))
			{
				return false;
			}
			player.playerEffectsController.EnableEffect<Sinkhole>(1f);
			PlayerEvents.OnLeftHazard(new PlayerLeftHazardEventArgs(player, this));
			return true;
		}

		protected override void Start()
		{
			base.Start();
			ClientApplyDecalSize();
		}

		private void ClientApplyDecalSize()
		{
			global::UnityEngine.Rendering.HighDefinition.DecalProjector[] componentsInChildren = base.gameObject.GetComponentsInChildren<global::UnityEngine.Rendering.HighDefinition.DecalProjector>();
			foreach (global::UnityEngine.Rendering.HighDefinition.DecalProjector decalProjector in componentsInChildren)
			{
				decalProjector.size = global::UnityEngine.Vector3.Scale(decalProjector.size, base.transform.localScale);
			}
			base.transform.localScale = global::UnityEngine.Vector3.one;
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

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
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

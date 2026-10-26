using PlayerRoles.PlayableScps.HumeShield;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106HumeShieldController : DynamicHumeShieldController
	{
		private Scp106Role _role106;

		private Scp106StalkAbility _stalk;

		public override float HsRegeneration
		{
			get
			{
				if (!_stalk.StalkActive || !_role106.Sinkhole.IsHidden)
				{
					return 0f;
				}
				return RegenerationRate * HsMax;
			}
		}

		public override void SpawnObject()
		{
			_role106 = base.Role as Scp106Role;
			_role106.SubroutineModule.TryGetSubroutine<Scp106StalkAbility>(out _stalk);
			base.SpawnObject();
		}
	}
}

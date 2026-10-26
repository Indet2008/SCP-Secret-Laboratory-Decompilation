using Mirror;

namespace CustomPlayerEffects
{
	public class Flashed : StatusEffectBase
	{
		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			float timeLeft = (float)(int)newState * 0.1f;
			if (NetworkServer.active)
			{
				base.TimeLeft = timeLeft;
			}
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active && base.Duration == 0f)
			{
				base.TimeLeft = 1f;
			}
		}
	}
}

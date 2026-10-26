using Mirror;

namespace PlayerRoles.Subroutines
{
	public class InconsistentAbilityCooldown : AbilityCooldown
	{
		public override void ReadCooldown(NetworkReader reader)
		{
			if (IsReady)
			{
				base.ReadCooldown(reader);
				return;
			}
			double num = reader.ReadDouble();
			double time = NetworkTime.time;
			double num2 = (num - time) / (double)base.Remaining;
			double num3 = time - base.InitialTime;
			base.InitialTime = time - num3 * num2;
			base.NextUse = num;
		}
	}
}

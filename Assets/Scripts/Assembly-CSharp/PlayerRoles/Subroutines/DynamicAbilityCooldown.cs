using Mirror;

namespace PlayerRoles.Subroutines
{
	public class DynamicAbilityCooldown : AbilityCooldown
	{
		private bool _appendCooldownNext;

		public void Append(double cooldown)
		{
			base.Remaining = (float)cooldown;
			_appendCooldownNext = true;
		}

		public override void WriteCooldown(NetworkWriter writer)
		{
			writer.WriteBool(_appendCooldownNext);
			base.WriteCooldown(writer);
			_appendCooldownNext = false;
		}

		public override void ReadCooldown(NetworkReader reader)
		{
			if (!reader.ReadBool())
			{
				base.ReadCooldown(reader);
			}
			else
			{
				base.NextUse = reader.ReadDouble();
			}
		}

		public override void Clear()
		{
			base.Clear();
			_appendCooldownNext = false;
		}
	}
}

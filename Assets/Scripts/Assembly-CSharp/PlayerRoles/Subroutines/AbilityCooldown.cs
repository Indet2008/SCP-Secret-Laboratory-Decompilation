using Mirror;
using UnityEngine;

namespace PlayerRoles.Subroutines
{
	public class AbilityCooldown : IAbilityCooldown
	{
		public double InitialTime { get; set; }

		public double NextUse { get; set; }

		public virtual bool IsReady => NetworkTime.time >= NextUse;

		public float Remaining
		{
			get
			{
				return Mathf.Max(0f, (float)(NextUse - NetworkTime.time));
			}
			set
			{
				NextUse = NetworkTime.time + (double)value;
			}
		}

		public float Readiness => Mathf.Clamp01((float)((NetworkTime.time - InitialTime) / (NextUse - InitialTime)));

		public virtual void WriteCooldown(NetworkWriter writer)
		{
			writer.WriteDouble(NextUse);
			writer.WriteDouble(InitialTime);
		}

		public virtual void ReadCooldown(NetworkReader reader)
		{
			NextUse = reader.ReadDouble();
			InitialTime = reader.ReadDouble();
		}

		public virtual void Clear()
		{
			InitialTime = 0.0;
			NextUse = 1.0;
		}

		public virtual void Trigger(double cooldown)
		{
			InitialTime = NetworkTime.time;
			NextUse = InitialTime + cooldown;
		}
	}
}

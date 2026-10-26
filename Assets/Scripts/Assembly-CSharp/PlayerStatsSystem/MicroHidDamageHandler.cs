using Footprinting;
using InventorySystem.Items.MicroHID;
using InventorySystem.Items.MicroHID.Modules;
using Mirror;

namespace PlayerStatsSystem
{
	public class MicroHidDamageHandler : AttackerDamageHandler, DisintegrateDeathAnimation.IDisintegrateDamageHandler
	{
		private readonly string _deathScreenText;

		private readonly string _serverLogsText;

		private readonly string _ragdollInspectText;

		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => Disintegrate;

		public override string ServerLogsText => _serverLogsText;

		public override string RagdollInspectText => _ragdollInspectText;

		public override string DeathScreenText => _deathScreenText;

		public MicroHidFiringMode FiringMode { get; private set; }

		public bool Disintegrate { get; private set; }

		public MicroHidDamageHandler(FiringModeControllerModule module, float impulseDamage)
		{
			_ragdollInspectText = DeathTranslations.MicroHID.RagdollTranslation;
			_deathScreenText = DeathTranslations.MicroHID.DeathscreenTranslation;
			if (!(module == null))
			{
				FiringMode = module.AssignedMode;
				Attacker = new Footprint(module.Item.Owner);
				_serverLogsText = "Deep fried by " + Attacker.Nickname + " with " + DeathTranslations.MicroHID.LogLabel + " using " + FiringMode;
				Damage = impulseDamage;
			}
		}

		public MicroHidDamageHandler(float damage, MicroHIDItem micro)
		{
			Attacker = new Footprint(micro.Owner);
			_serverLogsText = "MicroHID overcharge";
			Damage = damage;
			Disintegrate = true;
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			writer.WriteByte((byte)FiringMode);
			writer.WriteBool(Disintegrate);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			FiringMode = (MicroHidFiringMode)reader.ReadByte();
			Disintegrate = reader.ReadBool();
		}
	}
}

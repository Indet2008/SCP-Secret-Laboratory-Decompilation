using InventorySystem.Items.Firearms;
using Mirror;

namespace PlayerStatsSystem
{
	public class CustomReasonFirearmDamageHandler : FirearmDamageHandler
	{
		private string _ragdollText;

		private byte _translationId;

		public override string RagdollInspectText => _ragdollText;

		public CustomReasonFirearmDamageHandler()
		{
		}

		public CustomReasonFirearmDamageHandler(DeathTranslation deathTranslation, Firearm firearm, float damage, float penetration, bool useHumanMutlipliers = true)
			: base(firearm, damage, penetration, useHumanMutlipliers)
		{
			_translationId = deathTranslation.Id;
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			writer.WriteByte(_translationId);
			base.WriteAdditionalData(writer);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			_translationId = reader.ReadByte();
			if (DeathTranslations.TranslationsById.TryGetValue(_translationId, out var value))
			{
				_ragdollText = value.RagdollTranslation;
			}
			base.ReadAdditionalData(reader);
		}
	}
}

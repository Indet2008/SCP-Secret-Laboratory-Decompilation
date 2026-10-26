using System.Collections.Generic;

namespace PlayerStatsSystem
{
	public static class DeathTranslations
	{
		public static readonly Dictionary<byte, DeathTranslation> TranslationsById = new Dictionary<byte, DeathTranslation>();

		public static readonly DeathTranslation Recontained = new DeathTranslation(0, 2, 2, "Recontained.");

		public static readonly DeathTranslation Warhead = new DeathTranslation(1, 3, 3, "Vaporized by the Alpha Warhead.");

		public static readonly DeathTranslation Scp049 = new DeathTranslation(2, 4, 4, "Died to SCP-049.");

		public static readonly DeathTranslation Unknown = new DeathTranslation(3, 5, 5, "Unknown cause of death.");

		public static readonly DeathTranslation Asphyxiated = new DeathTranslation(4, 4, 7, "Asphyxiated.");

		public static readonly DeathTranslation Bleeding = new DeathTranslation(5, 8, 9, "Bleeding.");

		public static readonly DeathTranslation Falldown = new DeathTranslation(6, 10, 11, "Fall damage.");

		public static readonly DeathTranslation PocketDecay = new DeathTranslation(7, 12, 12, "Decayed in the Pocket Dimension.");

		public static readonly DeathTranslation Decontamination = new DeathTranslation(8, 13, 13, "Melted by a highly corrosive substance.");

		public static readonly DeathTranslation Poisoned = new DeathTranslation(9, 14, 15, "Poison.");

		public static readonly DeathTranslation Scp207 = new DeathTranslation(10, 16, 17, "SCP-207.");

		public static readonly DeathTranslation SeveredHands = new DeathTranslation(11, 8, 18, "Severed Hands from SCP-330.");

		public static readonly DeathTranslation MicroHID = new DeathTranslation(12, 6, 6, "Micro H.I.D.");

		public static readonly DeathTranslation Tesla = new DeathTranslation(13, 6, 19, "Tesla.");

		public static readonly DeathTranslation Explosion = new DeathTranslation(14, 20, 21, "Explosion.");

		public static readonly DeathTranslation Scp096 = new DeathTranslation(15, 22, 22, "Died to SCP-096.");

		public static readonly DeathTranslation Scp173 = new DeathTranslation(16, 23, 23, "Died to SCP-173.");

		public static readonly DeathTranslation Scp939Lunge = new DeathTranslation(17, 24, 24, "Lunged by SCP-939.");

		public static readonly DeathTranslation Zombie = new DeathTranslation(18, 25, 25, "Blunt trauma and minor scratches are present on the body.");

		public static readonly DeathTranslation BulletWounds = new DeathTranslation(19, 26, 26, "{0} bullet wounds.");

		public static readonly DeathTranslation Crushed = new DeathTranslation(20, 27, 27, "Crushed.");

		public static readonly DeathTranslation UsedAs106Bait = new DeathTranslation(21, 28, 29, "Used as bait for SCP-106.");

		public static readonly DeathTranslation FriendlyFireDetector = new DeathTranslation(22, 30, 30, "Automatically killed for friendly fire.");

		public static readonly DeathTranslation Hypothermia = new DeathTranslation(23, 31, 32, "Died to hypothermia.");

		public static readonly DeathTranslation CardiacArrest = new DeathTranslation(24, 4, 4, "Died to a heart attack.");

		public static readonly DeathTranslation Scp939Other = new DeathTranslation(25, 33, 33, "Died to SCP-939.");

		public static readonly DeathTranslation Scp3114Slap = new DeathTranslation(26, 25, 25, "Blunt trauma and minor scratches are present on the body.");

		public static readonly DeathTranslation MarshmallowMan = new DeathTranslation(27, 25, 34, "Killed by Marshmallow Man.");

		public static readonly DeathTranslation Scp1344 = new DeathTranslation(28, 8, 9, "Died to SCP-1344.");

		public static readonly DeathTranslation Scp1507Peck = new DeathTranslation(29, 25, 25, "Pecked by SCP-1507");

		public static readonly DeathTranslation Scp127Bullets = new DeathTranslation(30, 35, 35, "Bullet wounds with organic residue.");

		public static readonly DeathTranslation Scp1509 = new DeathTranslation(31, 36, 36, "Multiple open wounds with small insects crawling out of them.");
	}
}

using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	[CreateAssetMenu(fileName = "MyFallDamageSettings", menuName = "Northwood/Roles/Fall Damage Settings")]
	public class FallDamageSettings : ScriptableObject
	{
		public bool Enabled;

		public float MinVelocity;

		public float Power;

		public float Multiplier;

		public float Absolute;

		public float ImmunityTime;

		public float MaxDamage;

		public float CalculateDamage(float speed)
		{
			return Mathf.Clamp(Mathf.Pow(speed, Power) * Multiplier + Absolute, 0f, MaxDamage);
		}
	}
}

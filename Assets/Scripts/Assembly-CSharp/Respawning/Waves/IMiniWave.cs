using PlayerRoles;

namespace Respawning.Waves
{
	public interface IMiniWave
	{
		float WaveSizeMultiplier { get; set; }

		RoleTypeId DefaultRole { get; set; }

		RoleTypeId SpecialRole { get; set; }

		void Unlock(bool ignoreConfig = false);

		void ResetTokens();

		float GetInfluenceDifference(float? newValue);
	}
}

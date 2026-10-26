namespace Respawning.Waves.Generic
{
	public interface ILimitedWave
	{
		int InitialRespawnTokens { get; set; }

		int RespawnTokens { get; set; }
	}
}

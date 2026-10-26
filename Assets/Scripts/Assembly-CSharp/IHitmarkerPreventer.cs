using PlayerStatsSystem;

public interface IHitmarkerPreventer
{
	bool TryPreventHitmarker(AttackerDamageHandler attacker);
}

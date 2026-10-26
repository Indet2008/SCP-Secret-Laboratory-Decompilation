using PlayerRoles.PlayableScps.Scp106;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;

public class Scp106Breathing : StandardSubroutine<Scp106Role>
{
	private const float SelfMaxVolume = 0.5f;

	private const float MaxVolume = 1f;

	private Scp106SinkholeController _sinkholeController;

	[SerializeField]
	private AudioSource _breathingSource;

	protected override void Awake()
	{
		base.Awake();
		GetSubroutine<Scp106SinkholeController>(out _sinkholeController);
	}

	private void Update()
	{
		_breathingSource.volume = (1f - _sinkholeController.SubmergeProgress) * ((base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated()) ? 0.5f : 1f);
		_breathingSource.spatialBlend = ((base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated()) ? 0f : 1f);
	}
}

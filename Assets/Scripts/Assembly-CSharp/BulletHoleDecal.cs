using AudioPooling;
using Decals;
using UnityEngine;

public class BulletHoleDecal : Decal
{
	[SerializeField]
	private ParticleSystem _impactParticlesTemplate;

	[SerializeField]
	private Transform _impactParticlesTargetPosition;

	[SerializeField]
	private AudioClip[] _wallImpactSounds;

	[SerializeField]
	private AudioClip[] _doorImpactSounds;

	[SerializeField]
	private float _impactSoundRange = 10f;

	[SerializeField]
	private float _impactSoundVolume = 1f;

	[SerializeField]
	private float _impactSoundRandomization;

	private const int DoorLayer = 27;

	public override void AttachToSurface(RaycastHit hitSurface)
	{
		base.AttachToSurface(hitSurface);
		ParticleSystem fromPool = _impactParticlesTemplate.GetFromPool();
		fromPool.Play(withChildren: true);
		Transform obj = fromPool.transform;
		obj.SetParent(_impactParticlesTargetPosition);
		obj.ResetLocalPose();
		AudioSourcePoolManager.PlayOnTransform(((base.CachedTransform.parent.gameObject.layer == 27) ? _doorImpactSounds : _wallImpactSounds).RandomItem(), base.CachedTransform, _impactSoundRange, _impactSoundVolume).Source.pitch += Random.Range(0f - _impactSoundRandomization, _impactSoundRandomization);
	}
}

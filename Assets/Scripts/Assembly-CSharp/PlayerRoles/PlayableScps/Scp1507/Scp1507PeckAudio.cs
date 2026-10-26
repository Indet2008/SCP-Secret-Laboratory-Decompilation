using AudioPooling;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507PeckAudio : StandardSubroutine<Scp1507Role>
	{
		[SerializeField]
		private AudioClip _missClip;

		[SerializeField]
		private AudioClip _doorHitClip;

		[SerializeField]
		private float _audioPitchOffsetRandomization;

		private const float SoundRange = 13f;

		private const float BasePitch = 1f;

		private bool _attackedDoor;

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp1507AttackAbility>(out var sr);
			sr.ServerOnDoorAttacked += () =>
			{
				_attackedDoor = true;
				ServerSendRpc(toAll: true);
			};
			sr.ServerOnMissed += () =>
			{
				_attackedDoor = false;
				ServerSendRpc(toAll: true);
			};
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			writer.WriteBool(_attackedDoor);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			AudioSourcePoolManager.PlayOnTransform(reader.ReadBool() ? _doorHitClip : _missClip, pitchScale: 1f + Random.Range(0f - _audioPitchOffsetRandomization, _audioPitchOffsetRandomization), trackedTransform: base.transform, maxDistance: 13f);
		}
	}
}

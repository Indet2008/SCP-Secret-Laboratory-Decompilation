using System;
using MapGeneration;
using UnityEngine;

namespace FacilitySoundtrack
{
	public class ZoneAmbientSoundtrack : SoundtrackLayerBase
	{
		[Serializable]
		private class ZoneSoundtrack
		{
			public FacilityZone TargetZone;

			public AudioSource Source;

			public float VolumeScale;

			public float CrossfadeVolume { get; set; }
		}

		[SerializeField]
		private float _fadeInSpeed;

		[SerializeField]
		private float _fadeOutSpeed;

		[SerializeField]
		private float _crossfadeSpeed;

		[SerializeField]
		private ZoneSoundtrack[] _zoneSoundtracks;

		private float _weight;

		private FacilityZone _lastZone;

		public override bool Additive => true;

		public override float Weight => _weight;

		public override bool IsMuteable => true;

		public override void UpdateVolume(float masterScale)
		{
			RoomIdentifier room;
			if (AlphaWarheadController.Detonated)
			{
				_lastZone = FacilityZone.None;
			}
			else if (MainCameraController.LastPosition.TryGetRoom(out room))
			{
				_lastZone = room.Zone;
			}
			float num = (base.IsPovMuted ? (0f - _fadeOutSpeed) : _fadeInSpeed);
			_weight = Mathf.Clamp01(_weight + num * Time.deltaTime);
			ZoneSoundtrack[] zoneSoundtracks = _zoneSoundtracks;
			foreach (ZoneSoundtrack zoneSoundtrack in zoneSoundtracks)
			{
				float target = ((zoneSoundtrack.TargetZone == _lastZone) ? 1 : 0);
				zoneSoundtrack.CrossfadeVolume = Mathf.MoveTowards(zoneSoundtrack.CrossfadeVolume, target, _crossfadeSpeed * Time.deltaTime);
				zoneSoundtrack.Source.volume = zoneSoundtrack.CrossfadeVolume * zoneSoundtrack.VolumeScale * masterScale;
			}
		}
	}
}

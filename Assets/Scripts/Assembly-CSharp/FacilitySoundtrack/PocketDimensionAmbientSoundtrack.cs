using MapGeneration;
using UnityEngine;

namespace FacilitySoundtrack
{
	public class PocketDimensionAmbientSoundtrack : SoundtrackLayerBase
	{
		[SerializeField]
		private float _fadeInSpeed;

		[SerializeField]
		private float _fadeOutSpeed;

		[SerializeField]
		private AnimationCurve _bassBlendCurve;

		[SerializeField]
		private AnimationCurve _ambienceBlendCurve;

		[SerializeField]
		private float _startBassDistance;

		[SerializeField]
		private float _endBassDistance;

		[SerializeField]
		private AudioSource[] _bassSources;

		[SerializeField]
		private AudioSource _ambienceSource;

		private float _weight;

		public override bool Additive => false;

		public override float Weight => _weight;

		public override bool IsMuteable => true;

		public override void UpdateVolume(float masterScale)
		{
			Vector3 lastPosition = MainCameraController.LastPosition;
			if (!lastPosition.TryGetRoom(out var room) || room.Name != RoomName.Pocket)
			{
				_weight = Mathf.Max(0f, _weight - Time.deltaTime * _fadeOutSpeed);
				AudioSource[] bassSources = _bassSources;
				for (int i = 0; i < bassSources.Length; i++)
				{
					bassSources[i].UpdateFadeOut(_fadeOutSpeed);
				}
				_ambienceSource.volume = Mathf.Min(_ambienceSource.volume, masterScale);
				return;
			}
			if (_weight == 0f)
			{
				AudioSource[] bassSources = _bassSources;
				for (int i = 0; i < bassSources.Length; i++)
				{
					bassSources[i].Replay();
				}
				_ambienceSource.Replay();
			}
			float value = (lastPosition - room.transform.position).MagnitudeIgnoreY();
			float time = Mathf.InverseLerp(_startBassDistance, _endBassDistance, value);
			float num = _bassBlendCurve.Evaluate(time);
			_weight = Mathf.Min(1f, _weight + _fadeInSpeed * Time.deltaTime);
			_ambienceSource.volume = masterScale * _ambienceBlendCurve.Evaluate(time);
			for (int j = 0; j < _bassSources.Length; j++)
			{
				float num2 = Mathf.Abs((float)j - num + 1f);
				float num3 = num2 * num2;
				float num4 = Mathf.Clamp01(1f - num3);
				_bassSources[j].volume = num4 * masterScale;
			}
		}
	}
}

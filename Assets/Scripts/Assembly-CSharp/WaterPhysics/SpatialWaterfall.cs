using System;
using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using UnityEngine;

namespace WaterPhysics
{
	public class SpatialWaterfall : MonoBehaviour
	{
		[SerializeField]
		private float _areaFullVolume;

		[SerializeField]
		private float _areaSilent;

		[SerializeField]
		private RoomIdentifier _targetRoom;

		[SerializeField]
		private AudioSource[] _normalSources;

		[SerializeField]
		private AudioSource _muffledSource;

		private HashSet<DoorVariant> _doorsHs;

		private int _prevHsCnt;

		private float _fadeSqrDistance;

		private float _prevNormalVolume;

		private float _prevMuffledVolume;

		private Vector3[] _doorPositions;

		private DoorVariant[] _doors;

		private Bounds _boundsSilent;

		private Bounds _boundsFullVolume;

		private readonly Action<float> _setVolumeMuffled;

		private readonly Action<float> _setVolumeNormal;

		private const float VolumeAdjustSpeed = 10f;

		private const float BoundsHeight = 30f;

		public SpatialWaterfall()
		{
			_setVolumeMuffled = SetVolumeMuffled;
			_setVolumeNormal = SetVolumeNormal;
		}

		private void Start()
		{
			_doorsHs = DoorVariant.DoorsByRoom.GetOrAddNew(_targetRoom);
			Vector3 position = base.transform.position;
			_boundsSilent = new Bounds(position, new Vector3(_areaSilent, 30f, _areaSilent));
			_boundsFullVolume = new Bounds(position, new Vector3(_areaFullVolume, 30f, _areaFullVolume));
			float num = (_areaSilent - _areaFullVolume) / 2f;
			_fadeSqrDistance = num * num;
		}

		private void Update()
		{
			CalculateTargetVolumes(out var muffledVolume, out var normalVolume);
			MoveTowardsVolume(ref _prevMuffledVolume, muffledVolume, _setVolumeMuffled);
			MoveTowardsVolume(ref _prevNormalVolume, normalVolume, _setVolumeNormal);
		}

		private void MoveTowardsVolume(ref float prev, float target, Action<float> processor)
		{
			if (target != prev)
			{
				float num = Mathf.MoveTowards(prev, target, Time.deltaTime * 10f);
				processor(num);
				prev = num;
			}
		}

		private void SetVolumeNormal(float f)
		{
			AudioSource[] normalSources = _normalSources;
			foreach (AudioSource src in normalSources)
			{
				SetSrcVolume(src, f);
			}
		}

		private void SetVolumeMuffled(float f)
		{
			SetSrcVolume(_muffledSource, f);
		}

		private void SetSrcVolume(AudioSource src, float vol)
		{
			src.volume = vol;
			src.enabled = vol > 0f;
		}

		private void CalculateTargetVolumes(out float muffledVolume, out float normalVolume)
		{
			Vector3 lastPosition = MainCameraController.LastPosition;
			if (!_boundsSilent.Contains(lastPosition))
			{
				muffledVolume = 0f;
				normalVolume = 0f;
				return;
			}
			if (_boundsFullVolume.Contains(lastPosition))
			{
				muffledVolume = 0f;
				normalVolume = 1f;
				return;
			}
			ValidateDoorCache();
			int? num = null;
			float num2 = float.MaxValue;
			for (int i = 0; i < _prevHsCnt; i++)
			{
				float sqrMagnitude = (_doorPositions[i] - lastPosition).sqrMagnitude;
				if (!(sqrMagnitude > num2))
				{
					num2 = sqrMagnitude;
					num = i;
				}
			}
			if (!num.HasValue)
			{
				muffledVolume = 1f;
				normalVolume = 0f;
				return;
			}
			float exactState = _doors[num.Value].GetExactState();
			float num3 = Mathf.Clamp01(_boundsFullVolume.SqrDistance(lastPosition) / _fadeSqrDistance);
			normalVolume = exactState * (1f - num3);
			muffledVolume = 1f - normalVolume;
		}

		private void ValidateDoorCache()
		{
			int count = _doorsHs.Count;
			if (_prevHsCnt == count)
			{
				return;
			}
			_doorPositions = new Vector3[count];
			_doors = new DoorVariant[count];
			int num = 0;
			foreach (DoorVariant doorsH in _doorsHs)
			{
				_doors[num] = doorsH;
				_doorPositions[num] = doorsH.transform.position;
				num++;
			}
			_prevHsCnt = count;
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.blue;
			Gizmos.DrawWireCube(base.transform.position, Vector3.one * _areaFullVolume);
			Gizmos.color = Color.cyan;
			Gizmos.DrawWireCube(base.transform.position, Vector3.one * _areaSilent);
		}
	}
}

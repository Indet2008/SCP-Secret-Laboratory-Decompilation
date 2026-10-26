using System;
using System.Collections.Generic;
using NorthwoodLib.Pools;
using UnityEngine;

namespace MapGeneration
{
	public class EntranceZoneGenerator : AtlasZoneGenerator
	{
		[SerializeField]
		private AtlasZoneGenerator _hcz;

		[SerializeField]
		private Vector3 _hardPositionOffset;

		[SerializeField]
		private float _hardRotationOffset;

		private Vector3 _positionOffset;

		public override void Generate(System.Random rng)
		{
			if (_hcz == null || _hcz.Interpreted == null)
			{
				throw new InvalidOperationException("Entrance Zone requires HCZ to generate first. Adjust the order of execution.");
			}
			base.Generate(rng);
		}

		protected override void RandomizeInterpreted(System.Random rng)
		{
			OnBeforeRandomize();
			base.RandomizeInterpreted(rng);
		}

		public override void GetPositionAndRotation(AtlasInterpretation toSpawn, out Vector3 worldPosition, out float yRotation)
		{
			base.GetPositionAndRotation(toSpawn, out worldPosition, out yRotation);
			worldPosition += _positionOffset;
			yRotation += _hardRotationOffset;
		}

		private void OnBeforeRandomize()
		{
			FindCheckpointPositions(_hcz, out var centroid);
			FindCheckpointPositions(this, out var centroid2);
			_positionOffset = centroid - centroid2 + _hardPositionOffset;
		}

		private void FindCheckpointPositions(AtlasZoneGenerator generator, out Vector3 centroid)
		{
			List<Vector3> list = ListPool<Vector3>.Shared.Rent();
			AtlasInterpretation[] interpreted = generator.Interpreted;
			for (int i = 0; i < interpreted.Length; i++)
			{
				AtlasInterpretation toSpawn = interpreted[i];
				if (toSpawn.RoomShape == RoomShape.Straight && toSpawn.SpecificRooms.Contains(RoomName.HczCheckpointToEntranceZone))
				{
					generator.GetPositionAndRotation(toSpawn, out var worldPosition, out var _);
					list.Add(worldPosition);
				}
			}
			if (list.Count != 2)
			{
				throw new InvalidOperationException("HCZ-EZ require two checkpoints!");
			}
			centroid = (list[0] + list[1]) / 2f;
			ListPool<Vector3>.Shared.Return(list);
		}
	}
}

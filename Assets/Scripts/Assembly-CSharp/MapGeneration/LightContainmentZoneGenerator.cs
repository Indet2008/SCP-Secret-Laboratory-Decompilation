using System;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace MapGeneration
{
	public class LightContainmentZoneGenerator : AtlasZoneGenerator
	{
		[Serializable]
		private class LabelSettings
		{
			public RoomName Name;

			public RoomShape Shape;

			public Material Label;

			public int DefaultNumber;
		}

		[SerializeField]
		private LabelSettings[] _settings;

		[SerializeField]
		private Material[] _numbers;

		private const float NextRoomLabelScanRange = 8f;

		public override void Generate(System.Random rng)
		{
			base.Generate(rng);
			LCZ_Label.AllLabels.ForEach(SetLabel);
		}

		private void SetLabel(LCZ_Label label)
		{
			if (!TryFindRoom(label.transform, out var ret))
			{
				return;
			}
			LabelSettings[] settings = _settings;
			foreach (LabelSettings labelSettings in settings)
			{
				if (labelSettings.Name == ret.Room.Name && labelSettings.Shape == ret.Room.Shape)
				{
					int num = labelSettings.DefaultNumber + ret.DuplicateId;
					label.Refresh(labelSettings.Label, _numbers[num % _numbers.Length]);
					break;
				}
			}
		}

		private bool TryFindRoom(Transform labelTr, out SpawnableRoom ret)
		{
			Vector3 point = labelTr.position + labelTr.forward * 8f;
			foreach (SpawnedRoomData item in Spawned)
			{
				RoomIdentifier room = item.Instance.Room;
				if (new Bounds(room.transform.position, RoomIdentifier.GridScale).Contains(point))
				{
					ret = item.Instance;
					return true;
				}
			}
			ret = null;
			return false;
		}
	}
}

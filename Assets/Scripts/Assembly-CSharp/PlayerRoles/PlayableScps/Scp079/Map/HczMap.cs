using System;
using System.Collections.Generic;
using MapGeneration;
using MapGeneration.Distributors;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;
using UnityEngine.UI;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public class HczMap : ProceduralZoneMap
	{
		private static readonly Color GeneratorColor = new Color(1f, 0.1f, 0f, 0.15f);

		private const RoomName RotateRoom = RoomName.HczCheckpointToEntranceZone;

		private const float AngleOffset = 180f;

		[SerializeField]
		private ProceduralZoneMap _entranceMap;

		protected override void PlaceRooms()
		{
			base.PlaceRooms();
			if (RoomIdentifier.AllRoomIdentifiers.TryGetFirst((RoomIdentifier x) => x.Name == RoomName.HczCheckpointToEntranceZone && x.Zone == FacilityZone.HeavyContainment, out var first) && NodesByRoom.TryGetValue(first, out var value))
			{
				float z = value.Transform.localEulerAngles.z;
				Rotate(AllNodes, z);
				Rotate(_entranceMap.AllNodes, z);
			}
		}

		public override void UpdateOpened(Scp079Camera curCam)
		{
			base.UpdateOpened(curCam);
			float f = Mathf.Sin(Time.timeSinceLevelLoad * MathF.PI);
			foreach (Scp079Generator allGenerator in Scp079Recontainer.AllGenerators)
			{
				if (allGenerator.Activating && NodesByRoom.TryGetValue(allGenerator.ParentRoom, out var value))
				{
					Image icon = value.Icon;
					icon.color = Color.Lerp(icon.color, GeneratorColor, Mathf.Abs(f));
				}
			}
		}

		private void Rotate(List<RoomNode> nodesToRotate, float angleDeg)
		{
			Vector3 vector = Vector3.forward * (180f - angleDeg);
			foreach (RoomNode item in nodesToRotate)
			{
				RectTransform rectTransform = item.Transform;
				rectTransform.localPosition = Quaternion.Euler(vector) * rectTransform.localPosition;
				rectTransform.Rotate(vector, Space.Self);
			}
		}
	}
}

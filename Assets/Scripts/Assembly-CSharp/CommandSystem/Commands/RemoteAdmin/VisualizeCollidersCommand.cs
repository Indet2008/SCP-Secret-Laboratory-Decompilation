using System;
using System.Collections.Generic;
using AdminToys;
using MapGeneration;
using Mirror;
using PlayerRoles;
using RemoteAdmin;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class VisualizeCollidersCommand : ICommand
	{
		private record RoomInstancePair(RoomIdentifier Room, PrimitiveObjectToy Instance);

		private static readonly List<RoomInstancePair> ActiveInstances = new List<RoomInstancePair>();

		private static readonly Dictionary<string, Color> LayerToColor = new Dictionary<string, Color>
		{
			["Default"] = Color.red,
			["InvisibleCollider"] = Color.green,
			["Glass"] = Color.blue,
			["Fence"] = Color.cyan,
			["TransparentFX"] = Color.clear
		};

		public string Command { get; } = "visualizecolliders";

		public string[] Aliases { get; } = new string[2] { "visualisecolliders", "viscols" };

		public string Description { get; } = "Toggles box collider visualization in the current room.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!TryPrevalidate(sender, out response, out var rid, out var primitiveTemplate))
			{
				return false;
			}
			ClearNullInstances();
			bool flag = false;
			foreach (RoomInstancePair activeInstance in ActiveInstances)
			{
				if (!(activeInstance.Room != rid))
				{
					flag = true;
					NetworkServer.Destroy(activeInstance.Instance.gameObject);
				}
			}
			if (flag)
			{
				response = "Colliders visualization turned off.";
				return true;
			}
			BoxCollider[] componentsInChildren = rid.GetComponentsInChildren<BoxCollider>();
			int num = 0;
			BoxCollider[] array = componentsInChildren;
			foreach (BoxCollider boxCollider in array)
			{
				string key = LayerMask.LayerToName(boxCollider.gameObject.layer);
				Color valueOrDefault = LayerToColor.GetValueOrDefault(key, Color.white);
				PrimitiveObjectToy primitiveObjectToy = UnityEngine.Object.Instantiate(primitiveTemplate);
				primitiveObjectToy.NetworkPrimitiveType = PrimitiveType.Cube;
				primitiveObjectToy.NetworkPrimitiveFlags = PrimitiveFlags.Visible;
				primitiveObjectToy.NetworkMaterialColor = new Color(valueOrDefault.r, valueOrDefault.g, valueOrDefault.b, 0.7f);
				Transform transform = primitiveObjectToy.transform;
				Transform transform2 = boxCollider.transform;
				transform2.GetPositionAndRotation(out var position, out var rotation);
				Vector3 vector = transform2.TransformVector(boxCollider.center);
				transform.SetPositionAndRotation(position + vector, rotation);
				transform.localScale = Vector3.Scale(transform2.lossyScale, boxCollider.size);
				num++;
				ActiveInstances.Add(new RoomInstancePair(rid, primitiveObjectToy));
				NetworkServer.Spawn(primitiveObjectToy.gameObject);
			}
			response = $"Successfully visualized {num} box colliders.";
			return true;
		}

		private static bool TryPrevalidate(ICommandSender sender, out string response, out RoomIdentifier rid, out PrimitiveObjectToy primitiveTemplate)
		{
			rid = null;
			primitiveTemplate = null;
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "You must be in-game to use this command!";
				return false;
			}
			if (!playerCommandSender.ReferenceHub.IsAlive())
			{
				response = "You need to be alive to run this command!";
				return false;
			}
			if (!playerCommandSender.ReferenceHub.TryGetCurrentRoom(out rid))
			{
				response = "Current room not found.";
				return false;
			}
			foreach (GameObject value in NetworkClient.prefabs.Values)
			{
				if (value.TryGetComponent<PrimitiveObjectToy>(out primitiveTemplate))
				{
					return true;
				}
			}
			response = "Primitive template not found.";
			return false;
		}

		private static void ClearNullInstances()
		{
			for (int num = ActiveInstances.Count - 1; num >= 0; num--)
			{
				RoomInstancePair roomInstancePair = ActiveInstances[num];
				if (!(roomInstancePair.Instance != null) || !(roomInstancePair.Room != null))
				{
					ActiveInstances.RemoveAt(num);
				}
			}
		}
	}
}

using System;
using System.Collections.Generic;
using MapGeneration;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public abstract class Scp079InteractableBase : MonoBehaviour
	{
		public static readonly List<Scp079InteractableBase> OrderedInstances = new List<Scp079InteractableBase>();

		public static readonly HashSet<Scp079InteractableBase> AllInstances = new HashSet<Scp079InteractableBase>();

		public static int InstancesCount;

		public ushort SyncId { get; internal set; }

		public Vector3 Position { get; set; }

		public virtual RoomIdentifier Room { get; set; }

		protected virtual void OnRegistered()
		{
			if (base.transform.position.TryGetRoom(out var room))
			{
				Room = room;
			}
			else
			{
				Debug.LogError("This SCP-079 interactable does not have a room assigned!", base.gameObject);
			}
		}

		protected virtual void Awake()
		{
			AllInstances.Add(this);
		}

		protected virtual void OnDestroy()
		{
			if (AllInstances.Remove(this))
			{
				OrderedInstances[SyncId - 1] = null;
			}
		}

		public override string ToString()
		{
			string text = ((base.transform.parent == null) ? "null" : base.transform.parent.name);
			return GetType().Name + " @ (" + base.transform.root.name + "/.../" + text + "/" + base.name + ")";
		}

		public static bool TryGetInteractable(ushort syncId, out Scp079InteractableBase result)
		{
			if (syncId == 0 || syncId > InstancesCount || !SeedSynchronizer.MapGenerated)
			{
				result = null;
				return false;
			}
			result = OrderedInstances[syncId - 1];
			return true;
		}

		public static bool TryGetInteractable<T>(ushort syncId, out T result) where T : Scp079InteractableBase
		{
			if (!TryGetInteractable(syncId, out var result2) || !(result2 is T val))
			{
				result = null;
				return false;
			}
			result = val;
			return true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			SeedSynchronizer.OnGenerationStage += OnMapGenStage;
		}

		private static void OnMapGenStage(MapGenerationPhase stage)
		{
			if (stage == MapGenerationPhase.ParentRoomRegistration)
			{
				RegisterIds();
			}
		}

		private static void RegisterIds()
		{
			AllInstances.RemoveWhere((Scp079InteractableBase x) => !x.gameObject.activeInHierarchy);
			OrderedInstances.Clear();
			InstancesCount = 0;
			foreach (Scp079InteractableBase allInstance in AllInstances)
			{
				HandleInstance(allInstance);
			}
			for (ushort num = 1; num <= InstancesCount; num++)
			{
				Scp079InteractableBase scp079InteractableBase = OrderedInstances[num - 1];
				scp079InteractableBase.SyncId = num;
				scp079InteractableBase.OnRegistered();
			}
		}

		private static void HandleInstance(Scp079InteractableBase instance)
		{
			instance.Position = instance.transform.position;
			for (int i = 0; i < InstancesCount; i++)
			{
				if (CheckPriority(instance, OrderedInstances[i]))
				{
					OrderedInstances.Insert(i, instance);
					InstancesCount++;
					return;
				}
			}
			OrderedInstances.Add(instance);
			InstancesCount++;
		}

		private static bool CheckPriority(Scp079InteractableBase target, Scp079InteractableBase other)
		{
			Vector3 position = target.Position;
			Vector3 position2 = other.Position;
			for (int i = 0; i < 3; i++)
			{
				if (!Mathf.Approximately(position[i], position2[i]))
				{
					return position[i] < position2[i];
				}
			}
			throw new InvalidOperationException($"Position signature collision detected between {target} and {other}!");
		}
	}
}

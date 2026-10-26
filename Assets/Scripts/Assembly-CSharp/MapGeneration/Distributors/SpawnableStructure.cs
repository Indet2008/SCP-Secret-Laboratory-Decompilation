using System;
using System.Collections.Generic;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace MapGeneration.Distributors
{
	[RequireComponent(typeof(StructurePositionSync))]
	public class SpawnableStructure : NetworkBehaviour
	{
		public static readonly HashSet<SpawnableStructure> AllInstances = new HashSet<SpawnableStructure>();

		public StructureType StructureType;

		[Tooltip("Defines the number of minimum and maximum amounts of instances of this structure. The generator chooses a random horizontal point between 0 to 1, and reads its vertical value.")]
		public AnimationCurve MinMaxProbability = AnimationCurve.Constant(0f, 0f, 0f);

		public RoomIdentifier ParentRoom { get; private set; }

		public int MinAmount => Mathf.FloorToInt(MinMaxProbability.Evaluate(0f));

		public int MaxAmount => Mathf.FloorToInt(MinMaxProbability.Evaluate(1f));

		public static event Action<SpawnableStructure> OnAdded;

		public static event Action<SpawnableStructure> OnRemoved;

		protected virtual void Start()
		{
			if (SeedSynchronizer.MapGenerated)
			{
				RegisterRoom();
			}
			AllInstances.Add(this);
			OnAdded?.Invoke(this);
		}

		protected virtual void OnDestroy()
		{
			AllInstances.Remove(this);
			OnRemoved?.Invoke(this);
		}

		protected virtual void RegisterRoom()
		{
			bool activeSelf = base.gameObject.activeSelf;
			base.gameObject.SetActive(value: false);
			if (base.transform.position.TryGetRoom(out var room))
			{
				ParentRoom = room;
			}
			else
			{
				Debug.LogError("This structure (" + base.transform.GetHierarchyPath() + ") spawned outside of a room.", base.gameObject);
			}
			base.gameObject.SetActive(activeSelf);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			SeedSynchronizer.OnGenerationStage += (MapGenerationPhase phase) =>
			{
				if (phase == MapGenerationPhase.ParentRoomRegistration)
				{
					AllInstances.ForEach((SpawnableStructure x) =>
					{
						x.RegisterRoom();
					});
				}
			};
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

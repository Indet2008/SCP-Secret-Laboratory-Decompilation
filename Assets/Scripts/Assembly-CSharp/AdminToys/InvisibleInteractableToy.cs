using System;
using System.Runtime.InteropServices;
using Interactables;
using Interactables.Verification;
using InventorySystem.Searching;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;

namespace AdminToys
{
	public class InvisibleInteractableToy : AdminToyBase, IServerInteractable, IInteractable, ISearchable
	{
		public class InteractableToySearchCompletor : ISearchCompletor
		{
			private readonly InvisibleInteractableToy _target;

			private readonly double _maxDistanceSqr;

			public ReferenceHub Hub { get; }

			public InteractableToySearchCompletor(ReferenceHub hub, InvisibleInteractableToy target, double sqrDistance)
			{
				Hub = hub;
				_target = target;
				_maxDistanceSqr = sqrDistance;
			}

			public bool ValidateStart()
			{
				PlayerSearchingToyEventArgs e = new PlayerSearchingToyEventArgs(Hub, _target);
				PlayerEvents.OnSearchingToy(e);
				if (!e.IsAllowed)
				{
					return false;
				}
				_target.OnSearching?.Invoke(Hub);
				if (!_target.IsLocked)
				{
					return ValidateDistance();
				}
				return false;
			}

			public bool ValidateUpdate()
			{
				return ValidateDistance();
			}

			public void Complete()
			{
				_target.OnSearched?.Invoke(Hub);
				PlayerEvents.OnSearchedToy(new PlayerSearchedToyEventArgs(Hub, _target));
			}

			private bool ValidateDistance()
			{
				return (double)(_target.transform.position - Hub.transform.position).sqrMagnitude <= _maxDistanceSqr;
			}
		}

		public enum ColliderShape
		{
			Box = 0,
			Sphere = 1,
			Capsule = 2
		}

		[SyncVar(hook = "SetCollider")]
		public ColliderShape Shape;

		[SyncVar]
		public float InteractionDuration;

		[SyncVar]
		public bool IsLocked;

		private Collider _collider;

		public override string CommandName => "Interactable";

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public bool CanSearch
		{
			get
			{
				if (InteractionDuration > 0f)
				{
					return !IsLocked;
				}
				return false;
			}
		}

		public ColliderShape NetworkShape
		{
			get
			{
				return Shape;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Shape, 32uL, SetCollider);
			}
		}

		public float NetworkInteractionDuration
		{
			get
			{
				return InteractionDuration;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref InteractionDuration, 64uL, null);
			}
		}

		public bool NetworkIsLocked
		{
			get
			{
				return IsLocked;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref IsLocked, 128uL, null);
			}
		}

		NetworkIdentity ISearchable.netIdentity => base.netIdentity;

		public event Action<ReferenceHub> OnInteracted;

		public event Action<ReferenceHub> OnSearching;

		public event Action<ReferenceHub> OnSearched;

		public event Action<ReferenceHub> OnSearchAborted;

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			string[] array = arguments.Array;
			NetworkShape = ((array.Length > 2 && Enum.TryParse<ColliderShape>(array[2], ignoreCase: true, out var result)) ? result : ColliderShape.Box);
			NetworkInteractionDuration = ((array.Length > 3 && float.TryParse(array[3], out var result2)) ? result2 : 0f);
			float num = ((array.Length > 4 && float.TryParse(array[4], out var result3)) ? result3 : 1f);
			base.transform.SetPositionAndRotation(admin.PlayerCameraReference.position, admin.PlayerCameraReference.rotation);
			base.transform.localScale = base.transform.localScale * num;
			OnInteracted += (ReferenceHub x) =>
			{
				admin.gameConsoleTransmission.SendToClient($"{x} triggered OnInteraction", "green");
			};
			OnSearching += (ReferenceHub x) =>
			{
				admin.gameConsoleTransmission.SendToClient($"{x} triggered OnSearching", "green");
			};
			OnSearched += (ReferenceHub x) =>
			{
				admin.gameConsoleTransmission.SendToClient($"{x} triggered OnSearched", "green");
			};
			OnSearchAborted += (ReferenceHub x) =>
			{
				admin.gameConsoleTransmission.SendToClient($"{x} triggered OnSearchAborted", "green");
			};
			base.OnSpawned(admin, arguments);
		}

		protected override void Start()
		{
			base.Start();
			SetCollider(ColliderShape.Box, Shape);
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!(InteractionDuration > 0f))
			{
				OnInteracted?.Invoke(ply);
				PlayerEvents.OnInteractedToy(new PlayerInteractedToyEventArgs(ply, this));
			}
		}

		public ISearchCompletor GetSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			return new InteractableToySearchCompletor(coordinator.Hub, this, sqrDistance);
		}

		public float SearchTimeForPlayer(ReferenceHub hub)
		{
			return InteractionDuration;
		}

		public bool ServerValidateRequest(NetworkConnection source, SearchSessionPipe session)
		{
			if (!CanSearch)
			{
				session.Invalidate();
				return false;
			}
			return true;
		}

		public void ServerHandleAbort(ReferenceHub hub)
		{
			OnSearchAborted?.Invoke(hub);
			PlayerEvents.OnSearchToyAborted(new PlayerSearchToyAbortedEventArgs(hub, this));
		}

		private void SetCollider(ColliderShape _, ColliderShape newShape)
		{
			if (_collider != null)
			{
				UnityEngine.Object.Destroy(_collider);
			}
			switch (newShape)
			{
			case ColliderShape.Box:
				_collider = base.gameObject.AddComponent<BoxCollider>();
				break;
			case ColliderShape.Sphere:
				_collider = base.gameObject.AddComponent<SphereCollider>();
				break;
			case ColliderShape.Capsule:
			{
				CapsuleCollider capsuleCollider = base.gameObject.AddComponent<CapsuleCollider>();
				capsuleCollider.height = 2f;
				capsuleCollider.radius = 0.5f;
				_collider = capsuleCollider;
				break;
			}
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				GeneratedNetworkCode._Write_AdminToys_002EInvisibleInteractableToy_002FColliderShape(writer, Shape);
				writer.WriteFloat(InteractionDuration);
				writer.WriteBool(IsLocked);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				GeneratedNetworkCode._Write_AdminToys_002EInvisibleInteractableToy_002FColliderShape(writer, Shape);
			}
			if ((base.syncVarDirtyBits & 0x40L) != 0L)
			{
				writer.WriteFloat(InteractionDuration);
			}
			if ((base.syncVarDirtyBits & 0x80L) != 0L)
			{
				writer.WriteBool(IsLocked);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref Shape, SetCollider, GeneratedNetworkCode._Read_AdminToys_002EInvisibleInteractableToy_002FColliderShape(reader));
				GeneratedSyncVarDeserialize(ref InteractionDuration, null, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref IsLocked, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Shape, SetCollider, GeneratedNetworkCode._Read_AdminToys_002EInvisibleInteractableToy_002FColliderShape(reader));
			}
			if ((num & 0x40L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref InteractionDuration, null, reader.ReadFloat());
			}
			if ((num & 0x80L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref IsLocked, null, reader.ReadBool());
			}
		}
	}
}

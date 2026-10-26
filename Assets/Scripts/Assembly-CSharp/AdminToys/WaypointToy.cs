using System;
using System.Runtime.InteropServices;
using Mirror;
using RelativePositioning;
using UnityEngine;

namespace AdminToys
{
	public class WaypointToy : AdminToyBase
	{
		public const float MaxBounds = 255.9961f;

		[SyncVar(hook = "OnVisualizeBoundsSet")]
		public bool VisualizeBounds;

		[SyncVar]
		public float Priority;

		[NonSerialized]
		[SyncVar(hook = "OnBoundsSizeSet")]
		public Vector3 BoundsSize = Vector3.one * 255.9961f;

		[SerializeField]
		private AdminToyWaypoint _waypoint;

		[SerializeField]
		private Renderer _visualizer;

		private Vector3 _prevPos;

		private Quaternion _prevRot;

		private byte _waypointId;

		public override string CommandName => "Waypoint";

		public bool NetworkVisualizeBounds
		{
			get
			{
				return VisualizeBounds;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref VisualizeBounds, 32uL, OnVisualizeBoundsSet);
			}
		}

		public float NetworkPriority
		{
			get
			{
				return Priority;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Priority, 64uL, null);
			}
		}

		public Vector3 NetworkBoundsSize
		{
			get
			{
				return BoundsSize;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref BoundsSize, 128uL, OnBoundsSizeSet);
			}
		}

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			string[] array = arguments.Array;
			float x = ((array.Length > 2 && float.TryParse(array[2], out var result)) ? result : 255.9961f);
			float y = ((array.Length > 3 && float.TryParse(array[3], out var result2)) ? result2 : 255.9961f);
			float z = ((array.Length > 4 && float.TryParse(array[4], out var result3)) ? result3 : 255.9961f);
			NetworkBoundsSize = new Vector3(x, y, z);
			NetworkPriority = ((array.Length > 5 && float.TryParse(array[5], out var result4)) ? result4 : 0f);
			NetworkVisualizeBounds = array.Length > 6 && bool.TryParse(array[6], out var result5) && result5;
			base.transform.SetPositionAndRotation(admin.PlayerCameraReference.position, admin.PlayerCameraReference.rotation);
			base.OnSpawned(admin, arguments);
		}

		public void UpdateWaypointChildren()
		{
			base.transform.GetPositionAndRotation(out var position, out var rotation);
			_waypoint.OnMoved(position - _prevPos, rotation * Quaternion.Inverse(_prevRot));
			_prevPos = position;
			_prevRot = rotation;
		}

		protected override void Start()
		{
			base.Start();
			base.transform.GetPositionAndRotation(out _prevPos, out _prevRot);
		}

		protected override void LateUpdate()
		{
			_waypoint.IsStatic = IsStatic;
			_waypoint.Priority = Priority;
			if (!IsStatic)
			{
				base.LateUpdate();
				UpdateWaypointChildren();
			}
		}

		public override void OnStartServer()
		{
			base.OnStartServer();
			_waypointId = _waypoint.ServerAssignId();
		}

		public override void OnStartClient()
		{
			base.OnStartClient();
			if (!NetworkServer.active)
			{
				_waypoint.ClientAssignId(_waypointId);
			}
		}

		public override void OnSerialize(NetworkWriter writer, bool initialState)
		{
			base.OnSerialize(writer, initialState);
			if (initialState)
			{
				writer.WriteByte(_waypointId);
			}
		}

		public override void OnDeserialize(NetworkReader reader, bool initialState)
		{
			base.OnDeserialize(reader, initialState);
			if (initialState)
			{
				_waypointId = reader.ReadByte();
			}
		}

		private void OnVisualizeBoundsSet(bool prevState, bool newState)
		{
			_visualizer.enabled = newState;
		}

		private void OnBoundsSizeSet(Vector3 _, Vector3 newSize)
		{
			NetworkBoundsSize = Vector3.Min(newSize, Vector3.one * 255.9961f).Abs();
			_visualizer.transform.localScale = BoundsSize;
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
				writer.WriteBool(VisualizeBounds);
				writer.WriteFloat(Priority);
				writer.WriteVector3(BoundsSize);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				writer.WriteBool(VisualizeBounds);
			}
			if ((base.syncVarDirtyBits & 0x40L) != 0L)
			{
				writer.WriteFloat(Priority);
			}
			if ((base.syncVarDirtyBits & 0x80L) != 0L)
			{
				writer.WriteVector3(BoundsSize);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref VisualizeBounds, OnVisualizeBoundsSet, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref Priority, null, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref BoundsSize, OnBoundsSizeSet, reader.ReadVector3());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref VisualizeBounds, OnVisualizeBoundsSet, reader.ReadBool());
			}
			if ((num & 0x40L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Priority, null, reader.ReadFloat());
			}
			if ((num & 0x80L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref BoundsSize, OnBoundsSizeSet, reader.ReadVector3());
			}
		}
	}
}

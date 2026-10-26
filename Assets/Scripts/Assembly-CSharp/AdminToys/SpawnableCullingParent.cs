using System;
using System.Runtime.InteropServices;
using DrawableLine;
using Mirror;
using ProgressiveCulling;
using UnityEngine;

namespace AdminToys
{
	public class SpawnableCullingParent : NetworkBehaviour, IRootCullable, ICullable, IBoundsCullable
	{
		[SyncVar(hook = "SetBoundsPosition")]
		public Vector3 BoundsPosition;

		[SyncVar(hook = "SetBoundsSize")]
		public Vector3 BoundsSize;

		public RootCullablePriority Priority => RootCullablePriority.Dynamic;

		public bool ShouldBeVisible => CullingCamera.CheckBoundsVisibility(WorldspaceBounds);

		public Bounds WorldspaceBounds { get; private set; }

		public Vector3 NetworkBoundsPosition
		{
			get
			{
				return BoundsPosition;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref BoundsPosition, 1uL, SetBoundsPosition);
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
				GeneratedSyncVarSetter(value, ref BoundsSize, 2uL, SetBoundsSize);
			}
		}

		public static event Action<SpawnableCullingParent> OnAdded;

		public static event Action<SpawnableCullingParent> OnRemoved;

		public void SetupCache()
		{
			WorldspaceBounds = new Bounds(BoundsPosition, BoundsSize.Abs());
		}

		public void SetVisibility(bool isVisible)
		{
			base.gameObject.SetActive(isVisible);
		}

		public void DrawDebugBounds(Color? color, float duration = 5f)
		{
			Color valueOrDefault = color.GetValueOrDefault();
			if (!color.HasValue)
			{
				valueOrDefault = Color.green;
				color = valueOrDefault;
			}
			DrawableLines.GenerateBounds(WorldspaceBounds, duration, color);
		}

		private void Start()
		{
			CullingCamera.RegisterRootCullable(this);
			OnAdded?.Invoke(this);
		}

		private void OnDestroy()
		{
			CullingCamera.UnregisterRootCullable(this);
			OnRemoved?.Invoke(this);
		}

		private void SetBoundsPosition(Vector3 _, Vector3 newPos)
		{
			WorldspaceBounds = new Bounds(newPos, WorldspaceBounds.size);
			base.transform.position = newPos;
		}

		private void SetBoundsSize(Vector3 _, Vector3 newSize)
		{
			WorldspaceBounds = new Bounds(WorldspaceBounds.center, newSize.Abs());
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
				writer.WriteVector3(BoundsPosition);
				writer.WriteVector3(BoundsSize);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteVector3(BoundsPosition);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteVector3(BoundsSize);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref BoundsPosition, SetBoundsPosition, reader.ReadVector3());
				GeneratedSyncVarDeserialize(ref BoundsSize, SetBoundsSize, reader.ReadVector3());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref BoundsPosition, SetBoundsPosition, reader.ReadVector3());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref BoundsSize, SetBoundsSize, reader.ReadVector3());
			}
		}
	}
}

using System;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace RelativePositioning
{
	public struct RelativePosition : NetworkMessage, IEquatable<RelativePosition>
	{
		private static readonly float InverseAccuracy = 1f / 256f;

		public const float Accuracy = 256f;

		public readonly short PositionX;

		public readonly short PositionY;

		public readonly short PositionZ;

		public readonly byte WaypointId;

		public bool OutOfRange;

		public Vector3 Position => WaypointBase.GetWorldPosition(WaypointId, Relative);

		internal Vector3 Relative => new Vector3((float)PositionX * InverseAccuracy, (float)PositionY * InverseAccuracy, (float)PositionZ * InverseAccuracy);

		public RelativePosition(Vector3 targetPos)
		{
			WaypointBase.GetRelativePosition(targetPos, out WaypointId, out var rel);
			bool flag = TryCompressPosition(rel.x, out PositionX);
			bool flag2 = TryCompressPosition(rel.y, out PositionY);
			bool flag3 = TryCompressPosition(rel.z, out PositionZ);
			OutOfRange = !flag || !flag2 || !flag3;
		}

		public RelativePosition(IFpcRole fpc)
			: this(fpc.FpcModule.Position)
		{
		}

		public RelativePosition(ReferenceHub hub)
			: this((hub.roleManager.CurrentRole is IFpcRole fpcRole) ? fpcRole.FpcModule.Position : hub.transform.position)
		{
		}

		public RelativePosition(NetworkReader reader)
		{
			WaypointId = reader.ReadByte();
			if (WaypointId > 0)
			{
				PositionX = reader.ReadShort();
				PositionY = reader.ReadShort();
				PositionZ = reader.ReadShort();
			}
			else
			{
				PositionX = 0;
				PositionY = 0;
				PositionZ = 0;
			}
			OutOfRange = false;
		}

		public RelativePosition(byte waypoint, short x, short y, short z, bool outOfRange)
		{
			WaypointId = waypoint;
			PositionX = x;
			PositionY = y;
			PositionZ = z;
			OutOfRange = outOfRange;
		}

		public void Write(NetworkWriter writer)
		{
			writer.WriteByte(WaypointId);
			if (WaypointId > 0)
			{
				writer.WriteShort(PositionX);
				writer.WriteShort(PositionY);
				writer.WriteShort(PositionZ);
			}
		}

		private static bool TryCompressPosition(float pos, out short compressed)
		{
			float num = pos * 256f;
			if (num < -32768f)
			{
				compressed = short.MinValue;
				return false;
			}
			if (num > 32767f)
			{
				compressed = short.MaxValue;
				return false;
			}
			compressed = (short)num;
			return true;
		}

		public bool Equals(RelativePosition other)
		{
			if (PositionX == other.PositionX && PositionY == other.PositionY && PositionZ == other.PositionZ)
			{
				return WaypointId == other.WaypointId;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is RelativePosition relativePosition)
			{
				return relativePosition.Equals(this);
			}
			return false;
		}

		public static bool operator ==(RelativePosition left, RelativePosition right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(RelativePosition left, RelativePosition right)
		{
			return !left.Equals(right);
		}

		public override int GetHashCode()
		{
			return (((((WaypointId * 397) ^ PositionX) * 397) ^ PositionZ) * 397) ^ PositionY;
		}
	}
}

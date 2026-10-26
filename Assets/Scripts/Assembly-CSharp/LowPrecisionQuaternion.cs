using System;
using UnityEngine;

public readonly struct LowPrecisionQuaternion : IEquatable<LowPrecisionQuaternion>
{
	private const sbyte Range = sbyte.MaxValue;

	private readonly sbyte _x;

	private readonly sbyte _y;

	private readonly sbyte _z;

	private readonly sbyte _w;

	public Quaternion Value => new Quaternion((float)_x / 127f, (float)_y / 127f, (float)_z / 127f, (float)_w / 127f).normalized;

	public LowPrecisionQuaternion(Quaternion value)
	{
		_x = (sbyte)(value.x * 127f);
		_y = (sbyte)(value.y * 127f);
		_z = (sbyte)(value.z * 127f);
		_w = (sbyte)(value.w * 127f);
	}

	public override int GetHashCode()
	{
		return _x | (_y << 8) | (_z << 16) | (_w << 24);
	}

	public static bool operator ==(LowPrecisionQuaternion left, LowPrecisionQuaternion right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(LowPrecisionQuaternion left, LowPrecisionQuaternion right)
	{
		return !left.Equals(right);
	}

	public bool Equals(LowPrecisionQuaternion other)
	{
		if (_x == other._x && _y == other._y && _z == other._z)
		{
			return _w == other._w;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is LowPrecisionQuaternion other)
		{
			return Equals(other);
		}
		return false;
	}
}

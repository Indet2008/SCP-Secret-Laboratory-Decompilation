using System;
using UnityEngine;

[Serializable]
public struct Offset : IEquatable<Offset>
{
	public Vector3 position;

	public Vector3 rotation;

	public Vector3 scale;

	public bool Equals(Offset other)
	{
		if (position == other.position && rotation == other.rotation)
		{
			return scale == other.scale;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is Offset other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((position.GetHashCode() * 397) ^ rotation.GetHashCode()) * 397) ^ scale.GetHashCode();
	}

	public Offset(Transform t, bool local)
	{
		position = (local ? t.localPosition : t.position);
		rotation = (local ? t.localEulerAngles : t.eulerAngles);
		scale = t.localScale;
	}

	public static bool operator ==(Offset left, Offset right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(Offset left, Offset right)
	{
		return !left.Equals(right);
	}
}

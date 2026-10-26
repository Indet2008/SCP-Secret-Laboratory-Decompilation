using UnityEngine;

namespace ProgressiveCulling
{
	public interface IBoundsCullable : ICullable
	{
		Bounds WorldspaceBounds { get; }
	}
}

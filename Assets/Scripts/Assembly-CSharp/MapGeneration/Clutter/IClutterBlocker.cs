using System.Collections.Generic;
using UnityEngine;

namespace MapGeneration.Clutter
{
	public interface IClutterBlocker
	{
		static readonly List<IClutterBlocker> Instances;

		Bounds BlockingBounds { get; }

		static IClutterBlocker()
		{
			Instances = new List<IClutterBlocker>();
		}
	}
}

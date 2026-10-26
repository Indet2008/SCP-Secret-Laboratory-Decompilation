using System;
using UnityEngine;

namespace MapGeneration
{
	public abstract class ZoneGenerator : MonoBehaviour
	{
		public FacilityZone TargetZone;

		public abstract void Generate(System.Random rng);
	}
}

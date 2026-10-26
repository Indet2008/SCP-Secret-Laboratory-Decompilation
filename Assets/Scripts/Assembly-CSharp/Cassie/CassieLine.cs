using System;
using UnityEngine;

namespace Cassie
{
	[Serializable]
	public class CassieLine
	{
		public string ApiName;

		public AudioClip Clip;

		public float Duration;

		public CassieClipCategory Type;
	}
}

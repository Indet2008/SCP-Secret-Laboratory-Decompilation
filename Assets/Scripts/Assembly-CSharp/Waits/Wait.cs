using System.Collections.Generic;
using UnityEngine;

namespace Waits
{
	public abstract class Wait : MonoBehaviour
	{
		public abstract IEnumerator<float> _Run();
	}
}

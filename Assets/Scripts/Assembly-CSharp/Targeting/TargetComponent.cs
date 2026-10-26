using UnityEngine;

namespace Targeting
{
	public abstract class TargetComponent : MonoBehaviour
	{
		public abstract bool IsTarget { get; set; }
	}
}

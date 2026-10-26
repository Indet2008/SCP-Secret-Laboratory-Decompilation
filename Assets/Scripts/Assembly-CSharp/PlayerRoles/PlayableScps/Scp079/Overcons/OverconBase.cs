using System.Collections.Generic;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public abstract class OverconBase : MonoBehaviour
	{
		public static readonly HashSet<OverconBase> ActiveInstances = new HashSet<OverconBase>();

		public virtual bool IsHighlighted { get; internal set; }

		protected virtual void OnEnable()
		{
			ActiveInstances.Add(this);
		}

		protected virtual void OnDisable()
		{
			ActiveInstances.Remove(this);
		}
	}
}

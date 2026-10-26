using System;
using UnityEngine.Events;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	[AttributeUsage(AttributeTargets.Method)]
	public class ExposedFirearmEventAttribute : Attribute
	{
		public readonly UnityEventCallState CallState;

		public ExposedFirearmEventAttribute()
			: this(UnityEventCallState.RuntimeOnly)
		{
		}

		public ExposedFirearmEventAttribute(UnityEventCallState callState)
		{
			CallState = callState;
		}
	}
}

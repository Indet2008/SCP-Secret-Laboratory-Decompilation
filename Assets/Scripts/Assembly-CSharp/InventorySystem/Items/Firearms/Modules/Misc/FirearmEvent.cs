using System;
using UnityEngine;
using UnityEngine.Events;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	[Serializable]
	public class FirearmEvent
	{
		public UnityEvent Action;

		public AnimationClip Clip;

		public float Frame;

		public int NameHash;

		public float LengthFrames;

		public static FirearmEvent CurrentlyInvokedEvent { get; private set; }

		public EventInvocationDetails LastInvocation { get; private set; }

		public void InvokeSafe(EventInvocationDetails data)
		{
			try
			{
				CurrentlyInvokedEvent = this;
				LastInvocation = data;
				Action.Invoke();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
			finally
			{
				CurrentlyInvokedEvent = null;
			}
		}
	}
}

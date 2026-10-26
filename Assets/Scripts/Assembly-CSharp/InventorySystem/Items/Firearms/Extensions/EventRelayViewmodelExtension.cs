using System;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;
using UnityEngine.Events;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class EventRelayViewmodelExtension : MonoBehaviour, IViewmodelExtension
	{
		[Serializable]
		private class Relay
		{
			public int GUID;

			public UnityEvent Action;
		}

		[SerializeField]
		private Relay[] _relays;

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			viewmodel.ParentFirearm.TryGetModule<EventManagerModule>(out var module);
			module.OnEventRelayed += OnTriggered;
		}

		private void OnTriggered(int guid)
		{
			Relay[] relays = _relays;
			foreach (Relay relay in relays)
			{
				if (relay.GUID == guid)
				{
					relay.Action.Invoke();
				}
			}
		}
	}
}

using System;
using NetworkManagerUtils.Dummies;
using UnityEngine;
using UnityEngine.Events;

namespace InventorySystem.Items
{
	public class ItemSerializedDummyAction : MonoBehaviour, IDummyActionProvider
	{
		[Serializable]
		private struct DefinedAction
		{
			public string Name;

			public bool AllowWhileHolstered;

			public UnityEvent Action;
		}

		private ItemBase _parentItem;

		[SerializeField]
		private DefinedAction[] _actions;

		public bool DummyActionsDirty => false;

		public void PopulateDummyActions(Action<DummyAction> actionAdder)
		{
			if (_parentItem == null)
			{
				_parentItem = GetComponentInParent<ItemBase>();
			}
			DefinedAction[] actions = _actions;
			for (int i = 0; i < actions.Length; i++)
			{
				DefinedAction definedAction = actions[i];
				if (definedAction.AllowWhileHolstered || _parentItem.IsEquipped)
				{
					actionAdder(new DummyAction(definedAction.Name, definedAction.Action.Invoke));
				}
			}
		}
	}
}

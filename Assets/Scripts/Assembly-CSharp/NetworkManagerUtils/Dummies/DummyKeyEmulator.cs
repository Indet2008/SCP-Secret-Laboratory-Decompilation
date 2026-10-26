using System;
using System.Collections.Generic;

namespace NetworkManagerUtils.Dummies
{
	public class DummyKeyEmulator : IDummyActionProvider
	{
		private readonly struct EmulatedEntry
		{
			public readonly ActionName Action;

			public readonly bool OnlyOneClick;

			public EmulatedEntry(ActionName action, bool click)
			{
				Action = action;
				OnlyOneClick = click;
			}
		}

		private readonly IRootDummyActionProvider _root;

		private readonly List<ActionName> _registeredListeners = new List<ActionName>();

		private readonly List<ActionName> _firstFrameActions = new List<ActionName>();

		private readonly List<EmulatedEntry> _activeEntries = new List<EmulatedEntry>();

		private readonly List<EmulatedEntry> _scheduledEntries = new List<EmulatedEntry>();

		public bool AnyListeners => _registeredListeners.Count > 0;

		public DummyKeyEmulator(IRootDummyActionProvider inventory)
		{
			_root = inventory;
		}

		public bool GetAction(ActionName action, bool firstFrameOnly)
		{
			if (!_registeredListeners.Contains(action))
			{
				_root.DummyActionsDirty = true;
				_registeredListeners.Add(action);
			}
			if (IsHeld(action))
			{
				if (firstFrameOnly)
				{
					return _firstFrameActions.Contains(action);
				}
				return true;
			}
			return false;
		}

		public void PopulateDummyActions(Action<DummyAction> actionAdder)
		{
			foreach (ActionName action in _registeredListeners)
			{
				actionAdder(new DummyAction($"{action}->Click", () =>
				{
					AddEntry(action, isClick: true);
				}));
				if (IsHeld(action))
				{
					actionAdder(new DummyAction($"{action}->Release", () =>
					{
						RemoveEntry(action);
					}));
				}
				else
				{
					actionAdder(new DummyAction($"{action}->Hold", () =>
					{
						AddEntry(action, isClick: false);
					}));
				}
			}
		}

		public void LateUpdate()
		{
			_firstFrameActions.Clear();
			for (int num = _activeEntries.Count - 1; num >= 0; num--)
			{
				if (_activeEntries[num].OnlyOneClick)
				{
					_activeEntries.RemoveAt(num);
					_root.DummyActionsDirty = true;
				}
			}
			foreach (EmulatedEntry scheduledEntry in _scheduledEntries)
			{
				_firstFrameActions.Add(scheduledEntry.Action);
				_activeEntries.Add(scheduledEntry);
				_root.DummyActionsDirty = true;
			}
			_scheduledEntries.Clear();
		}

		private void RemoveEntry(List<EmulatedEntry> list, ActionName action)
		{
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i].Action == action)
				{
					list.RemoveAt(i);
					_root.DummyActionsDirty = true;
					break;
				}
			}
		}

		private void RemoveEntry(ActionName action)
		{
			RemoveEntry(_activeEntries, action);
			RemoveEntry(_scheduledEntries, action);
		}

		private bool IsHeld(ActionName action)
		{
			foreach (EmulatedEntry activeEntry in _activeEntries)
			{
				if (activeEntry.Action == action)
				{
					return true;
				}
			}
			return false;
		}

		private void AddEntry(ActionName action, bool isClick)
		{
			RemoveEntry(action);
			_scheduledEntries.Add(new EmulatedEntry(action, isClick));
		}
	}
}

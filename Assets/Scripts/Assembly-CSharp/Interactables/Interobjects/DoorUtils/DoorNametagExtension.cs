using System.Collections.Generic;
using UnityEngine;

namespace Interactables.Interobjects.DoorUtils
{
	public class DoorNametagExtension : DoorVariantExtension
	{
		public static readonly Dictionary<string, DoorNametagExtension> NamedDoors = new Dictionary<string, DoorNametagExtension>();

		[SerializeField]
		private string _nametag;

		private BreakableDoor _breakableDoor;

		private bool _previousState;

		private bool _breakable;

		private bool _previousBreak;

		private ushort _previousLocks;

		public string GetName => _nametag;

		private void Start()
		{
			UpdateName(_nametag);
			if (TryGetComponent<DoorVariant>(out var component))
			{
				component.DoorName = _nametag;
			}
			_breakable = TryGetComponent<BreakableDoor>(out _breakableDoor);
		}

		private void FixedUpdate()
		{
			if (TargetDoor.TargetState != _previousState || TargetDoor.ActiveLocks != _previousLocks || (_breakable && _breakableDoor.IsDestroyed != _previousBreak))
			{
				_previousState = TargetDoor.TargetState;
				_previousLocks = TargetDoor.ActiveLocks;
				if (_breakable)
				{
					_previousBreak = _breakableDoor.IsDestroyed;
				}
			}
		}

		public void UpdateName(string newName)
		{
			if (string.IsNullOrEmpty(newName))
			{
				Debug.LogError("Nametag of " + base.transform.parent.name + "/" + base.name + " has not been set", base.gameObject);
			}
			else
			{
				_nametag = newName;
				NamedDoors[newName] = this;
			}
		}
	}
}

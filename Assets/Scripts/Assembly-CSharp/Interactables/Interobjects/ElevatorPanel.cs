using System.Collections.Generic;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class ElevatorPanel : InteractableCollider
	{
		public static readonly List<ElevatorPanel> AllPanels = new List<ElevatorPanel>();

		[SerializeField]
		private Material[] _levelMats;

		[SerializeField]
		private Material _movingUpMat;

		[SerializeField]
		private Material _movingDownMat;

		[SerializeField]
		private Material _disabledMat;

		[SerializeField]
		private Renderer _targetRenderer;

		[SerializeField]
		private ElevatorDoor _door;

		private bool _isInternal;

		private bool _chamberFound;

		public ElevatorChamber AssignedChamber { get; private set; }

		protected override void Awake()
		{
			AllPanels.Add(this);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			ElevatorDoor.OnLocksChanged -= RefreshPanelConditionally;
			AllPanels.Remove(this);
		}

		private void Update()
		{
			if (!_chamberFound)
			{
				if (_door == null)
				{
					FindChamberInternal();
				}
				else
				{
					FindChamberRegular();
				}
			}
		}

		private void FindChamberRegular()
		{
			if (ElevatorChamber.TryGetChamber(_door.Group, out var chamber))
			{
				ColliderId = GetHashFromHeight(base.transform.position.y);
				AssignChamber(chamber);
			}
		}

		private void FindChamberInternal()
		{
			if (!base.transform.TryGetComponentInParent<ElevatorChamber>(out var comp))
			{
				Debug.LogError("This panel has chamber assigned despite being an internal panel.", base.gameObject);
			}
			_isInternal = true;
			AssignChamber(comp);
		}

		private void AssignChamber(ElevatorChamber chamber)
		{
			if (_isInternal)
			{
				Target = chamber;
			}
			else
			{
				_door.Chamber = chamber;
				Target = _door;
			}
			AssignedChamber = chamber;
			_chamberFound = true;
			base.Awake();
			RefreshPanel();
			chamber.OnSequenceChanged += RefreshPanel;
			ElevatorDoor.OnLocksChanged += RefreshPanelConditionally;
		}

		private void RefreshPanelConditionally(ElevatorGroup group)
		{
			if (_chamberFound && AssignedChamber.AssignedGroup == group)
			{
				RefreshPanel();
			}
		}

		private void RefreshPanel()
		{
			ElevatorChamber.ElevatorSequence curSequence = AssignedChamber.CurSequence;
			if ((uint)(curSequence - 4) <= 1u)
			{
				RefreshStationary();
			}
			else
			{
				RefreshMoving();
			}
		}

		private void RefreshStationary()
		{
			bool flag = (_isInternal ? AssignedChamber.DestinationDoor : _door).ActiveLocks != 0;
			int destinationLevel = AssignedChamber.DestinationLevel;
			_targetRenderer.sharedMaterial = (flag ? _disabledMat : _levelMats[destinationLevel]);
		}

		private void RefreshMoving()
		{
			_targetRenderer.sharedMaterial = (AssignedChamber.GoingUp ? _movingUpMat : _movingDownMat);
		}

		private byte GetHashFromHeight(float y)
		{
			return (byte)(Mathf.RoundToInt(Mathf.Abs(y + 200f) * 0.3f) + 1);
		}
	}
}

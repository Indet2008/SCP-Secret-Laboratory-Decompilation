using InventorySystem.Items.Autosync;
using UnityEngine;

namespace InventorySystem.Items.FlamingoTapePlayer
{
	public class TapeAnims : MonoBehaviour
	{
		private static readonly int PlayHash = Animator.StringToHash("Play");

		private AnimatedViewmodelBase _viewmodel;

		private void Awake()
		{
			_viewmodel = GetComponent<AnimatedViewmodelBase>();
			TapeItem.OnPlayerTriggered += OnPlayerTriggered;
		}

		private void OnDestroy()
		{
			TapeItem.OnPlayerTriggered -= OnPlayerTriggered;
		}

		private void OnPlayerTriggered(ushort serial, bool success)
		{
			if (_viewmodel.ItemId.SerialNumber == serial)
			{
				_viewmodel.AnimatorSetTrigger(PlayHash);
			}
		}
	}
}

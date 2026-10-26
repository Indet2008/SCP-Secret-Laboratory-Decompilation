using AudioPooling;
using InventorySystem.Items.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.ToggleableLights.Flashlight
{
	public class FlashlightThirdpersonItem : IdleThirdpersonItem
	{
		public const float MaxAudioDistance = 3.2f;

		[SerializeField]
		private Light _lightSource;

		[SerializeField]
		private Renderer[] _targetRenderers;

		[SerializeField]
		private Material _onMat;

		[SerializeField]
		private Material _offMat;

		private static FlashlightItem Template => FlashlightItem.Template;

		internal override void Initialize(InventorySubcontroller subctrl, ItemIdentifier id)
		{
			base.Initialize(subctrl, id);
			FlashlightNetworkHandler.OnStatusReceived += ProcesReceivedStatus;
			if (FlashlightNetworkHandler.ReceivedStatuses.TryGetValue(id.SerialNumber, out var value))
			{
				SetState(value);
			}
		}

		private void OnDestroy()
		{
			FlashlightNetworkHandler.OnStatusReceived -= ProcesReceivedStatus;
		}

		private void ProcesReceivedStatus(FlashlightNetworkHandler.FlashlightMessage msg)
		{
			if (msg.Serial == base.ItemId.SerialNumber)
			{
				SetState(msg.NewState);
			}
		}

		private void SetState(bool newState)
		{
			if (_lightSource.enabled != newState)
			{
				_lightSource.enabled = newState;
				Renderer[] targetRenderers = _targetRenderers;
				for (int i = 0; i < targetRenderers.Length; i++)
				{
					targetRenderers[i].sharedMaterial = (newState ? _onMat : _offMat);
				}
				AudioSourcePoolManager.PlayOnTransform(newState ? Template.OnClip : Template.OffClip, base.transform, 3.2f);
			}
		}
	}
}

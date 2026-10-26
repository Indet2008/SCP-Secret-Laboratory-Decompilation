using System.Collections.Generic;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules.Misc;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class GripControllerModule : ModuleBase
	{
		private static readonly HashSet<ushort> SyncEnabledGrips = new HashSet<ushort>();

		[SerializeField]
		private AttachmentLink _gripAttachmentLink;

		[SerializeField]
		private AnimatorLayerMask _layers;

		private float _lastWeight;

		private float _adjustSpeed;

		private int? _activeSafeguard;

		private FirearmEvent _safeguardEvent;

		private float _safeguardDuration;

		private bool SkippingForward
		{
			get
			{
				if (base.Firearm.TryGetModule<EventManagerModule>(out var module))
				{
					return module.SkippingForward;
				}
				return false;
			}
		}

		[ExposedFirearmEvent]
		public void EnableGripLayer(float transitionDurationFrames)
		{
			_activeSafeguard = null;
			ModifyGripSpeed(transitionDurationFrames, targetEnable: true);
			_safeguardEvent = null;
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteBool(value: true);
				});
			}
		}

		[ExposedFirearmEvent]
		public void DisableGripLayer(float transitionDurationFrames)
		{
			ModifyGripSpeed(transitionDurationFrames, targetEnable: false);
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteBool(value: false);
				});
			}
		}

		[ExposedFirearmEvent]
		public void SetSafeguards(float transitionDurationFrames)
		{
			_safeguardEvent = FirearmEvent.CurrentlyInvokedEvent;
			_activeSafeguard = _safeguardEvent?.NameHash;
			_safeguardDuration = transitionDurationFrames;
		}

		internal override void SpectatorPostprocessSkip()
		{
			base.SpectatorPostprocessSkip();
			bool flag = SyncEnabledGrips.Contains(base.ItemSerial);
			ForceWeight(flag ? 1 : 0);
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.HasViewmodel)
			{
				UpdateSafeguard();
				UpdateWeight();
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			_gripAttachmentLink.InitCache(base.Firearm);
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			_lastWeight = 0f;
			_adjustSpeed = 0f;
			_activeSafeguard = null;
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteBool(value: false);
				});
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SyncEnabledGrips.Clear();
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstModule)
		{
			base.ServerOnPlayerConnected(hub, firstModule);
			if (!firstModule)
			{
				return;
			}
			foreach (ushort serial in SyncEnabledGrips)
			{
				SendRpc(hub, (NetworkWriter x) =>
				{
					x.WriteUShort(serial);
				});
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			byte b = 2;
			while (reader.Remaining >= b)
			{
				SyncEnabledGrips.Add(reader.ReadUShort());
			}
			if (reader.Remaining > 0)
			{
				if (reader.ReadBool())
				{
					SyncEnabledGrips.Add(serial);
				}
				else
				{
					SyncEnabledGrips.Remove(serial);
				}
			}
		}

		private void ModifyGripSpeed(float transitionDurationFrames, bool targetEnable)
		{
			FirearmEvent firearmEvent = FirearmEvent.CurrentlyInvokedEvent;
			if (firearmEvent == null)
			{
				if (!targetEnable || _safeguardEvent == null)
				{
					return;
				}
				firearmEvent = _safeguardEvent;
			}
			float totalSpeedMultiplier = firearmEvent.LastInvocation.TotalSpeedMultiplier;
			float num = transitionDurationFrames / firearmEvent.Clip.frameRate;
			if (totalSpeedMultiplier <= 0f || num <= 0f || SkippingForward)
			{
				ForceWeight(targetEnable ? 1 : 0);
				return;
			}
			_adjustSpeed = 1f / num;
			if (!targetEnable)
			{
				_adjustSpeed *= -1f;
			}
		}

		private void ForceWeight(float weight)
		{
			_adjustSpeed = 0f;
			_lastWeight = weight;
			UpdateWeight();
		}

		private void UpdateWeight()
		{
			_lastWeight = Mathf.Clamp01(_lastWeight + _adjustSpeed * Time.deltaTime);
			if (base.Firearm.HasViewmodel)
			{
				float num = (_gripAttachmentLink.Instance.IsEnabled ? _lastWeight : 0f);
				AnimatedFirearmViewmodel clientViewmodelInstance = base.Firearm.ClientViewmodelInstance;
				_layers.SetWeight(clientViewmodelInstance.AnimatorSetLayerWeight, num);
				base.Firearm.AnimSetFloat(FirearmAnimatorHashes.GripWeight, num, checkIfExists: true);
			}
		}

		private void UpdateSafeguard()
		{
			if (!_activeSafeguard.HasValue || !base.Firearm.TryGetModule<EventManagerModule>(out var module))
			{
				return;
			}
			AnimatedFirearmViewmodel clientViewmodelInstance = base.Firearm.ClientViewmodelInstance;
			int value = _activeSafeguard.Value;
			int[] layers = module.AffectedLayers.Layers;
			foreach (int layer in layers)
			{
				if (clientViewmodelInstance.AnimatorStateInfo(layer).shortNameHash == value)
				{
					return;
				}
			}
			EnableGripLayer(_safeguardDuration);
		}
	}
}

using System;
using InventorySystem.Items.Firearms.Modules.Misc;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class DisruptorModeSelector : ModuleBase, IRecoilScalingModule
	{
		private const float SwitchCooldown = 0.4f;

		private readonly TolerantAbilityCooldown _switchCooldown = new TolerantAbilityCooldown();

		private AudioModule _audioModule;

		[SerializeField]
		private AudioClip _singleClip;

		[SerializeField]
		private AudioClip _rapidClip;

		[SerializeField]
		private float _singleRecoilScale;

		public bool SingleShotSelected { get; private set; }

		public float RecoilMultiplier
		{
			get
			{
				if (!SingleShotSelected)
				{
					return 1f;
				}
				return _singleRecoilScale;
			}
		}

		public event Action OnAnimationRequested;

		[ExposedFirearmEvent]
		public void RequestAnimation()
		{
			OnAnimationRequested?.Invoke();
			if (SingleShotSelected)
			{
				_audioModule.PlayClientside(_singleClip);
			}
			else
			{
				_audioModule.PlayClientside(_rapidClip);
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			base.Firearm.TryGetModule<AudioModule>(out _audioModule);
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsControllable && GetActionDown(ActionName.WeaponAlt) && !base.ItemUsageBlocked && _switchCooldown.IsReady && !base.Firearm.AnyModuleBusy())
			{
				SingleShotSelected = !SingleShotSelected;
				_switchCooldown.Trigger(0.4000000059604645);
				RequestAnimation();
				SendCmd((NetworkWriter x) =>
				{
					x.WriteBool(SingleShotSelected);
				});
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			bool newMode = reader.ReadBool();
			SendRpc((NetworkWriter x) =>
			{
				x.WriteBool(newMode);
			});
			PlayerEvents.OnToggledDisruptorFiringMode(new PlayerToggledDisruptorFiringModeEventArgs(base.Firearm.Owner, base.Firearm, newMode));
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			if (!base.IsLocalPlayer && _switchCooldown.TolerantIsReady)
			{
				SingleShotSelected = reader.ReadBool();
				_switchCooldown.Trigger(0.4000000059604645);
				RequestAnimation();
			}
		}
	}
}

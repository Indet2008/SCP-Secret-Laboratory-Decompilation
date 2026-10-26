using System.Collections.Generic;
using System.Diagnostics;
using InventorySystem.GUI;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Attachments.Components;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using UserSettings;
using UserSettings.ControlsSettings;

namespace InventorySystem.Items.Firearms.Modules
{
	public class LinearAdsModule : ModuleBase, IAdsModule, IDisplayableInaccuracyProviderModule, IInaccuracyProviderModule, IZoomModifyingItem, IInspectPreventerModule, IMovementSpeedModifier, IStaminaModifier, ISwayModifierModule
	{
		private class AdsData
		{
			private float _adjustSpeed;

			private float _lastOffset;

			private readonly Stopwatch _lastUpdate = Stopwatch.StartNew();

			public bool AdsTarget { get; private set; }

			public float AdsAmount
			{
				get
				{
					double num = _lastUpdate.Elapsed.TotalSeconds * (double)_adjustSpeed;
					double num2 = 1f - _lastOffset;
					float num3 = Mathf.Clamp01((float)(num + num2));
					if (!AdsTarget)
					{
						return 1f - num3;
					}
					return num3;
				}
			}

			public void Update(bool target, float speed, out bool targetChanged, out bool speedChanged)
			{
				speedChanged = speed != _adjustSpeed;
				targetChanged = AdsTarget != target;
				if (speedChanged)
				{
					_adjustSpeed = speed;
				}
				if (targetChanged)
				{
					_lastOffset = AdsAmount;
					_lastUpdate.Restart();
					AdsTarget = target;
					if (AdsTarget)
					{
						_lastOffset = 1f - _lastOffset;
					}
				}
			}

			public void DecodeData(NetworkReader reader)
			{
				float num = reader.ReadFloat();
				bool target = num > 0f;
				float speed = Mathf.Abs(num);
				Update(target, speed, out var _, out var _);
			}

			public void Reset()
			{
				AdsTarget = false;
				_lastOffset = 0f;
			}
		}

		private const float FallbackAdsZoom = 1.15f;

		private const float FallbackAdsInaccuracy = 0.17f;

		private const float FallbackHipInaccuracy = 2f;

		private const float FallbackTimeToTransition = 0.2f;

		private const float TransitioningPenaltyDegrees = 3f;

		private const float AdsJumpSwayMultiplier = 0.3f;

		protected static readonly Remap MovementLimitRemap = new Remap(7f, 45f, 6f, 1.7f);

		private static readonly Dictionary<FirearmCategory, float> HipInaccuracyByCategory = new Dictionary<FirearmCategory, float>
		{
			[FirearmCategory.Pistol] = 1.7f,
			[FirearmCategory.Revolver] = 1.1f,
			[FirearmCategory.SubmachineGun] = 1.7f,
			[FirearmCategory.Rifle] = 1.77f,
			[FirearmCategory.LightMachineGun] = 2.2f,
			[FirearmCategory.Shotgun] = 1.2f
		};

		private static readonly Dictionary<FirearmCategory, float> AdsInaccuracyByCategory = new Dictionary<FirearmCategory, float>
		{
			[FirearmCategory.Pistol] = 0.25f,
			[FirearmCategory.Revolver] = 0.11f,
			[FirearmCategory.SubmachineGun] = 0.17f,
			[FirearmCategory.Rifle] = 0.07f,
			[FirearmCategory.LightMachineGun] = 0.13f,
			[FirearmCategory.Shotgun] = 0.2f
		};

		private static readonly Dictionary<FirearmCategory, float> TimeToTransitionByCategory = new Dictionary<FirearmCategory, float>
		{
			[FirearmCategory.Rifle] = 0.25f,
			[FirearmCategory.SubmachineGun] = 0.28f,
			[FirearmCategory.Shotgun] = 0.18f
		};

		private static readonly ToggleOrHoldInput AdsInput = new ToggleOrHoldInput(ActionName.Zoom, new CachedUserSetting<bool>(MiscControlsSetting.AdsToggle));

		private static readonly Dictionary<ushort, AdsData> SyncData = new Dictionary<ushort, AdsData>();

		private bool _userInput;

		private bool _hasZoomOptions;

		private readonly AdsData _clientData = new AdsData();

		private float EffectiveHipInaccuracy => BaseHipInaccuracy * base.Firearm.AttachmentsValue(AttachmentParam.HipInaccuracyMultiplier);

		private float EffectiveAdsInaccuracy => BaseAdsInaccuracy * base.Firearm.AttachmentsValue(AttachmentParam.AdsInaccuracyMultiplier);

		protected virtual bool AllowAds
		{
			get
			{
				ModuleBase[] modules = base.Firearm.Modules;
				foreach (ModuleBase moduleBase in modules)
				{
					if (moduleBase is IEquipperModule { IsEquipped: false })
					{
						return false;
					}
					if (moduleBase is IReloaderModule { IsReloadingOrUnloading: not false })
					{
						return false;
					}
					if (moduleBase is IAdsPreventerModule { AdsAllowed: false })
					{
						return false;
					}
				}
				return true;
			}
		}

		protected virtual bool ForceAdsInput => false;

		public DisplayInaccuracyValues DisplayInaccuracy => new DisplayInaccuracyValues(EffectiveHipInaccuracy, EffectiveAdsInaccuracy, EffectiveHipInaccuracy);

		public bool AdsTarget
		{
			get
			{
				if (!base.IsLocalPlayer)
				{
					return GetAdsTargetForSerial(base.ItemSerial);
				}
				return _clientData.AdsTarget;
			}
		}

		public float AdsAmount
		{
			get
			{
				if (!base.IsLocalPlayer)
				{
					return GetAdsAmountForSerial(base.Firearm.ItemSerial);
				}
				return _clientData.AdsAmount;
			}
		}

		public float Inaccuracy
		{
			get
			{
				float num = Mathf.Lerp(EffectiveHipInaccuracy, EffectiveAdsInaccuracy, AdsAmount);
				float num2 = Mathf.Abs(AdsAmount - 0.5f) * 2f;
				float num3 = num2 * num2 * num2 * num2;
				float num4 = 1f - num3;
				return num + num4 * 3f;
			}
		}

		public bool InspectionAllowed => AdsAmount == 0f;

		public virtual float BaseHipInaccuracy
		{
			get
			{
				if (!HipInaccuracyByCategory.TryGetValue(base.Firearm.FirearmCategory, out var value))
				{
					return 2f;
				}
				return value;
			}
		}

		public virtual float BaseAdsInaccuracy
		{
			get
			{
				if (!AdsInaccuracyByCategory.TryGetValue(base.Firearm.FirearmCategory, out var value))
				{
					return 0.17f;
				}
				return value;
			}
		}

		public virtual float BaseTimeToTransition
		{
			get
			{
				if (!TimeToTransitionByCategory.TryGetValue(base.Firearm.FirearmCategory, out var value))
				{
					return 0.2f;
				}
				return value;
			}
		}

		public virtual float BaseZoomAmount
		{
			get
			{
				if (!_hasZoomOptions)
				{
					return 1.15f;
				}
				return 1f;
			}
		}

		public virtual float ZoomAmount
		{
			get
			{
				float num = base.Firearm.AttachmentsValue(AttachmentParam.AdsZoomMultiplier);
				return (BaseZoomAmount * num - 1f) * Mathf.SmoothStep(0f, 1f, AdsAmount) + 1f;
			}
		}

		public virtual float AdditionalSensitivityModifier => base.Firearm.AttachmentsValue(AttachmentParam.AdsMouseSensitivityMultiplier);

		public virtual float SensitivityScale
		{
			get
			{
				float num = base.Firearm.AttachmentsValue(AttachmentParam.AdsZoomMultiplier);
				float num2 = BaseZoomAmount * num * AdditionalSensitivityModifier;
				float adsReductionMultiplier = SensitivitySettings.AdsReductionMultiplier;
				float num3 = AdsAmount;
				if (adsReductionMultiplier < 1f)
				{
					num3 *= adsReductionMultiplier;
				}
				else
				{
					num2 *= adsReductionMultiplier;
				}
				return 1f / Mathf.Lerp(1f, num2, num3);
			}
		}

		public bool IsTransitioning
		{
			get
			{
				if (AdsAmount > 0f)
				{
					return AdsAmount < 1f;
				}
				return false;
			}
		}

		public bool MovementModifierActive
		{
			get
			{
				if (base.IsLocalPlayer)
				{
					return AdsAmount > 0f;
				}
				return false;
			}
		}

		public float MovementSpeedMultiplier => 1f;

		public virtual float MovementSpeedLimit => MovementLimitRemap.Get(AdsAmount * base.Firearm.Length);

		public bool StaminaModifierActive => MovementModifierActive;

		public bool SprintingDisabled
		{
			get
			{
				if (base.Firearm.Owner.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					return MovementSpeedLimit <= fpcRole.FpcModule.VelocityForState(PlayerMovementState.Walking, applyCrouch: false);
				}
				return false;
			}
		}

		public float WalkSwayScale => 1f - AdsAmount;

		public float JumpSwayScale => Mathf.Lerp(1f, 0.3f, AdsAmount);

		protected virtual void OnAdsChanged(bool newTarget, float newSpeed, bool targetChanged, bool speedChanged)
		{
			if (!targetChanged && !speedChanged)
			{
				return;
			}
			if (base.IsLocalPlayer)
			{
				SendCmd((NetworkWriter x) =>
				{
					x.WriteBool(_userInput);
				});
			}
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteFloat(newTarget ? newSpeed : (0f - newSpeed));
				});
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SyncData.Clear();
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (!base.Firearm.HasOwner)
			{
				return;
			}
			AdsData adsData;
			if (base.IsControllable)
			{
				adsData = _clientData;
				if (base.Item.IsDummy)
				{
					_userInput = GetAction(ActionName.Zoom);
				}
				else if (InventoryGuiController.ItemsSafeForInteraction)
				{
					_userInput = AdsInput.IsActive;
				}
			}
			else
			{
				if (!base.IsServer)
				{
					return;
				}
				adsData = SyncData.GetOrAdd(base.ItemSerial, () => new AdsData());
			}
			bool flag = (_userInput || ForceAdsInput) && AllowAds;
			float num = base.Firearm.AttachmentsValue(AttachmentParam.AdsSpeedMultiplier) / BaseTimeToTransition;
			adsData.Update(flag, num, out var targetChanged, out var speedChanged);
			OnAdsChanged(flag, num, targetChanged, speedChanged);
		}

		protected override void OnInit()
		{
			base.OnInit();
			Attachment[] attachments = base.Firearm.Attachments;
			for (int i = 0; i < attachments.Length; i++)
			{
				if (attachments[i].TryGetActiveValue(AttachmentParam.AdsZoomMultiplier, out var _))
				{
					_hasZoomOptions = true;
					break;
				}
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			if (base.IsLocalPlayer)
			{
				_clientData.Reset();
				AdsInput.ResetToggle();
			}
			if (base.IsServer && AdsTarget)
			{
				SendRpc();
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			_userInput = reader.ReadBool();
			PlayerEvents.OnAimedWeapon(new PlayerAimedWeaponEventArgs(base.Firearm.Owner, base.Firearm, _userInput));
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			if (reader.Remaining == 0)
			{
				if (SyncData.TryGetValue(serial, out var value))
				{
					value.Reset();
				}
			}
			else
			{
				SyncData.GetOrAdd(serial, () => new AdsData()).DecodeData(reader);
			}
		}

		public void GetDisplayAdsValues(ushort serial, out bool adsTarget, out float adsAmount)
		{
			if (SyncData.TryGetValue(serial, out var value))
			{
				adsTarget = value.AdsTarget;
				adsAmount = value.AdsAmount;
			}
			else
			{
				adsTarget = false;
				adsAmount = 0f;
			}
		}

		public static bool GetAdsTargetForSerial(ushort serial)
		{
			if (SyncData.TryGetValue(serial, out var value))
			{
				return value.AdsTarget;
			}
			return false;
		}

		public static float GetAdsAmountForSerial(ushort serial)
		{
			if (!SyncData.TryGetValue(serial, out var value))
			{
				return 0f;
			}
			return value.AdsAmount;
		}
	}
}

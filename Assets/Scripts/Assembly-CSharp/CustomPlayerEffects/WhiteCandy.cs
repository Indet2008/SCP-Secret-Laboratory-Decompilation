using System;
using System.Collections.Generic;
using AudioPooling;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Armor;
using MapGeneration;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables;
using PlayerRoles.PlayableScps.Scp106;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace CustomPlayerEffects
{
	public class WhiteCandy : StatusEffectBase, IFpcCollisionModifier, IInteractionBlocker, IHolidayEffect
	{
		private const float InsideThreshold = 0.7f;

		private const float OutsideThreshold = 0f;

		private const float RateLimitCooldown = 1.2f;

		private const float LightFlickerDuration = 0.02f;

		[SerializeField]
		private AudioClip _walkThroughClip;

		[SerializeField]
		private AudioSource _loopSound;

		[SerializeField]
		private Material _ghostMaterial;

		private readonly AbilityCooldown _rateLimit = new AbilityCooldown();

		private ModelVisualEffect _modelEffect;

		private bool _inDoor;

		private static int? _whiteCandyEffectIndex;

		private static bool _whiteCandyEffectIndexCacheSet;

		public LayerMask DetectionMask => Scp106MovementModule.PassableDetectionMask;

		public override EffectClassification Classification => EffectClassification.Positive;

		public BlockedInteraction BlockedInteractions => BlockedInteraction.GrabItems;

		public bool CanBeCleared => !base.IsEnabled;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		public void ProcessColliders(ArraySegment<Collider> detections)
		{
			float num = 0f;
			foreach (Collider item in detections)
			{
				float slowdownFromCollider = Scp106MovementModule.GetSlowdownFromCollider(item, out var isPassable);
				if (isPassable)
				{
					num = Mathf.Max(num, slowdownFromCollider);
					item.enabled = slowdownFromCollider == 0f;
				}
			}
			if (!NetworkServer.active)
			{
				return;
			}
			if (_inDoor)
			{
				_inDoor = num > 0f;
			}
			else if (!(num < 0.7f))
			{
				_inDoor = true;
				if (_rateLimit.IsReady)
				{
					_rateLimit.Trigger(1.2000000476837158);
					NetworkServer.SendToReady(new GhostlyWalkThroughMessage
					{
						Position = base.Hub.transform.position
					});
				}
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (_loopSound.isPlaying)
			{
				_loopSound.Stop();
			}
			_loopSound.mute = true;
			_loopSound.Play();
			_loopSound.volume = 1f;
			if (NetworkServer.active)
			{
				base.Hub.playerEffectsController.DisableEffect<OrangeCandy>();
				base.Hub.playerEffectsController.DisableEffect<Metal>();
				base.Hub.DisableWearables(WearableElements.Armor);
			}
			if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				FlickerLights(fpcRole.FpcModule.Position);
				FpcCollisionProcessor.AddModifier(this, fpcRole);
				base.Hub.interCoordinator.AddBlocker(this);
				_modelEffect = new ModelVisualEffect(fpcRole.FpcModule.CharacterModelInstance, _ghostMaterial);
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			ReEnableArmor();
			if (NetworkServer.active)
			{
				base.Hub.playerEffectsController.ChangeState<TemporaryBypass>(2, 3f);
			}
			FpcCollisionProcessor.RemoveModifier(this);
			_modelEffect?.Restore();
		}

		private void ReEnableArmor()
		{
			if (NetworkServer.active && base.Hub.inventory.UserInventory.Items.Any((KeyValuePair<ushort, ItemBase> x) => x.Value is BodyArmor))
			{
				base.Hub.EnableWearables(WearableElements.Armor);
			}
		}

		protected override void Update()
		{
			base.Update();
			if (!_loopSound.isPlaying)
			{
				return;
			}
			if (!base.IsEnabled)
			{
				_loopSound.volume -= Time.deltaTime / 2f;
				if (_loopSound.volume <= 0f)
				{
					_loopSound.Stop();
				}
			}
			_loopSound.mute = !base.IsLocalPlayer && !base.IsSpectated;
		}

		private static void FlickerLights(Vector3 pos)
		{
			if (!NetworkServer.active || !pos.TryGetRoom(out var room))
			{
				return;
			}
			foreach (RoomLightController lightController in room.LightControllers)
			{
				if (lightController.LightsEnabled)
				{
					lightController.ServerFlickerLights(0.02f);
				}
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnCurrentItemChanged += (ReferenceHub hub, ItemIdentifier _, ItemIdentifier newItem) =>
			{
				if (NetworkServer.active && TryGetEffectFast(hub, out var fx) && fx.IsEnabled)
				{
					hub.inventory.ServerDropItem(newItem.SerialNumber);
				}
			};
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler((GhostlyWalkThroughMessage msg) =>
				{
					if (ReferenceHub.TryGetLocalHub(out var hub) && TryGetEffectFast(hub, out var fx))
					{
						AudioSourcePoolManager.PlayAtPosition(fx._walkThroughClip, msg.Position, 8f);
					}
				});
			};
		}

		private static bool TryGetEffectFast(ReferenceHub hub, out WhiteCandy fx)
		{
			StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
			if (_whiteCandyEffectIndexCacheSet)
			{
				if (!_whiteCandyEffectIndex.HasValue)
				{
					fx = null;
					return false;
				}
				fx = allEffects[_whiteCandyEffectIndex.Value] as WhiteCandy;
				return true;
			}
			_whiteCandyEffectIndexCacheSet = true;
			for (int i = 0; i < allEffects.Length; i++)
			{
				if (allEffects[i] is WhiteCandy whiteCandy)
				{
					_whiteCandyEffectIndex = i;
					fx = whiteCandy;
					return true;
				}
			}
			fx = null;
			return false;
		}
	}
}

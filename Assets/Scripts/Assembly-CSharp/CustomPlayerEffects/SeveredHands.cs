using System.Collections.Generic;
using AudioPooling;
using Footprinting;
using InventorySystem;
using InventorySystem.Items;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SeveredHands : TickingEffectBase, IInteractionBlocker
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _severClip;

		[global::UnityEngine.SerializeField]
		private float _severSoundDistance;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _severedHandsPrefab;

		[global::UnityEngine.SerializeField]
		private int _overrideLayerIndex;


		private const BlockedInteraction Interactions = BlockedInteraction.All;

		private static readonly int HashSeveredHands = Animator.StringToHash("SeveredHands");

		public static readonly List<Footprint> AllSeveredHands = new List<Footprint>();

		[SerializeField]
		private float _tickDamage;

		public override bool AllowEnabling => true;

		public bool CanBeCleared => !base.IsEnabled;

		public BlockedInteraction BlockedInteractions => BlockedInteraction.All;

		protected override void Enabled()
		{
			base.Enabled();
			base.Hub.interCoordinator.AddBlocker(this);
			AllSeveredHands.Add(new Footprint(base.Hub));
			Transform transform = base.Hub.transform;
			Object.Instantiate(_severedHandsPrefab, transform.position, transform.rotation);
			AudioSourcePoolManager.PlayOnTransform(_severClip, base.Hub.transform, _severSoundDistance, 1f, FalloffType.Exponential);
			base.Hub.GetComponent<BloodDrawer>().PlaceUnderneath(base.transform.position, 2.5f);
			ChangeHandsState(handsCut: true);
		}

		protected override void Disabled()
		{
			base.Disabled();
			ChangeHandsState(handsCut: false);
		}

		protected override void OnTick()
		{
			if (NetworkServer.active)
			{
				base.Hub.inventory.ServerDropItem(base.Hub.inventory.CurItem.SerialNumber);
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(_tickDamage, DeathTranslations.SeveredHands));
			}
		}

		private void ChangeHandsState(bool handsCut)
		{
			if (base.Hub.roleManager.CurrentRole is HumanRole humanRole && humanRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel && animatedCharacterModel.HasParameter(HashSeveredHands))
			{
				animatedCharacterModel.Animator.SetBool(HashSeveredHands, handsCut);
			}
		}
	}
}

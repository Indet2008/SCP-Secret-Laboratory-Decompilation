using System;
using AudioPooling;
using InventorySystem.Items.Autosync;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles.PlayableScps.Scp1507;
using UnityEngine;

namespace InventorySystem.Items.FlamingoTapePlayer
{
	public class TapeItem : AutosyncItem, IItemDescription, IItemNametag, IHolidayItem
	{
		private bool _using;

		private double _equipTime;

		private float _remainingDestroy;

		private const float EquipAnimationTime = 0.32f;

		private const float DestroyTime = 7.6f;

		private const float SoundRange = 10f;

		[SerializeField]
		private AudioClip _successSound;

		[SerializeField]
		private AudioClip _failSound;

		[SerializeField]
		private AudioClip[] _useClips;

		public string Description => ItemTypeId.GetDescription();

		public string Name => ItemTypeId.GetName();

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Christmas };

		public override bool AllowHolster => !_using;

		public override float Weight => 0.35f;

		public static event Action<ushort, bool> OnPlayerTriggered;

		public override void OnEquipped()
		{
			base.OnEquipped();
			_equipTime = NetworkTime.time;
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (NetworkServer.active && _using)
			{
				_remainingDestroy -= Time.deltaTime;
				if (!(_remainingDestroy > 0f))
				{
					_using = false;
					base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
				}
			}
			else if (base.IsControllable && !(NetworkTime.time - _equipTime < 0.3199999928474426) && !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction) && GetActionDown(ActionName.Shoot))
			{
				ClientSendCmd();
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (base.IsEquipped && !_using && !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction))
			{
				bool success = Scp1507Spawner.CurState == Scp1507Spawner.State.Idle;
				_using = true;
				_remainingDestroy = 7.6f;
				ServerSendPublicRpc((NetworkWriter x) =>
				{
					x.WriteBool(success);
				});
				if (success)
				{
					Scp1507Spawner.StartSpawning(base.Owner);
				}
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			bool flag = reader.ReadBool();
			OnPlayerTriggered?.Invoke(serial, flag);
			if (InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
			{
				AudioClip genericClip = (flag ? _successSound : _failSound);
				bool isLocalPlayer = hub.isLocalPlayer;
				Transform parent = hub.transform;
				PlayClip(genericClip, parent, isLocalPlayer);
				AudioClip[] useClips = _useClips;
				for (int i = 0; i < useClips.Length; i++)
				{
					PlayClip(useClips[i], parent, isLocalPlayer);
				}
			}
			static void PlayClip(AudioClip sound, Transform trackedTransform, bool useSpatial)
			{
				AudioSourcePoolManager.PlayOnTransform(sound, trackedTransform);
			}
		}
	}
}

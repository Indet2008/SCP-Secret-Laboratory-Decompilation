using System.Collections.Generic;
using InventorySystem.Items.Pickups;
using MapGeneration.Holidays;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class SnowballItem : ThrowableItem, IHolidayItem
	{
		private static readonly Dictionary<ushort, double> StartCookingTimes = new Dictionary<ushort, double>();

		private static readonly HashSet<ushort> ThrownCooked = new HashSet<ushort>();

		public const float CookingTime = 4f;

		private ProjectileSettings _baseSettings;

		[SerializeField]
		private ProjectileSettings _cookedSettings;

		public new HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Christmas };

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			_baseSettings = FullThrowSettings;
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (ThrowStopwatch.IsRunning)
			{
				bool flag = ThrowStopwatch.Elapsed.TotalSeconds > 4.0;
				FullThrowSettings = (flag ? _cookedSettings : _baseSettings);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += ThrownCooked.Clear;
			CustomNetworkManager.OnClientReady += StartCookingTimes.Clear;
			ThrowableNetworkHandler.OnAudioMessageReceived += OnMsgReceived;
			ThrowableNetworkHandler.OnServerRequestReceived += OnMsgReceived;
		}

		private static void ProcessRequest(ushort serial, ThrowableNetworkHandler.RequestType request)
		{
			switch (request)
			{
			case ThrowableNetworkHandler.RequestType.BeginThrow:
				StartCookingTimes[serial] = NetworkTime.time;
				break;
			case ThrowableNetworkHandler.RequestType.CancelThrow:
				StartCookingTimes.Remove(serial);
				break;
			case ThrowableNetworkHandler.RequestType.ConfirmThrowWeak:
			case ThrowableNetworkHandler.RequestType.ConfirmThrowFullForce:
				if (IsCooked(serial, thrown: false))
				{
					ThrownCooked.Add(serial);
				}
				break;
			}
		}

		private static void OnMsgReceived(ThrowableNetworkHandler.ThrowableItemAudioMessage msg)
		{
			ProcessRequest(msg.Serial, msg.Request);
		}

		private static void OnMsgReceived(ThrowableNetworkHandler.ThrowableItemRequestMessage msg)
		{
			ProcessRequest(msg.Serial, msg.Request);
		}

		public static bool IsCooked(ushort serial, bool thrown)
		{
			if (thrown)
			{
				return ThrownCooked.Contains(serial);
			}
			if (StartCookingTimes.TryGetValue(serial, out var value))
			{
				return NetworkTime.time - value > 4.0;
			}
			return false;
		}
	}
}

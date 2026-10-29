namespace LabApi.Features.Wrappers
{
	public class Scp914 : global::LabApi.Features.Wrappers.Room
	{
		public static global::LabApi.Features.Wrappers.Scp914? Instance { get; private set; }

		public static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ItemBase, global::LabApi.Features.Interfaces.IScp914ItemProcessor> ItemProcessorCache { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ItemBase, global::LabApi.Features.Interfaces.IScp914ItemProcessor>();

		public static global::Scp914.Scp914KnobSetting KnobSetting
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.KnobSetting;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.Network_knobSetting = value;
			}
		}

		public static bool IsUpgrading
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.IsUpgrading;
			}
			set
			{
				if (global::Scp914.Scp914Controller.Singleton.IsUpgrading != value)
				{
					if (value)
					{
						global::Scp914.Scp914Controller.Singleton.Upgrade();
						return;
					}
					global::Scp914.Scp914Controller.Singleton.IsUpgrading = value;
					SequenceCooldown = 0f;
				}
			}
		}

		public static global::Scp914.Scp914Mode Mode
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.ConfigMode.Value;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.ConfigMode.Value = value;
			}
		}

		public static global::UnityEngine.Transform IntakeChamberTransform => global::Scp914.Scp914Controller.Singleton.IntakeChamber;

		public static global::UnityEngine.Transform OutputChamberTransform => global::Scp914.Scp914Controller.Singleton.OutputChamber;

		public static global::UnityEngine.Vector3 ChamberSize
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.ChamberSize;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.ChamberSize = value;
			}
		}

		public static float KnobChangeSequenceTime
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.KnobChangeCooldown;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.KnobChangeCooldown = value;
			}
		}

		public static float UpgradeSequenceTime
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.TotalSequenceTime;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.TotalSequenceTime = value;
			}
		}

		public static float SequenceCooldown
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.RemainingCooldown;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.RemainingCooldown = value;
			}
		}

		public static float DoorCloseDelay
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.DoorCloseTime;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.DoorCloseTime = value;
			}
		}

		public static float ItemUpgradeDelay
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.ItemUpgradeTime;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.ItemUpgradeTime = value;
			}
		}

		public static float DoorOpenDelay
		{
			get
			{
				return global::Scp914.Scp914Controller.Singleton.DoorOpenTime;
			}
			set
			{
				global::Scp914.Scp914Controller.Singleton.DoorOpenTime = value;
			}
		}

		public global::LabApi.Features.Wrappers.Gate Gate => (global::LabApi.Features.Wrappers.Gate)global::System.Linq.Enumerable.FirstOrDefault(base.Doors, (global::LabApi.Features.Wrappers.Door x) => x is global::LabApi.Features.Wrappers.Gate);

		public global::LabApi.Features.Wrappers.Door Entrance => global::System.Linq.Enumerable.FirstOrDefault(base.Doors, (global::LabApi.Features.Wrappers.Door x) => x.Rooms.Length == 2);

		public global::LabApi.Features.Wrappers.Door IntakeDoor => global::LabApi.Features.Wrappers.Door.Get(global::System.Linq.Enumerable.Last(global::Scp914.Scp914Controller.Singleton.Doors));

		public global::LabApi.Features.Wrappers.Door OutputDoor => global::LabApi.Features.Wrappers.Door.Get(global::System.Linq.Enumerable.First(global::Scp914.Scp914Controller.Singleton.Doors));

		public static void Interact(global::Scp914.Scp914InteractCode interactCode, global::LabApi.Features.Wrappers.Player? player = null)
		{
			if (player == null)
			{
				player = global::LabApi.Features.Wrappers.Server.Host;
			}
			global::Scp914.Scp914Controller.Singleton.ServerInteract(player.ReferenceHub, (byte)interactCode);
		}

		public static void PlaySound(global::Scp914.Scp914Sound sound)
		{
			global::Scp914.Scp914Controller.Singleton.RpcPlaySound((byte)sound);
		}

		public static global::LabApi.Features.Interfaces.IScp914ItemProcessor? GetItemProcessor(ItemType type)
		{
			if (!global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(type, out var result))
			{
				return null;
			}
			if (ItemProcessorCache.TryGetValue(result, out global::LabApi.Features.Interfaces.IScp914ItemProcessor value))
			{
				return value;
			}
			if (!result.TryGetComponent<global::Scp914.Processors.Scp914ItemProcessor>(out var component))
			{
				return null;
			}
			if (component is global::LabApi.Features.Wrappers.ItemProcessorAdapter itemProcessorAdapter)
			{
				ItemProcessorCache[result] = itemProcessorAdapter.Processor;
			}
			else
			{
				ItemProcessorCache[result] = new global::LabApi.Features.Wrappers.BaseGameItemProcessor(component);
			}
			return ItemProcessorCache[result];
		}

		public static global::System.Collections.Generic.Dictionary<ItemType, global::LabApi.Features.Interfaces.IScp914ItemProcessor?> GetAllItemProcessors()
		{
			global::System.Collections.Generic.Dictionary<ItemType, global::LabApi.Features.Interfaces.IScp914ItemProcessor> dictionary = new global::System.Collections.Generic.Dictionary<ItemType, global::LabApi.Features.Interfaces.IScp914ItemProcessor>();
			foreach (ItemType value in global::System.Enum.GetValues(typeof(ItemType)))
			{
				if (global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(value, out var _))
				{
					dictionary.Add(value, GetItemProcessor(value));
				}
			}
			return dictionary;
		}

		public static void SetItemProcessor<T>(ItemType type, T processor) where T : class, global::LabApi.Features.Interfaces.IScp914ItemProcessor
		{
			if (global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(type, out var result))
			{
				if (result.TryGetComponent<global::Scp914.Processors.Scp914ItemProcessor>(out var component))
				{
					global::UnityEngine.Object.Destroy(component);
				}
				result.gameObject.AddComponent<global::LabApi.Features.Wrappers.ItemProcessorAdapter>().Processor = processor;
				ItemProcessorCache[result] = processor;
			}
		}

		public static void SetItemProcessor<T>(global::System.Func<global::LabApi.Features.Wrappers.Item, bool> predicate, T processor) where T : class, global::LabApi.Features.Interfaces.IScp914ItemProcessor
		{
			foreach (ItemType value in global::System.Enum.GetValues(typeof(ItemType)))
			{
				if (global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(value, out var result) && predicate(global::LabApi.Features.Wrappers.Item.Get(result)))
				{
					SetItemProcessor(value, processor);
				}
			}
		}

		public static void SetItemProcessor<T>(ItemType type) where T : global::Scp914.Processors.Scp914ItemProcessor, new()
		{
			if (global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(type, out var result))
			{
				ItemProcessorCache.Remove(result);
				if (result.TryGetComponent<global::Scp914.Processors.Scp914ItemProcessor>(out var component))
				{
					global::UnityEngine.Object.Destroy(component);
				}
				result.gameObject.AddComponent<T>();
			}
		}

		public static void SetItemProcessor<T>(global::System.Func<global::LabApi.Features.Wrappers.Item, bool> predicate) where T : global::Scp914.Processors.Scp914ItemProcessor, new()
		{
			foreach (ItemType value in global::System.Enum.GetValues(typeof(ItemType)))
			{
				if (global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(value, out var result) && predicate(global::LabApi.Features.Wrappers.Item.Get(result)))
				{
					SetItemProcessor<T>(value);
				}
			}
		}

		internal Scp914(global::MapGeneration.RoomIdentifier roomIdentifier)
			: base(roomIdentifier)
		{
			if (base.CanCache)
			{
				Instance = this;
			}
		}

		internal override void OnRemoved()
		{
			base.OnRemoved();
			Instance = null;
		}
	}
}

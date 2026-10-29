namespace LabApi.Features.Wrappers
{
	public class Scp1509Item : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Scp1509.Scp1509Item, global::LabApi.Features.Wrappers.Scp1509Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Scp1509.Scp1509Item, global::LabApi.Features.Wrappers.Scp1509Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp1509Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Scp1509.Scp1509Item Base { get; }

		public float ShieldRegenRate
		{
			get
			{
				return Base.ShieldRegenRate;
			}
			set
			{
				Base.ShieldRegenRate = value;
			}
		}

		public float ShieldDecayRate
		{
			get
			{
				return Base.ShieldDecayRate;
			}
			set
			{
				Base.ShieldDecayRate = value;
			}
		}

		public float ShieldOnDamagePause
		{
			get
			{
				return Base.ShieldOnDamagePause;
			}
			set
			{
				Base.ShieldOnDamagePause = value;
			}
		}

		public float UnequipDecayDelay
		{
			get
			{
				return Base.UnequipDecayDelay;
			}
			set
			{
				Base.UnequipDecayDelay = value;
			}
		}

		public double NextResurrectTime
		{
			get
			{
				return Base.NextResurrectTime;
			}
			set
			{
				Base.NextResurrectTime = global::Mirror.NetworkTime.time + value;
			}
		}

		public double ReviveCooldown
		{
			get
			{
				return Base.ReviveCooldown;
			}
			set
			{
				Base.ReviveCooldown = value;
			}
		}

		public float EquippedHS
		{
			get
			{
				return Base.EquippedHS;
			}
			set
			{
				Base.EquippedHS = value;
			}
		}

		public float RevivedPlayerBlurTime
		{
			get
			{
				return Base.RevivedPlayerBlurTime;
			}
			set
			{
				Base.RevivedPlayerBlurTime = value;
			}
		}

		public float RevivedPlayerAOEBonusAHP
		{
			get
			{
				return Base.RevivedPlayerAOEBonusAHP;
			}
			set
			{
				Base.RevivedPlayerAOEBonusAHP = value;
			}
		}

		public float RevivedPlayerAOEBonusAHPDistance
		{
			get
			{
				return Base.RevivedPlayerAOEBonusAHPDistance;
			}
			set
			{
				Base.RevivedPlayerAOEBonusAHPDistance = value;
			}
		}

		public bool CanResurrect => Base.CanResurrect;

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> RevivedPlayers => global::System.Linq.Enumerable.Where(global::System.Linq.Enumerable.Select(Base.RevivedPlayers, global::LabApi.Features.Wrappers.Player.Get), (global::LabApi.Features.Wrappers.Player player) => player != null);

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseScp1509Item")]
		public static global::LabApi.Features.Wrappers.Scp1509Item? Get(global::InventorySystem.Items.Scp1509.Scp1509Item? baseScp1509Item)
		{
			if (baseScp1509Item == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseScp1509Item, out global::LabApi.Features.Wrappers.Scp1509Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp1509Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseScp1509Item);
			}
			return value;
		}

		public static bool IsEligible(global::LabApi.Features.Wrappers.Player player)
		{
			return global::InventorySystem.Items.Scp1509.Scp1509RespawnEligibility.IsEligible(player.ReferenceHub);
		}

		public static void SetEligible(global::LabApi.Features.Wrappers.Player player, bool isEligible)
		{
			global::InventorySystem.Items.Scp1509.Scp1509RespawnEligibility.SetEligible(player.ReferenceHub, isEligible);
		}

		internal Scp1509Item(global::InventorySystem.Items.Scp1509.Scp1509Item baseScp1509Item)
			: base(baseScp1509Item)
		{
			Base = baseScp1509Item;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp1509Item, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

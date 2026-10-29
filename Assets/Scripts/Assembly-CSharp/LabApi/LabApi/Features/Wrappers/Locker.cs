namespace LabApi.Features.Wrappers
{
	public class Locker : global::LabApi.Features.Wrappers.Structure
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.Locker> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.Locker>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Locker> List => Dictionary.Values;

		public new global::MapGeneration.Distributors.Locker Base { get; }

		public global::System.Collections.Generic.IReadOnlyList<global::LabApi.Features.Wrappers.LockerChamber> Chambers { get; }

		public global::MapGeneration.Distributors.LockerLoot[] Loot
		{
			get
			{
				return Base.Loot;
			}
			set
			{
				Base.Loot = value;
			}
		}

		public int MinChambersToFill
		{
			get
			{
				return Base.MinChambersToFill;
			}
			set
			{
				Base.MinChambersToFill = value;
			}
		}

		public int MaxChambersToFill
		{
			get
			{
				return Base.MaxChambersToFill;
			}
			set
			{
				Base.MaxChambersToFill = value;
			}
		}

		public bool IsEmpty => global::System.Linq.Enumerable.All(Chambers, (global::LabApi.Features.Wrappers.LockerChamber x) => x.IsEmpty);

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseLocker")]
		public static global::LabApi.Features.Wrappers.Locker? Get(global::MapGeneration.Distributors.Locker? baseLocker)
		{
			if (baseLocker == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseLocker, out global::LabApi.Features.Wrappers.Locker value))
			{
				return (global::LabApi.Features.Wrappers.Locker)global::LabApi.Features.Wrappers.Structure.CreateStructureWrapper(baseLocker);
			}
			return value;
		}

		internal Locker(global::MapGeneration.Distributors.Locker baseLocker)
			: base(baseLocker)
		{
			Base = baseLocker;
			Chambers = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Select(baseLocker.Chambers, (global::MapGeneration.Distributors.LockerChamber x) => global::LabApi.Features.Wrappers.LockerChamber.Get(x)));
			if (base.CanCache)
			{
				Dictionary.Add(baseLocker, this);
			}
		}

		public void AddLockerLoot(ItemType type, int remainingUses, int probabilityPoints, int minPerChamber, int maxPerChamber)
		{
			global::MapGeneration.Distributors.LockerLoot lockerLoot = new global::MapGeneration.Distributors.LockerLoot
			{
				TargetItem = type,
				RemainingUses = remainingUses,
				ProbabilityPoints = probabilityPoints,
				MinPerChamber = minPerChamber,
				MaxPerChamber = maxPerChamber
			};
			global::MapGeneration.Distributors.Locker locker = Base;
			global::MapGeneration.Distributors.LockerLoot[] loot = Base.Loot;
			int num = 0;
			global::MapGeneration.Distributors.LockerLoot[] array = new global::MapGeneration.Distributors.LockerLoot[1 + loot.Length];
			global::System.ReadOnlySpan<global::MapGeneration.Distributors.LockerLoot> readOnlySpan = new global::System.ReadOnlySpan<global::MapGeneration.Distributors.LockerLoot>(loot);
			readOnlySpan.CopyTo(new global::System.Span<global::MapGeneration.Distributors.LockerLoot>(array).Slice(num, readOnlySpan.Length));
			num += readOnlySpan.Length;
			array[num] = lockerLoot;
			locker.Loot = array;
		}

		public void RemoveLockerLoot(global::MapGeneration.Distributors.LockerLoot loot)
		{
			Base.Loot = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Except(Base.Loot, new _003C_003Ez__ReadOnlySingleElementList<global::MapGeneration.Distributors.LockerLoot>(loot)));
		}

		public void ClearLockerLoot()
		{
			Base.Loot = global::System.Array.Empty<global::MapGeneration.Distributors.LockerLoot>();
		}

		public void FillChambers()
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.LockerChamber> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.LockerChamber>.Shared.Rent();
			if (MinChambersToFill != 0 && MaxChambersToFill >= MinChambersToFill)
			{
				int num = Chambers.Count - global::UnityEngine.Random.Range(MinChambersToFill, MaxChambersToFill + 1);
				for (int i = 0; i < num; i++)
				{
					list.RemoveAt(global::UnityEngine.Random.Range(0, list.Count));
				}
			}
			foreach (global::LabApi.Features.Wrappers.LockerChamber item in list)
			{
				item.Fill();
			}
			global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.LockerChamber>.Shared.Return(list);
		}

		public void FillAllChambers()
		{
			foreach (global::LabApi.Features.Wrappers.LockerChamber chamber in Chambers)
			{
				chamber.Fill();
			}
		}

		public void ClearAllChambers()
		{
			foreach (global::LabApi.Features.Wrappers.LockerChamber chamber in Chambers)
			{
				chamber.RemoveAllItems();
			}
		}

		public void OpenAllChambers()
		{
			foreach (global::LabApi.Features.Wrappers.LockerChamber chamber in Chambers)
			{
				chamber.IsOpen = true;
			}
		}

		public void CloseAllChambers()
		{
			foreach (global::LabApi.Features.Wrappers.LockerChamber chamber in Chambers)
			{
				chamber.IsOpen = false;
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
			foreach (global::LabApi.Features.Wrappers.LockerChamber chamber in Chambers)
			{
				chamber.OnRemove();
			}
		}
	}
}

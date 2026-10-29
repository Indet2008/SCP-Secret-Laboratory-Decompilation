namespace LabApi.Features.Wrappers
{
	public class WallCabinet : global::LabApi.Features.Wrappers.Locker
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.WallCabinet> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.WallCabinet>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.WallCabinet> List => Dictionary.Values;

		public bool IsOpen
		{
			get
			{
				return MainChamber.IsOpen;
			}
			set
			{
				MainChamber.IsOpen = value;
			}
		}

		public bool CanInteract => MainChamber.CanInteract;

		public global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags RequiredPermissions
		{
			get
			{
				return MainChamber.RequiredPermissions;
			}
			set
			{
				MainChamber.RequiredPermissions = value;
			}
		}

		public float TargetCooldown
		{
			get
			{
				return MainChamber.TargetCooldown;
			}
			set
			{
				MainChamber.TargetCooldown = value;
			}
		}

		public global::LabApi.Features.Wrappers.LockerChamber MainChamber => base.Chambers[0];

		public global::LabApi.Features.Wrappers.LockerChamber LowerShelf => base.Chambers[1];

		public global::LabApi.Features.Wrappers.LockerChamber UpperShelf => base.Chambers[2];

		internal WallCabinet(global::MapGeneration.Distributors.Locker baseLocker)
			: base(baseLocker)
		{
			if (base.CanCache)
			{
				Dictionary.Add(baseLocker, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(base.Base);
		}
	}
}

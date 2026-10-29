namespace LabApi.Features.Wrappers
{
	public class RifleRackLocker : global::LabApi.Features.Wrappers.Locker
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.RifleRackLocker> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.RifleRackLocker>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.RifleRackLocker> List => Dictionary.Values;

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

		public global::LabApi.Features.Wrappers.LockerChamber Bullet1 => base.Chambers[1];

		public global::LabApi.Features.Wrappers.LockerChamber Bullet2 => base.Chambers[2];

		public global::LabApi.Features.Wrappers.LockerChamber Bullet3 => base.Chambers[3];

		public global::LabApi.Features.Wrappers.LockerChamber Bullet4 => base.Chambers[4];

		public global::LabApi.Features.Wrappers.LockerChamber HeGrenade1 => base.Chambers[5];

		public global::LabApi.Features.Wrappers.LockerChamber HeGrenade2 => base.Chambers[6];

		internal RifleRackLocker(global::MapGeneration.Distributors.Locker baseLocker)
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

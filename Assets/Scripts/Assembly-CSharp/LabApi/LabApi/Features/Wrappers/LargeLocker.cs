namespace LabApi.Features.Wrappers
{
	public class LargeLocker : global::LabApi.Features.Wrappers.Locker
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.LargeLocker> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.LargeLocker>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.LargeLocker> List => Dictionary.Values;

		public global::LabApi.Features.Wrappers.LockerChamber TopLeft => base.Chambers[0];

		public global::LabApi.Features.Wrappers.LockerChamber TopMiddle => base.Chambers[1];

		public global::LabApi.Features.Wrappers.LockerChamber TopRight => base.Chambers[2];

		public global::LabApi.Features.Wrappers.LockerChamber BottomLeft => base.Chambers[3];

		public global::LabApi.Features.Wrappers.LockerChamber BottomRight => base.Chambers[4];

		public global::LabApi.Features.Wrappers.LockerChamber MiddleLeft => base.Chambers[5];

		public global::LabApi.Features.Wrappers.LockerChamber Center => base.Chambers[6];

		public global::LabApi.Features.Wrappers.LockerChamber MiddleRight => base.Chambers[7];

		public global::LabApi.Features.Wrappers.LockerChamber BottomMiddle => base.Chambers[8];

		public global::LabApi.Features.Wrappers.LockerChamber Drawer => base.Chambers[9];

		internal LargeLocker(global::MapGeneration.Distributors.Locker baseLocker)
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

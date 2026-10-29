namespace LabApi.Features.Wrappers
{
	public class StandardLocker : global::LabApi.Features.Wrappers.Locker
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.StandardLocker> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Locker, global::LabApi.Features.Wrappers.StandardLocker>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.StandardLocker> List => Dictionary.Values;

		public global::LabApi.Features.Wrappers.LockerChamber MainLeft => base.Chambers[0];

		public global::LabApi.Features.Wrappers.LockerChamber MainMiddle => base.Chambers[1];

		public global::LabApi.Features.Wrappers.LockerChamber MainRight => base.Chambers[2];

		public global::LabApi.Features.Wrappers.LockerChamber BottomLeft => base.Chambers[5];

		public global::LabApi.Features.Wrappers.LockerChamber BottomMiddle => base.Chambers[4];

		public global::LabApi.Features.Wrappers.LockerChamber BottomRight => base.Chambers[3];

		internal StandardLocker(global::MapGeneration.Distributors.Locker baseLocker)
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

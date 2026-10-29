namespace LabApi.Features.Wrappers
{
	public class DoorCrusher
	{
		public global::Interactables.Interobjects.DoorUtils.DoorCrusherExtension Base { get; }

		public float MaxThreshold
		{
			get
			{
				return Base.MaxCrushThreshold;
			}
			set
			{
				Base.MaxCrushThreshold = value;
			}
		}

		public float MinThreshold
		{
			get
			{
				return Base.MinCrushThreshold;
			}
			set
			{
				Base.MinCrushThreshold = value;
			}
		}

		public global::UnityEngine.Collider DeathCollider => Base.DeathCollider;

		public float ScpDamage
		{
			get
			{
				return Base.ScpCrushDamage;
			}
			set
			{
				Base.ScpCrushDamage = value;
			}
		}

		public bool IgnoreScps
		{
			get
			{
				return Base.IgnoreScps;
			}
			set
			{
				Base.IgnoreScps = value;
			}
		}

		public DoorCrusher(global::Interactables.Interobjects.DoorUtils.DoorCrusherExtension doorCrusher)
		{
			Base = doorCrusher;
		}
	}
}

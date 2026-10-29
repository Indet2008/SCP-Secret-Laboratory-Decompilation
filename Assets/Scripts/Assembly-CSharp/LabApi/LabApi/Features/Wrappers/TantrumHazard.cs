namespace LabApi.Features.Wrappers
{
	public class TantrumHazard : global::LabApi.Features.Wrappers.DecayableHazard
	{
		public new static global::System.Collections.Generic.Dictionary<global::Hazards.TantrumEnvironmentalHazard, global::LabApi.Features.Wrappers.TantrumHazard> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Hazards.TantrumEnvironmentalHazard, global::LabApi.Features.Wrappers.TantrumHazard>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.TantrumHazard> List => Dictionary.Values;

		protected new static global::Hazards.TantrumEnvironmentalHazard? BasePrefab { get; private set; }

		public global::UnityEngine.Vector3 SyncedPosition
		{
			get
			{
				return Base.SynchronizedPosition.Position;
			}
			set
			{
				Base.SynchronizedPosition = new global::RelativePositioning.RelativePosition(value);
			}
		}

		public bool PlaySizzle
		{
			get
			{
				return Base.PlaySizzle;
			}
			set
			{
				Base.PlaySizzle = value;
			}
		}

		public new global::Hazards.TantrumEnvironmentalHazard Base { get; }

		public static global::LabApi.Features.Wrappers.TantrumHazard Spawn(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale)
		{
			if (BasePrefab == null)
			{
				BasePrefab = global::LabApi.Features.Wrappers.Hazard.GetPrefab<global::Hazards.TantrumEnvironmentalHazard>();
			}
			global::LabApi.Features.Wrappers.TantrumHazard obj = (global::LabApi.Features.Wrappers.TantrumHazard)global::LabApi.Features.Wrappers.Hazard.Spawn(BasePrefab, position, rotation, scale);
			obj.SyncedPosition = position;
			return obj;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("hazard")]
		public static global::LabApi.Features.Wrappers.TantrumHazard? Get(global::Hazards.TantrumEnvironmentalHazard? hazard)
		{
			if (hazard == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(hazard, out global::LabApi.Features.Wrappers.TantrumHazard value))
			{
				return (global::LabApi.Features.Wrappers.TantrumHazard)global::LabApi.Features.Wrappers.Hazard.CreateItemWrapper(hazard);
			}
			return value;
		}

		internal TantrumHazard(global::Hazards.TantrumEnvironmentalHazard hazard)
			: base(hazard)
		{
			Base = hazard;
			if (base.CanCache)
			{
				Dictionary.Add(hazard, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

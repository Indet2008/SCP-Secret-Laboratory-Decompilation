namespace LabApi.Features.Wrappers
{
	public class DecayableHazard : global::LabApi.Features.Wrappers.Hazard
	{
		public new static global::System.Collections.Generic.Dictionary<global::Hazards.TemporaryHazard, global::LabApi.Features.Wrappers.DecayableHazard> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Hazards.TemporaryHazard, global::LabApi.Features.Wrappers.DecayableHazard>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.DecayableHazard> List => Dictionary.Values;

		public float DecaySpeed
		{
			get
			{
				return Base.DecaySpeed;
			}
			set
			{
				Base.DecaySpeed = value;
			}
		}

		public float LiveDuration
		{
			get
			{
				return Base.HazardDuration;
			}
			set
			{
				Base.HazardDuration = value;
			}
		}

		public float Elapsed
		{
			get
			{
				return Base.Elapsed;
			}
			set
			{
				Base.Elapsed = value;
			}
		}

		public new global::Hazards.TemporaryHazard Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("hazard")]
		public static global::LabApi.Features.Wrappers.DecayableHazard? Get(global::Hazards.TemporaryHazard? hazard)
		{
			if (hazard == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(hazard, out global::LabApi.Features.Wrappers.DecayableHazard value))
			{
				return (global::LabApi.Features.Wrappers.DecayableHazard)global::LabApi.Features.Wrappers.Hazard.CreateItemWrapper(hazard);
			}
			return value;
		}

		protected DecayableHazard(global::Hazards.TemporaryHazard hazard)
			: base(hazard)
		{
			Base = hazard;
			if (base.CanCache)
			{
				Dictionary.Add(hazard, this);
			}
		}

		public override void Destroy()
		{
			Base.ServerDestroy();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

namespace LabApi.Features.Wrappers
{
	public class SinkholeHazard : global::LabApi.Features.Wrappers.Hazard
	{
		public new static global::System.Collections.Generic.Dictionary<global::Hazards.SinkholeEnvironmentalHazard, global::LabApi.Features.Wrappers.SinkholeHazard> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Hazards.SinkholeEnvironmentalHazard, global::LabApi.Features.Wrappers.SinkholeHazard>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.SinkholeHazard> List => Dictionary.Values;

		protected new static global::Hazards.SinkholeEnvironmentalHazard? BasePrefab { get; private set; }

		public new global::Hazards.SinkholeEnvironmentalHazard Base { get; }

		public static global::LabApi.Features.Wrappers.SinkholeHazard Spawn(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale)
		{
			if (BasePrefab == null)
			{
				BasePrefab = global::LabApi.Features.Wrappers.Hazard.GetPrefab<global::Hazards.SinkholeEnvironmentalHazard>();
			}
			global::LabApi.Features.Wrappers.SinkholeHazard obj = (global::LabApi.Features.Wrappers.SinkholeHazard)global::LabApi.Features.Wrappers.Hazard.Spawn(BasePrefab, position, rotation, scale);
			obj.IsActive = true;
			return obj;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("hazard")]
		public static global::LabApi.Features.Wrappers.SinkholeHazard? Get(global::Hazards.SinkholeEnvironmentalHazard? hazard)
		{
			if (hazard == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(hazard, out global::LabApi.Features.Wrappers.SinkholeHazard value))
			{
				return (global::LabApi.Features.Wrappers.SinkholeHazard)global::LabApi.Features.Wrappers.Hazard.CreateItemWrapper(hazard);
			}
			return value;
		}

		internal SinkholeHazard(global::Hazards.SinkholeEnvironmentalHazard hazard)
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

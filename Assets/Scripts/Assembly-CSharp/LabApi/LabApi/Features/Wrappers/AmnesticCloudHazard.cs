namespace LabApi.Features.Wrappers
{
	public class AmnesticCloudHazard : global::LabApi.Features.Wrappers.DecayableHazard
	{
		public new static global::System.Collections.Generic.Dictionary<global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance, global::LabApi.Features.Wrappers.AmnesticCloudHazard> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance, global::LabApi.Features.Wrappers.AmnesticCloudHazard>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.AmnesticCloudHazard> List => Dictionary.Values;

		protected new static global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance? BasePrefab { get; private set; }

		public global::UnityEngine.Vector3 SyncedPosition
		{
			get
			{
				return Base.SyncedPosition.Position;
			}
			set
			{
				Base.SyncedPosition = new global::RelativePositioning.RelativePosition(value);
			}
		}

		public byte VisualSize
		{
			get
			{
				return Base.HoldDuration;
			}
			set
			{
				Base.HoldDuration = value;
			}
		}

		public float PauseDuration
		{
			get
			{
				return Base.PauseDuration;
			}
			set
			{
				Base.PauseDuration = value;
			}
		}

		public float AmnesiaDuration
		{
			get
			{
				return Base.AmnesiaDuration;
			}
			set
			{
				Base.AmnesiaDuration = value;
			}
		}

		public global::LabApi.Features.Wrappers.Player? Owner
		{
			get
			{
				return global::LabApi.Features.Wrappers.Player.Get(Base.Owner);
			}
			set
			{
				if (value == null)
				{
					Base.Network_syncOwner = 0u;
				}
				else
				{
					Base.Owner = value.ReferenceHub;
				}
			}
		}

		public global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance.CloudState State => Base.State;

		public new global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance Base { get; }

		public static global::LabApi.Features.Wrappers.AmnesticCloudHazard Spawn(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, float duration = 90f, byte size = byte.MaxValue, global::LabApi.Features.Wrappers.Player? owner = null)
		{
			if (BasePrefab == null)
			{
				BasePrefab = global::LabApi.Features.Wrappers.Hazard.GetPrefab<global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance>();
			}
			global::LabApi.Features.Wrappers.AmnesticCloudHazard amnesticCloudHazard = (global::LabApi.Features.Wrappers.AmnesticCloudHazard)global::LabApi.Features.Wrappers.Hazard.Spawn(BasePrefab, position, rotation, scale);
			amnesticCloudHazard.Base.State = global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance.CloudState.Created;
			amnesticCloudHazard.LiveDuration = duration;
			amnesticCloudHazard.VisualSize = size;
			amnesticCloudHazard.SyncedPosition = position;
			global::UnityEngine.Vector2 minMaxTime = amnesticCloudHazard.Base.MinMaxTime;
			amnesticCloudHazard.MaxDistance = global::UnityEngine.Mathf.Lerp(minMaxTime.x, minMaxTime.y, size / 255);
			if (owner != null)
			{
				amnesticCloudHazard.Owner = owner;
			}
			return amnesticCloudHazard;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("hazard")]
		public static global::LabApi.Features.Wrappers.AmnesticCloudHazard? Get(global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance? hazard)
		{
			if (hazard == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(hazard, out global::LabApi.Features.Wrappers.AmnesticCloudHazard value))
			{
				return (global::LabApi.Features.Wrappers.AmnesticCloudHazard)global::LabApi.Features.Wrappers.Hazard.CreateItemWrapper(hazard);
			}
			return value;
		}

		internal AmnesticCloudHazard(global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance hazard)
			: base(hazard)
		{
			Base = hazard;
			if (base.CanCache)
			{
				Dictionary.Add(hazard, this);
			}
		}

		public void Pause(float customDuration = -1f)
		{
			if (customDuration > 0f)
			{
				float pauseDuration = PauseDuration;
				PauseDuration = customDuration;
				Base.PauseAll();
				PauseDuration = pauseDuration;
			}
			else
			{
				Base.PauseAll();
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

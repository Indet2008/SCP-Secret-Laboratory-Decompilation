namespace LabApi.Features.Wrappers
{
	public class ShootingTargetToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.ShootingTarget, global::LabApi.Features.Wrappers.ShootingTargetToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.ShootingTarget, global::LabApi.Features.Wrappers.ShootingTargetToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.ShootingTargetToy> List => Dictionary.Values;

		public new global::AdminToys.ShootingTarget Base { get; }

		public bool IsGlobal
		{
			get
			{
				return Base.Network_syncMode;
			}
			set
			{
				Base.Network_syncMode = value;
			}
		}

		public static global::LabApi.Features.Wrappers.ShootingTargetToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.ShootingTargetToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.ShootingTargetToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.ShootingTargetToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.ShootingTargetToy shootingTargetToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.ShootingTarget>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				shootingTargetToy.Spawn();
			}
			return shootingTargetToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("shootingTarget")]
		public static global::LabApi.Features.Wrappers.ShootingTargetToy? Get(global::AdminToys.ShootingTarget? shootingTarget)
		{
			if (shootingTarget == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(shootingTarget, out global::LabApi.Features.Wrappers.ShootingTargetToy value))
			{
				return (global::LabApi.Features.Wrappers.ShootingTargetToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(shootingTarget);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.ShootingTarget? shootingTarget, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.ShootingTargetToy? shootingTargetToy)
		{
			shootingTargetToy = Get(shootingTarget);
			return shootingTargetToy != null;
		}

		internal ShootingTargetToy(global::AdminToys.ShootingTarget shootingTarget)
			: base(shootingTarget)
		{
			Base = shootingTarget;
			if (base.CanCache)
			{
				Dictionary.Add(shootingTarget, this);
			}
		}

		public override string ToString()
		{
			return $"[ShootingTargetToy: IsGlobal={IsGlobal}]";
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

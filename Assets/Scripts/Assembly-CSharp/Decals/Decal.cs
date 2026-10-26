using System;
using ProgressiveCulling;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace Decals
{
	[RequireComponent(typeof(DecalProjector))]
	public class Decal : CullableBehaviour
	{
		[Serializable]
		private class GridSettings
		{
			public bool Enabled;

			public int GridSize;

			public int DecalsNum;

			private Decal _decalRef;

			private bool _tilingSet;

			public void SetReference(Decal decal)
			{
				_decalRef = decal;
			}

			public void ProcessAttachment()
			{
				if (Enabled)
				{
					int num = UnityEngine.Random.Range(0, DecalsNum);
					int num2 = num % GridSize;
					int num3 = num / GridSize;
					num3 = GridSize - 1 - num3;
					_decalRef.UVOffset = new Vector2(num2, num3) / GridSize;
					if (!_tilingSet)
					{
						_decalRef.UVTiling = Vector2.one / GridSize;
						_tilingSet = true;
					}
				}
			}
		}

		private DecalProjector _projector;

		private CullableRoom _parentCullableRoom;

		private bool _attachedToSurface;

		private const float SurfaceDistance = 0.02f;

		private Color _instancedColor;

		private Material _materialInstance;

		private Vector3 _defaultSize;

		[SerializeField]
		private GridSettings _gridSettings;

		[SerializeField]
		private float _sizeMaxRandomMultiplier;

		public DecalPoolType DecalPoolType;

		public Color InstancedColor
		{
			get
			{
				return _instancedColor;
			}
			set
			{
				if (_materialInstance == null)
				{
					_materialInstance = new Material(_projector.material);
					_projector.material = _materialInstance;
				}
				_instancedColor = value;
				_projector.material.SetColor("_BaseColor", _instancedColor);
			}
		}

		public Material DecalMaterial
		{
			get
			{
				return _projector.material;
			}
			set
			{
				_projector.material = value;
			}
		}

		public Vector3 DecalSize
		{
			get
			{
				return _projector.size;
			}
			set
			{
				_projector.size = value;
			}
		}

		public Vector2 UVOffset
		{
			get
			{
				return _projector.uvBias;
			}
			set
			{
				_projector.uvBias = value;
			}
		}

		public Vector2 UVTiling
		{
			get
			{
				return _projector.uvScale;
			}
			set
			{
				_projector.uvScale = value;
			}
		}

		public Transform CachedTransform { get; private set; }

		public override bool ShouldBeVisible => CullingCamera.CheckBoundsVisibility(new Bounds(CachedTransform.position, DecalSize));

		public virtual void AttachToSurface(RaycastHit hitSurface)
		{
			Transform transform = hitSurface.collider.transform;
			CachedTransform.SetParent(transform);
			CachedTransform.SetPositionAndRotation(hitSurface.point + hitSurface.normal * 0.02f, Quaternion.LookRotation(-hitSurface.normal));
			if (transform.TryGetComponentInParent<CullableRoom>(out _parentCullableRoom))
			{
				_parentCullableRoom.AddChildCullable(this);
				_attachedToSurface = true;
			}
			_gridSettings.ProcessAttachment();
			if (_sizeMaxRandomMultiplier > 0f)
			{
				DecalSize = _defaultSize * (UnityEngine.Random.value * _sizeMaxRandomMultiplier + 1f);
			}
		}

		public virtual void Detach()
		{
			if (_attachedToSurface)
			{
				_attachedToSurface = false;
				if (_parentCullableRoom != null)
				{
					_parentCullableRoom.RemoveChildSullable(this);
				}
			}
		}

		public void SetRandomRotation()
		{
			CachedTransform.Rotate(0f, 0f, UnityEngine.Random.value * 360f, Space.Self);
		}

		protected virtual void Awake()
		{
			_projector = GetComponent<DecalProjector>();
			CachedTransform = base.transform;
			_gridSettings.SetReference(this);
			_defaultSize = DecalSize;
		}

		protected virtual void OnEnable()
		{
			_projector.enabled = true;
		}

		protected virtual void OnDisable()
		{
			_projector.enabled = false;
		}

		protected override void OnVisibilityChanged(bool isVisible)
		{
			base.enabled = isVisible;
		}
	}
}

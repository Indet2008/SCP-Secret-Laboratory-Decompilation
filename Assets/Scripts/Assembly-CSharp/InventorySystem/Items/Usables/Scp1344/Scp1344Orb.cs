using System;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp1344
{
	public class Scp1344Orb : MonoBehaviour
	{
		private Transform _tr;

		[field: SerializeField]
		public ParticleSystem ParticleSystem { get; private set; }

		public bool ParticleEmissionEnabled
		{
			get
			{
				return ParticleSystem.emission.enabled;
			}
			set
			{
				ParticleSystem.EmissionModule emission = ParticleSystem.emission;
				emission.enabled = value;
			}
		}

		public Color ParticleColor
		{
			get
			{
				return ParticleSystem.main.startColor.color;
			}
			set
			{
				ParticleSystem.MainModule main = ParticleSystem.main;
				main.startColor = new ParticleSystem.MinMaxGradient(value);
			}
		}

		public Vector3 Position
		{
			get
			{
				return _tr.position;
			}
			set
			{
				_tr.position = value;
			}
		}

		public Vector3 Scale
		{
			get
			{
				return _tr.localScale;
			}
			set
			{
				_tr.localScale = value;
			}
		}

		public event Action OnDestroyCallback;

		private void Awake()
		{
			_tr = base.transform;
		}

		private void OnDestroy()
		{
			OnDestroyCallback?.Invoke();
		}
	}
}

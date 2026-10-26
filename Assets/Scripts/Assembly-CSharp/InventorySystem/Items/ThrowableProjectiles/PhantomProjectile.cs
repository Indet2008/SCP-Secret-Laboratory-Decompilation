using Mirror;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class PhantomProjectile : MonoBehaviour
	{
		public Rigidbody Rigidbody;

		[SerializeField]
		private float _minimalExistenceTime;

		[SerializeField]
		private float _transitionTime;

		[SerializeField]
		private Vector3 _startScale;

		[SerializeField]
		private Vector3 _targetScale;

		private const float AutoDestroyTime = 0.5f;

		private ushort _projectileSerial;

		private float _scaleFactor;

		private float _transitionFactor;

		private float _replaceTime;

		private bool _hasPickup;

		private ThrownProjectile _pickupToReplace;

		private float CurTime => Time.timeSinceLevelLoad;

		public void Init(ushort serial)
		{
			ThrownProjectile.OnProjectileSpawned += OnSpawned;
			_projectileSerial = serial;
			base.gameObject.SetActive(value: false);
		}

		public void Activate(Transform cam, Vector3 relativePosition)
		{
			base.gameObject.SetActive(value: true);
			_replaceTime = CurTime + _minimalExistenceTime;
			_scaleFactor = -1f;
			_transitionFactor = -1f;
			Object.Destroy(base.gameObject, _minimalExistenceTime + _transitionTime + 0.5f);
			base.transform.SetParent(null);
			base.transform.position = cam.TransformPoint(relativePosition);
			base.transform.localScale = _startScale;
		}

		private void OnDestroy()
		{
			ThrownProjectile.OnProjectileSpawned -= OnSpawned;
		}

		private void Update()
		{
			if (_scaleFactor < 1f)
			{
				_scaleFactor = Mathf.Clamp01(_scaleFactor + Time.deltaTime / _minimalExistenceTime);
				base.transform.localScale = Vector3.Lerp(_startScale, _targetScale, _scaleFactor);
			}
			if (_hasPickup && !(CurTime < _replaceTime))
			{
				Replace();
			}
		}

		private void Replace()
		{
			if (_pickupToReplace != null)
			{
				if (_transitionFactor < 1f && _pickupToReplace.TryGetComponent<Rigidbody>(out var component))
				{
					_transitionFactor = Mathf.Clamp01(_transitionFactor + Time.deltaTime / _transitionTime);
					Rigidbody.MovePosition(Vector3.Lerp(Rigidbody.position, component.position, _transitionFactor));
					Rigidbody.linearVelocity = Vector3.Lerp(Rigidbody.linearVelocity, component.linearVelocity, _transitionFactor);
					Rigidbody.rotation = Quaternion.Lerp(Rigidbody.rotation, component.rotation, _transitionFactor);
					return;
				}
				_pickupToReplace.ToggleRenderers(state: true);
			}
			Object.Destroy(base.gameObject);
		}

		private void OnSpawned(ThrownProjectile projectile)
		{
			if (projectile.Info.Serial == _projectileSerial)
			{
				_hasPickup = true;
				_pickupToReplace = projectile;
				if (!NetworkServer.active)
				{
					projectile.ToggleRenderers(state: false);
				}
				else
				{
					Replace();
				}
			}
		}
	}
}

using System;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ViewmodelScp127Extension : MonoBehaviour, IViewmodelExtension
	{
		[Serializable]
		private struct ShotForce
		{
			[SerializeField]
			private Transform _forwardTr;

			[SerializeField]
			private float _minForce;

			[SerializeField]
			private float _maxForce;

			public readonly Vector3 GetRandom()
			{
				return _forwardTr.forward * UnityEngine.Random.Range(_minForce, _maxForce);
			}
		}

		private ushort _serial;

		[SerializeField]
		private Transform _applyForcePoint;

		[SerializeField]
		private Rigidbody _slingLoopRb;

		[SerializeField]
		private ShotForce[] _onShotForces;

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_serial = viewmodel.ItemId.SerialNumber;
			ShotEventManager.OnShot += OnShot;
		}

		private void OnDestroy()
		{
			ShotEventManager.OnShot -= OnShot;
		}

		private void OnDisable()
		{
			_slingLoopRb.transform.localRotation = Quaternion.identity;
		}

		private void OnShot(ShotEvent ev)
		{
			if (ev.ItemId.SerialNumber == _serial)
			{
				Vector3 position = _applyForcePoint.position;
				ShotForce[] onShotForces = _onShotForces;
				foreach (ShotForce shotForce in onShotForces)
				{
					_slingLoopRb.AddForceAtPosition(shotForce.GetRandom(), position);
				}
			}
		}
	}
}

using System;
using UnityEngine;

namespace Interactables.Interobjects.DoorUtils
{
	public class BrokenDoor : MonoBehaviour
	{
		[Serializable]
		public struct BrokenDoorPart
		{
			[SerializeField]
			private Rigidbody _rigidbody;

			[SerializeField]
			private float _force;

			[SerializeField]
			private float _randomTorque;

			[SerializeField]
			private Vector3 _direction;

			public void Init()
			{
				_rigidbody.linearVelocity = _rigidbody.transform.TransformDirection(_direction.normalized) * _force;
				_rigidbody.angularVelocity = new Vector3((UnityEngine.Random.value - 0.5f) * 2f, (UnityEngine.Random.value - 0.5f) * 2f, (UnityEngine.Random.value - 0.5f) * 2f) * _randomTorque;
			}

			public void Freeze()
			{
				Collider[] components = _rigidbody.GetComponents<Collider>();
				for (int i = 0; i < components.Length; i++)
				{
					components[i].enabled = false;
				}
				UnityEngine.Object.Destroy(_rigidbody);
			}
		}

		[SerializeField]
		private BrokenDoorPart[] _parts;

		[SerializeField]
		private float _timeUntilFreeze = 5f;

		private void Start()
		{
			BrokenDoorPart[] parts = _parts;
			foreach (BrokenDoorPart brokenDoorPart in parts)
			{
				brokenDoorPart.Init();
			}
		}

		private void Update()
		{
			_timeUntilFreeze -= Time.deltaTime;
			if (_timeUntilFreeze < 0f)
			{
				BrokenDoorPart[] parts = _parts;
				foreach (BrokenDoorPart brokenDoorPart in parts)
				{
					brokenDoorPart.Freeze();
				}
				base.enabled = false;
			}
		}
	}
}

using Interactables.Interobjects;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class RippleInstance : MonoBehaviour
	{
		private bool _inElevator;

		private Vector3 _pos;

		private Transform _t;

		private float _setTime;

		private const float MinDuration = 3f;

		[field: SerializeField]
		public ParticleSystem MainParticleSystem { get; private set; }

		public bool InUse => Time.timeSinceLevelLoad - _setTime <= 0f;

		public void Set(Vector3 pos, Color col)
		{
			if (_inElevator)
			{
				_t.SetParent(null);
				_inElevator = false;
			}
			_pos = pos;
			_t.position = pos;
			_setTime = Time.timeSinceLevelLoad + 3f;
			ParticleSystem.MainModule main = MainParticleSystem.main;
			main.startColor = col;
			MainParticleSystem.Play(withChildren: true);
		}

		private void OnDisable()
		{
			_setTime = 0f;
		}

		private void OnDestroy()
		{
			ElevatorChamber.OnElevatorMoved -= OnElevatorMoved;
		}

		private void Awake()
		{
			_t = base.transform;
			ElevatorChamber.OnElevatorMoved += OnElevatorMoved;
		}

		private void OnElevatorMoved(Bounds elevatorBounds, ElevatorChamber chamber, Vector3 deltaPos, Quaternion deltaRot)
		{
			if (!_inElevator && elevatorBounds.Contains(_pos))
			{
				_t.SetParent(chamber.transform);
				_t.position += deltaPos;
				_inElevator = true;
			}
		}
	}
}

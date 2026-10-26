using Mirror;
using PlayerRoles.FirstPersonControl;
using RelativePositioning;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin.Dummies
{
	public class PlayerFollower : MonoBehaviour
	{
		private const float DefaultMaxDistance = 20f;

		private const float DefaultMinDistance = 1.75f;

		private const float DefaultSpeed = 30f;

		private ReferenceHub _hub;

		private ReferenceHub _hubToFollow;

		private float _maxDistance;

		private float _minDistance;

		private float _speed;

		public void Init(ReferenceHub playerToFollow, float maxDistance = 20f, float minDistance = 1.75f, float speed = 30f)
		{
			_hub = GetComponent<ReferenceHub>();
			_hubToFollow = playerToFollow;
			_maxDistance = maxDistance;
			_minDistance = minDistance;
			_speed = speed;
		}

		private void Update()
		{
			if (!NetworkServer.active || _hubToFollow == null || _hub == null || !(_hubToFollow.roleManager.CurrentRole is IFpcRole) || !(_hub.roleManager.CurrentRole is IFpcRole { FpcModule: var fpcModule }))
			{
				Object.Destroy(this);
				return;
			}
			float num = Vector3.Distance(_hubToFollow.transform.position, base.transform.position);
			if (num > _maxDistance)
			{
				fpcModule.ServerOverridePosition(_hubToFollow.transform.position);
			}
			else if (!(num < _minDistance))
			{
				Vector3 position = base.transform.position;
				Vector3 dir = _hubToFollow.transform.position - position;
				Vector3 vector = Time.deltaTime * _speed * dir.normalized;
				fpcModule.Motor.ReceivedPosition = new RelativePosition(position + vector);
				fpcModule.MouseLook.LookAtDirection(dir);
			}
		}
	}
}

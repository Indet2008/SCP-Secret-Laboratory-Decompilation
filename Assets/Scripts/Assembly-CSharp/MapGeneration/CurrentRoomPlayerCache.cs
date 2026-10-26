using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using RoundRestarting;
using UnityEngine;

namespace MapGeneration
{
	public class CurrentRoomPlayerCache : MonoBehaviour
	{
		[SerializeField]
		private PlayerRoleManager _roleManager;

		private bool _hasAnyValidRoom;

		private bool _lastValid;

		private RoomIdentifier _lastDetected;

		private int _lastFrame;

		private Transform _tr;

		private void Awake()
		{
			_tr = base.transform;
		}

		private void Update()
		{
			if (NetworkServer.active || _roleManager.isLocalPlayer)
			{
				ValidateCache();
			}
		}

		private void ValidateCache()
		{
			if (_lastFrame == Time.frameCount || RoundRestart.IsRoundRestarting)
			{
				return;
			}
			Vector3 worldPos = ((_roleManager.CurrentRole is ICameraController cameraController) ? cameraController.CameraPosition : _tr.position);
			RoomIdentifier lastDetected = _lastDetected;
			if (_roleManager.Hub.IsAlive() && worldPos.TryGetRoom(out var room))
			{
				_lastDetected = room;
				_lastValid = true;
				_hasAnyValidRoom = true;
			}
			else
			{
				_lastValid = false;
				_lastDetected = null;
				_hasAnyValidRoom = false;
			}
			if (lastDetected != _lastDetected)
			{
				PlayerEvents.OnRoomChanged(new PlayerRoomChangedEventArgs(_roleManager.Hub, lastDetected, _lastDetected));
				if (lastDetected != null && _lastDetected != null && lastDetected.Zone != _lastDetected.Zone)
				{
					PlayerEvents.OnZoneChanged(new PlayerZoneChangedEventArgs(_roleManager.Hub, lastDetected?.Zone ?? FacilityZone.None, _lastDetected?.Zone ?? FacilityZone.None));
				}
			}
			_lastFrame = Time.frameCount;
		}

		public void ForceUnvalidate()
		{
			_lastFrame = Time.frameCount - 1;
		}

		public bool TryGetCurrent(out RoomIdentifier rid)
		{
			ValidateCache();
			rid = _lastDetected;
			return _lastValid;
		}

		public bool TryGetLastValid(out RoomIdentifier rid)
		{
			ValidateCache();
			rid = _lastDetected;
			return _hasAnyValidRoom;
		}
	}
}

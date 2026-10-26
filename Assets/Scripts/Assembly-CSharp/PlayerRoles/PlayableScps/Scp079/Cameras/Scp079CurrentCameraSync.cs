using System;
using System.Diagnostics;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.Scp079Events;
using LabApi.Events.Handlers;
using MapGeneration;
using MapGeneration.Distributors;
using Mirror;
using NetworkManagerUtils.Dummies;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079.Cameras
{
	public class Scp079CurrentCameraSync : StandardSubroutine<Scp079Role>, IScp079FailMessageProvider
	{
		public enum ClientSwitchState
		{
			None = 0,
			SwitchingRoom = 1,
			SwitchingZone = 2
		}

		public const float CostPerMeter = 0.16f;

		public const int CostPerFloor = 5;

		public const int CostPerZone = 10;

		public const int CostPerSkippedZone = 20;

		public static readonly FacilityZone[] ZoneQueue = new FacilityZone[4]
		{
			FacilityZone.Surface,
			FacilityZone.Entrance,
			FacilityZone.HeavyContainment,
			FacilityZone.LightContainment
		};

		private const float FloorHeight = 60f;

		private const int ErrorTranslationId = 2;

		private const float SameRoomSwitchDuration = 0.1f;

		private const float ZoneSwitchDuration = 0.98f;

		private const string DefaultCameraName = "079 CONT CHAMBER";

		private readonly Stopwatch _switchStopwatch = new Stopwatch();

		private Scp079Camera _lastCam;

		private Scp079Camera _switchTarget;

		private Scp079AuxManager _auxManager;

		private Scp079LostSignalHandler _lostSignalHandler;

		private bool _camSet;

		private bool _eventAssigned;

		private float _targetSwitchTime;

		private ushort _defaultCamId;

		private ushort _requestedCamId;

		private bool _initialized;

		private Scp079HudTranslation _errorCode;

		private ClientSwitchState _clientSwitchRequest;

		public string FailMessage { get; private set; }

		public ClientSwitchState CurClientSwitchState { get; private set; }

		public FacilityZone CurClientTargetZone { get; private set; }

		public Scp079Camera CurrentCamera
		{
			get
			{
				TryGetCurrentCamera(out var cam);
				return cam;
			}
			private set
			{
				value.IsActive = true;
				_camSet = true;
				if (value == _lastCam)
				{
					return;
				}
				_lastCam = value;
				OnCameraChanged?.Invoke();
				if (!NetworkServer.active)
				{
					return;
				}
				ServerSendRpc(toAll: true);
				if (!DoorVariant.DoorsByRoom.TryGetValue(value.Room, out var value2))
				{
					return;
				}
				foreach (DoorVariant item in value2)
				{
					SpawnablesDistributorBase.ServerSpawnForAllDoor(item);
				}
			}
		}

		public event Action OnCameraChanged;

		private void Update()
		{
			if (!_initialized)
			{
				if (!TryGetCurrentCamera(out var _))
				{
					return;
				}
				_initialized = true;
			}
			if (CurClientSwitchState != ClientSwitchState.None && base.Role.IsControllable && !(_switchStopwatch.Elapsed.TotalSeconds < (double)_targetSwitchTime))
			{
				_clientSwitchRequest = ClientSwitchState.None;
				_switchStopwatch.Stop();
				ClientSendCmd();
			}
		}

		private bool TryGetDefaultCamera(out Scp079Camera cam)
		{
			if (_defaultCamId == 0)
			{
				if (Scp079InteractableBase.AllInstances.TryGetFirst((Scp079InteractableBase x) => x is Scp079Camera scp079Camera && x.SyncId != 0 && scp079Camera.Room.Name == RoomName.Hcz079 && scp079Camera.Label.Equals("079 CONT CHAMBER", StringComparison.InvariantCultureIgnoreCase), out var first))
				{
					cam = first as Scp079Camera;
					_defaultCamId = cam.SyncId;
					return true;
				}
				if (Scp079InteractableBase.AllInstances.TryGetFirst((Scp079InteractableBase x) => x is Scp079Camera, out var first2))
				{
					cam = first2 as Scp079Camera;
					_defaultCamId = cam.SyncId;
					return true;
				}
				cam = null;
				return false;
			}
			if (Scp079InteractableBase.TryGetInteractable(_defaultCamId, out Scp079Camera result))
			{
				cam = result;
				return true;
			}
			cam = null;
			return false;
		}

		private void OnHubAdded(ReferenceHub hub)
		{
			if (NetworkServer.active)
			{
				ServerSendRpc(hub);
			}
		}

		public int GetSwitchCost(Scp079Camera target)
		{
			Vector3 position = CurrentCamera.Position;
			Vector3 position2 = target.Position;
			FacilityZone zone = CurrentCamera.Room.Zone;
			FacilityZone zone2 = target.Room.Zone;
			bool flag = Mathf.Abs(position.y - position2.y) < 60f;
			bool flag2 = zone == zone2;
			int num = Mathf.CeilToInt((position - position2).MagnitudeIgnoreY() * 0.16f);
			int num2 = ((!flag) ? 5 : num);
			if (flag2)
			{
				Vector3Int mainCoords = CurrentCamera.Room.MainCoords;
				Vector3Int mainCoords2 = target.Room.MainCoords;
				bool flag3 = (mainCoords - mainCoords2).sqrMagnitude <= 1;
				if (!flag)
				{
					if (!flag3)
					{
						num2 += num;
					}
					return num2;
				}
				if (!flag3)
				{
					return num2;
				}
				return 0;
			}
			int num3 = Mathf.Abs(ZoneQueue.IndexOf(zone) - ZoneQueue.IndexOf(zone2)) - 1;
			return num2 + 10 + 20 * num3;
		}

		public void ClientSwitchTo(Scp079Camera target)
		{
			if (!base.Role.IsControllable)
			{
				throw new InvalidOperationException("Method ClientSwitchTo can only be called on the local client instance!");
			}
			if (CurClientSwitchState == ClientSwitchState.None)
			{
				bool flag = target.Room.Zone == CurrentCamera.Room.Zone;
				_switchTarget = target;
				_targetSwitchTime = (flag ? 0.1f : 0.98f);
				CurClientSwitchState = (flag ? ClientSwitchState.SwitchingRoom : ClientSwitchState.SwitchingZone);
				CurClientTargetZone = target.Room.Zone;
				_clientSwitchRequest = CurClientSwitchState;
				ClientSendCmd();
				_switchStopwatch.Restart();
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			if (NetworkServer.active)
			{
				_eventAssigned = true;
				ReferenceHub.OnPlayerAdded += OnHubAdded;
				(base.Role as Scp079Role).SubroutineModule.TryGetSubroutine<Scp079AuxManager>(out _auxManager);
				(base.Role as Scp079Role).SubroutineModule.TryGetSubroutine<Scp079LostSignalHandler>(out _lostSignalHandler);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (_eventAssigned)
			{
				ReferenceHub.OnPlayerAdded -= OnHubAdded;
			}
			_defaultCamId = 0;
			_errorCode = Scp079HudTranslation.Zoom;
			_lastCam = null;
			_camSet = false;
			_initialized = false;
			_eventAssigned = false;
			CurClientSwitchState = ClientSwitchState.None;
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteByte((byte)_clientSwitchRequest);
			writer.WriteUShort(_switchTarget.SyncId);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			_clientSwitchRequest = (ClientSwitchState)reader.ReadByte();
			_requestedCamId = reader.ReadUShort();
			if (_clientSwitchRequest != ClientSwitchState.None)
			{
				ServerSendRpc((ReferenceHub x) => x.roleManager.CurrentRole is SpectatorRole);
				return;
			}
			if (!Scp079InteractableBase.TryGetInteractable(_requestedCamId, out _switchTarget))
			{
				_errorCode = Scp079HudTranslation.InvalidCamera;
				ServerSendRpc(toAll: true);
				return;
			}
			float num = GetSwitchCost(_switchTarget);
			if (num > _auxManager.CurrentAux)
			{
				_errorCode = Scp079HudTranslation.NotEnoughAux;
				ServerSendRpc(toAll: true);
				return;
			}
			if (_lostSignalHandler.Lost)
			{
				_errorCode = Scp079HudTranslation.SignalLost;
				ServerSendRpc(toAll: true);
				return;
			}
			if (_switchTarget != CurrentCamera)
			{
				Scp079ChangingCameraEventArgs e = new Scp079ChangingCameraEventArgs(base.Owner, _switchTarget);
				Scp079Events.OnChangingCamera(e);
				if (!e.IsAllowed)
				{
					_errorCode = Scp079HudTranslation.SignalLost;
					ServerSendRpc(toAll: true);
					return;
				}
				_switchTarget = e.Camera.Base;
			}
			_auxManager.CurrentAux -= num;
			_errorCode = Scp079HudTranslation.Zoom;
			if (_switchTarget != CurrentCamera)
			{
				CurrentCamera = _switchTarget;
				Scp079Events.OnChangedCamera(new Scp079ChangedCameraEventArgs(base.Owner, _switchTarget));
			}
			else
			{
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_clientSwitchRequest);
			if (_clientSwitchRequest == ClientSwitchState.None)
			{
				writer.WriteUShort(CurrentCamera.SyncId);
				writer.WriteByte((byte)_errorCode);
			}
			else
			{
				writer.WriteUShort(_requestedCamId);
			}
			_errorCode = Scp079HudTranslation.Zoom;
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			CurClientSwitchState = (ClientSwitchState)reader.ReadByte();
			ushort num = reader.ReadUShort();
			bool flag = Scp079InteractableBase.TryGetInteractable(num, out Scp079Camera result);
			switch (CurClientSwitchState)
			{
			case ClientSwitchState.SwitchingRoom:
				return;
			case ClientSwitchState.SwitchingZone:
				if (flag)
				{
					CurClientTargetZone = result.Room.Zone;
				}
				return;
			}
			_errorCode = (Scp079HudTranslation)reader.ReadByte();
			if (_errorCode != Scp079HudTranslation.Zoom)
			{
				if ((base.Role.IsControllable || base.CastRole.IsSpectated) && Scp079AbilityList.TryGetSingleton(out var singleton))
				{
					singleton.TrackedFailMessage = this;
				}
			}
			else if (!NetworkServer.active)
			{
				if (flag)
				{
					CurrentCamera = result;
					return;
				}
				_camSet = false;
				_defaultCamId = num;
			}
		}

		public bool TryGetCurrentCamera(out Scp079Camera cam)
		{
			if (base.Role.Pooled)
			{
				cam = null;
				return false;
			}
			if (_camSet)
			{
				cam = _lastCam;
				return true;
			}
			if (TryGetDefaultCamera(out var cam2))
			{
				cam = cam2;
				CurrentCamera = cam;
				return true;
			}
			cam = null;
			return false;
		}

		public void OnFailMessageAssigned()
		{
			FailMessage = Translations.Get(_errorCode);
		}

		public override void PopulateDummyActions(Action<DummyAction> actionAdder, Action<string> categoryAdder)
		{
			base.PopulateDummyActions(actionAdder, categoryAdder);
			categoryAdder("CameraSwitch");
			foreach (Scp079InteractableBase allInstance in Scp079InteractableBase.AllInstances)
			{
				Scp079Camera cam = allInstance as Scp079Camera;
				if ((object)cam != null)
				{
					actionAdder(new DummyAction($"\"{cam.Label}\" #{cam.SyncId}", () =>
					{
						ClientSwitchTo(cam);
					}));
				}
			}
		}
	}
}

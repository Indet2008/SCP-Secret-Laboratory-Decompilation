using System;
using System.Collections.Generic;
using Mirror;
using PlayerRoles.FirstPersonControl;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class BacktrackerModule : MicroHidModuleBase
	{
		private struct BacktrackPair
		{
			public ReferenceHub Hub;

			public RelativePosition RelPos;

			public BacktrackPair(ReferenceHub hub, RelativePosition pos)
			{
				Hub = hub;
				RelPos = pos;
			}
		}

		private const float TickCooldown = 0.05f;

		private const float WindupWarmupDuration = 0.3f;

		private const float AlwaysIncludeDistSqr = 4f;

		private const float BacktrackExpirationSeconds = 0.5f;

		private const float BacktrackExtraDistance = 4f;

		private float _remainingCooldown;

		private double _lastReceivedMessageTimestamp;

		private FiringModeControllerModule _lastFiringMode;

		private IFpcRole _lastOwnerFpc;

		private RelativePosition _receivedOwnerPosition;

		private Quaternion _receivedOwnerRotation;

		private readonly List<BacktrackPair> _receivedBacktracks = new List<BacktrackPair>();

		private static readonly List<FpcBacktracker> VictimBacktrackers = new List<FpcBacktracker>();

		private void UpdateTick()
		{
			if (!base.MicroHid.CycleController.TryGetLastFiringController(out var ret))
			{
				return;
			}
			switch (base.MicroHid.CycleController.Phase)
			{
			case MicroHidPhase.WoundUpSustain:
			case MicroHidPhase.Firing:
				ClientSendUpdate(ret);
				break;
			case MicroHidPhase.WindingUp:
			{
				float windUpRate = ret.WindUpRate;
				if (!(windUpRate <= 0f) && !((1f - base.MicroHid.CycleController.ServerWindUpProgress) / windUpRate > 0.3f))
				{
					ClientSendUpdate(ret);
				}
				break;
			}
			}
		}

		private void ClientSendUpdate(FiringModeControllerModule firingCtrl)
		{
			if (base.MicroHid.Owner.roleManager.CurrentRole is IFpcRole lastOwnerFpc)
			{
				_lastFiringMode = firingCtrl;
				_lastOwnerFpc = lastOwnerFpc;
				SendCmd(ClientWriteMessage);
			}
		}

		private void ClientWriteMessage(NetworkWriter writer)
		{
			Vector3 position = _lastOwnerFpc.FpcModule.Position;
			RelativePosition msg = new RelativePosition(position);
			Transform playerCameraReference = base.MicroHid.Owner.PlayerCameraReference;
			writer.WriteRelativePosition(msg);
			writer.WriteQuaternion(WaypointBase.GetRelativeRotation(msg.WaypointId, playerCameraReference.rotation));
			float num = _lastFiringMode.FiringRange + 4f;
			float num2 = num * num;
			float backtrackerDot = _lastFiringMode.BacktrackerDot;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.isLocalPlayer && allHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					float num3 = fpcRole.SqrDistanceTo(position);
					if (!(num3 > num2) && (num3 <= 4f || fpcRole.GetDot(playerCameraReference) <= backtrackerDot))
					{
						writer.WriteReferenceHub(allHub);
						writer.WriteRelativePosition(new RelativePosition(fpcRole));
					}
				}
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsLocalPlayer)
			{
				_remainingCooldown -= Time.deltaTime;
				if (!(_remainingCooldown > 0f))
				{
					UpdateTick();
					_remainingCooldown = 0.05f;
				}
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			_receivedBacktracks.Clear();
			_receivedOwnerPosition = reader.ReadRelativePosition();
			_receivedOwnerRotation = reader.ReadQuaternion();
			while (reader.Remaining > 0)
			{
				bool num = reader.TryReadReferenceHub(out var hub);
				RelativePosition pos = reader.ReadRelativePosition();
				if (num)
				{
					_receivedBacktracks.Add(new BacktrackPair(hub, pos));
				}
			}
			_lastReceivedMessageTimestamp = NetworkTime.time;
		}

		public void BacktrackAll(Action callback)
		{
			if (NetworkTime.time - _lastReceivedMessageTimestamp > 0.5 || !WaypointBase.TryGetWaypoint(_receivedOwnerPosition.WaypointId, out var wp))
			{
				callback?.Invoke();
				return;
			}
			Vector3 worldspacePosition = wp.GetWorldspacePosition(_receivedOwnerPosition.Relative);
			Quaternion worldspaceRotation = wp.GetWorldspaceRotation(_receivedOwnerRotation);
			using (new FpcBacktracker(base.MicroHid.Owner, worldspacePosition, worldspaceRotation))
			{
				foreach (BacktrackPair receivedBacktrack in _receivedBacktracks)
				{
					List<FpcBacktracker> victimBacktrackers = VictimBacktrackers;
					ReferenceHub hub = receivedBacktrack.Hub;
					RelativePosition relPos = receivedBacktrack.RelPos;
					victimBacktrackers.Add(new FpcBacktracker(hub, relPos.Position));
				}
				callback?.Invoke();
				foreach (FpcBacktracker victimBacktracker in VictimBacktrackers)
				{
					victimBacktracker.RestorePosition();
				}
				VictimBacktrackers.Clear();
			}
		}
	}
}

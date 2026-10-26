using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using MapGeneration;
using Mirror;
using NorthwoodLib.Pools;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079ScannerSequence
	{
		private enum ScanSequenceStep
		{
			Init = 0,
			CountingDown = 1,
			ScanningFindNewTarget = 2,
			ScanningFailedCooldown = 3,
			ScanningUpdateTarget = 4
		}

		private enum TrackerMessage
		{
			None = 0,
			ScannerDisabled = 1,
			ScanTimeSync = 2,
			ScanNoResults = 3,
			ScanSuccessful = 4
		}

		private const float TotalCountdownTime = 20f;

		private const float AddZonesDuringCooldownPenalty = 4f;

		private const float ScanningTime = 3.2f;

		private const float ScannedEffectDuration = 7.5f;

		private readonly Scp079ScannerMenuToggler _menuToggler;

		private readonly Scp079ScannerZoneSelector _zoneSelector;

		private readonly Scp079ScannerTeamFilterSelector _teamSelector;

		private readonly Scp079ScannerTracker _tracker;

		private int _prevZonesCnt;

		private int _detectedPlayer;

		private double _nextScanTime;

		private double _scanCompleteTime;

		private bool _wasEnabled;

		private Team[] _teamsToDetect;

		private FacilityZone[] _zonesToDetect;

		private ScanSequenceStep _curStep;

		private TrackerMessage _rpcToSend;

		public bool SequencePaused { get; private set; }

		public float RemainingTime => (float)(_nextScanTime - NetworkTime.time);

		private bool ScanningPossible
		{
			get
			{
				if (_menuToggler.IsUnlocked && _zoneSelector.SelectedZonesCnt > 0)
				{
					return _teamSelector.AnySelected;
				}
				return false;
			}
		}

		private Scp079ScannerTrackedPlayer[] TrackedPlayers => _tracker.TrackedPlayers;

		private TrackerMessage UpdateSequence()
		{
			double time = NetworkTime.time;
			switch (_curStep)
			{
			case ScanSequenceStep.Init:
				if (!ScanningPossible)
				{
					if (!_wasEnabled)
					{
						return TrackerMessage.None;
					}
					_wasEnabled = false;
					return TrackerMessage.ScannerDisabled;
				}
				_nextScanTime = time + 20.0;
				_prevZonesCnt = _zoneSelector.SelectedZonesCnt;
				_wasEnabled = true;
				_curStep = ScanSequenceStep.CountingDown;
				return TrackerMessage.ScanTimeSync;
			case ScanSequenceStep.CountingDown:
			{
				if (time >= _nextScanTime)
				{
					_teamsToDetect = _teamSelector.SelectedTeams;
					_zonesToDetect = _zoneSelector.SelectedZones;
					_curStep = ScanSequenceStep.ScanningFindNewTarget;
					return TrackerMessage.None;
				}
				if (!ScanningPossible)
				{
					_curStep = ScanSequenceStep.Init;
					return TrackerMessage.None;
				}
				int selectedZonesCnt = _zoneSelector.SelectedZonesCnt;
				int prevZonesCnt = _prevZonesCnt;
				_prevZonesCnt = selectedZonesCnt;
				if (selectedZonesCnt <= prevZonesCnt)
				{
					return TrackerMessage.None;
				}
				_nextScanTime = Math.Min(time + 20.0, _nextScanTime + 4.0);
				return TrackerMessage.ScanTimeSync;
			}
			case ScanSequenceStep.ScanningFindNewTarget:
			{
				List<int> list = ListPool<int>.Shared.Rent();
				for (int i = 0; i < TrackedPlayers.Length; i++)
				{
					Scp079ScannerTrackedPlayer scp079ScannerTrackedPlayer2 = TrackedPlayers[i];
					if (scp079ScannerTrackedPlayer2 != null && scp079ScannerTrackedPlayer2.IsCamping && _zonesToDetect.Contains(scp079ScannerTrackedPlayer2.LastZone) && _teamsToDetect.Contains(scp079ScannerTrackedPlayer2.Hub.GetTeam()))
					{
						list.Add(i);
					}
				}
				_scanCompleteTime = time + 3.200000047683716;
				if (list.Count == 0)
				{
					_curStep = ScanSequenceStep.ScanningFailedCooldown;
				}
				else
				{
					_detectedPlayer = list.RandomItem();
					ListPool<int>.Shared.Return(list);
					TrackedPlayers[_detectedPlayer].Hub.playerEffectsController.EnableEffect<Scanned>(7.5f);
					_curStep = ScanSequenceStep.ScanningUpdateTarget;
				}
				return TrackerMessage.None;
			}
			case ScanSequenceStep.ScanningFailedCooldown:
				if (time < _scanCompleteTime)
				{
					return TrackerMessage.None;
				}
				_curStep = ScanSequenceStep.Init;
				return TrackerMessage.ScanNoResults;
			case ScanSequenceStep.ScanningUpdateTarget:
			{
				Scp079ScannerTrackedPlayer scp079ScannerTrackedPlayer = TrackedPlayers[_detectedPlayer];
				if (scp079ScannerTrackedPlayer != null && scp079ScannerTrackedPlayer.LastZone != FacilityZone.Other)
				{
					if (time < _scanCompleteTime)
					{
						return TrackerMessage.None;
					}
					_curStep = ScanSequenceStep.Init;
					return TrackerMessage.ScanSuccessful;
				}
				goto case ScanSequenceStep.ScanningFindNewTarget;
			}
			default:
				return TrackerMessage.None;
			}
		}

		public Scp079ScannerSequence(Scp079Role role)
		{
			SequencePaused = true;
			role.SubroutineModule.TryGetSubroutine<Scp079ScannerMenuToggler>(out _menuToggler);
			role.SubroutineModule.TryGetSubroutine<Scp079ScannerZoneSelector>(out _zoneSelector);
			role.SubroutineModule.TryGetSubroutine<Scp079ScannerTeamFilterSelector>(out _teamSelector);
			role.SubroutineModule.TryGetSubroutine<Scp079ScannerTracker>(out _tracker);
		}

		public void ServerUpdate(out bool rpcRequested)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Breach Scanner sequence can only be updated by the server!");
			}
			TrackerMessage trackerMessage = UpdateSequence();
			rpcRequested = trackerMessage != TrackerMessage.None;
			if (rpcRequested)
			{
				_rpcToSend = trackerMessage;
			}
		}

		public void WriteRpc(NetworkWriter writer)
		{
			writer.WriteByte((byte)_rpcToSend);
			switch (_rpcToSend)
			{
			case TrackerMessage.ScanNoResults:
				writer.WriteByte((byte)(ScanningPossible ? 20f : 0f));
				break;
			case TrackerMessage.ScanTimeSync:
				writer.WriteDouble(_nextScanTime);
				break;
			case TrackerMessage.ScanSuccessful:
			{
				Scp079ScannerTrackedPlayer scp079ScannerTrackedPlayer = TrackedPlayers[_detectedPlayer];
				Vector3 vector = RoomUtils.CoordsToCenterPos(RoomUtils.PositionToCoords(scp079ScannerTrackedPlayer.PlyPos));
				Vector3 targetPos = new Vector3(vector.x, scp079ScannerTrackedPlayer.PlyPos.y, vector.z);
				writer.WriteReferenceHub(scp079ScannerTrackedPlayer.Hub);
				writer.WriteByte(20);
				writer.WriteRelativePosition(new RelativePosition(targetPos));
				break;
			}
			}
		}

		public void ReadRpc(NetworkReader reader)
		{
			switch ((TrackerMessage)reader.ReadByte())
			{
			case TrackerMessage.ScannerDisabled:
				SequencePaused = true;
				break;
			case TrackerMessage.ScanTimeSync:
				SequencePaused = false;
				_nextScanTime = reader.ReadDouble();
				break;
			case TrackerMessage.ScanNoResults:
				_tracker.ClientProcessScanResult(null, reader.ReadByte(), null);
				break;
			case TrackerMessage.ScanSuccessful:
				_tracker.ClientProcessScanResult(reader.ReadReferenceHub(), reader.ReadByte(), reader);
				break;
			}
		}
	}
}

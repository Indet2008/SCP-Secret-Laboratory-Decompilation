using System;
using System.Collections.Generic;
using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;
using UnityEngine.Rendering;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079Nightvision : Scp079GuiElementBase
	{
		[Serializable]
		private struct ZoneNightvisionPair
		{
			public Volume PostProcess;

			public FacilityZone Zone;
		}

		[SerializeField]
		private ZoneNightvisionPair[] _pairs;

		private Scp079CurrentCameraSync _curCam;

		private Scp079LostSignalHandler _lostSignal;

		private readonly HashSet<Volume> _volumes = new HashSet<Volume>();

		private readonly Dictionary<FacilityZone, Volume> _zoneTargets = new Dictionary<FacilityZone, Volume>();

		private Volume TargetVolume
		{
			get
			{
				if (_curCam.CurClientSwitchState != Scp079CurrentCameraSync.ClientSwitchState.None)
				{
					return null;
				}
				if (_lostSignal.Lost)
				{
					return null;
				}
				Scp079Camera currentCamera = base.Role.CurrentCamera;
				if (currentCamera == null)
				{
					return null;
				}
				if (!RoomLightController.IsInDarkenedRoom(currentCamera.Position))
				{
					return null;
				}
				if (!_zoneTargets.TryGetValue(currentCamera.Room.Zone, out var value))
				{
					return null;
				}
				return value;
			}
		}

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCam);
			role.SubroutineModule.TryGetSubroutine<Scp079LostSignalHandler>(out _lostSignal);
			_curCam.OnCameraChanged += UpdateAll;
			ZoneNightvisionPair[] pairs = _pairs;
			for (int i = 0; i < pairs.Length; i++)
			{
				ZoneNightvisionPair zoneNightvisionPair = pairs[i];
				_volumes.Add(zoneNightvisionPair.PostProcess);
				_zoneTargets[zoneNightvisionPair.Zone] = zoneNightvisionPair.PostProcess;
			}
			UpdateAll();
		}

		private void OnDestroy()
		{
			if (!(_curCam == null))
			{
				_curCam.OnCameraChanged -= UpdateAll;
			}
		}

		private void Update()
		{
			UpdateAll();
		}

		private void UpdateAll()
		{
			Volume target = TargetVolume;
			_volumes.ForEach((Volume x) =>
			{
				x.enabled = x == target;
			});
		}
	}
}

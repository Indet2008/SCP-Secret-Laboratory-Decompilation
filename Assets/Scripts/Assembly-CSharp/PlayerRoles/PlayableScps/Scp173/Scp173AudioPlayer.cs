using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.Scp173Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173AudioPlayer : SubroutineBase
	{
		[Serializable]
		private class Scp173Sound
		{
			public Scp173SoundId Id;

			public float MaxDistance;
		}

		public enum Scp173SoundId : byte
		{
			Hit = 0,
			Teleport = 1,
			Snap = 2
		}

		[SerializeField]
		private Scp173Sound[] _sounds;

		private byte _soundToSend;

		private Vector3 _lastPos;

		private static bool _soundsDictionarized = false;

		private static readonly Dictionary<byte, Scp173Sound> Sounds = new Dictionary<byte, Scp173Sound>();

		protected override void Awake()
		{
			base.Awake();
			if (!_soundsDictionarized)
			{
				Scp173Sound[] sounds = _sounds;
				foreach (Scp173Sound scp173Sound in sounds)
				{
					Sounds.Add((byte)scp173Sound.Id, scp173Sound);
				}
				_soundsDictionarized = true;
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte(_soundToSend);
			writer.WriteRelativePosition(new RelativePosition(_lastPos));
		}

		public void ServerSendSound(Scp173SoundId soundId)
		{
			bool flag = base.Role.TryGetOwner(out var hub);
			if (flag)
			{
				Scp173PlayingSoundEventArgs e = new Scp173PlayingSoundEventArgs(hub, soundId);
				Scp173Events.OnPlayingSound(e);
				if (!e.IsAllowed)
				{
					return;
				}
				soundId = e.SoundId;
			}
			_soundToSend = (byte)soundId;
			_lastPos = (base.Role as Scp173Role).FpcModule.Position;
			if (Sounds.TryGetValue(_soundToSend, out var value))
			{
				float disSqr = value.MaxDistance * value.MaxDistance;
				ServerSendRpc((ReferenceHub x) => !(x.roleManager.CurrentRole is IFpcRole fpcRole) || (fpcRole.FpcModule.Position - _lastPos).sqrMagnitude <= disSqr);
				if (flag)
				{
					Scp173Events.OnPlayedSound(new Scp173PlayedSoundEventArgs(hub, soundId));
				}
			}
		}
	}
}

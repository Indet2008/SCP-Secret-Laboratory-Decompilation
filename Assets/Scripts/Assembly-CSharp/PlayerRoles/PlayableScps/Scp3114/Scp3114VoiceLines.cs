using System;
using System.Collections.Generic;
using MapGeneration;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;
using UserSettings;
using UserSettings.AudioSettings;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114VoiceLines : StandardSubroutine<Scp3114Role>
	{
		[Serializable]
		private class VoiceLinesDefinition
		{
			public VoiceLinesName Label;

			public AudioClip[] RandomClips;

			public float MinIdleTime;

			public float MaxDuration;

			[Range(0f, 1f)]
			public float Chance;

			private double _lastUse;

			private List<int> _order;

			private int _lastIndex;

			public float LastUseElapsedSeconds => (float)(NetworkTime.time - _lastUse - (double)MaxDuration);

			public bool TryDrawNext(out ushort clipId)
			{
				if (UnityEngine.Random.value > Chance)
				{
					clipId = 0;
					return false;
				}
				_lastUse = NetworkTime.time;
				_lastIndex++;
				clipId = (ushort)_lastIndex;
				return true;
			}

			public AudioClip GetClip(int index)
			{
				return RandomClips[_order[index % _order.Count]];
			}

			public void Init()
			{
				_lastUse = 0.0;
				if (_order == null)
				{
					_order = new List<int>(RandomClips.Length);
				}
				_order.Add(0);
			}

			public void Randomize(int seed)
			{
				_order.Clear();
				for (int i = 0; i < RandomClips.Length; i++)
				{
					_order.Add(i);
				}
				_order.ShuffleList(new System.Random(seed));
			}
		}

		private enum VoiceLinesName
		{
			KillSlap = 0,
			KillStrangle = 1,
			Slap = 2,
			RandomIdle = 3,
			Reveal = 4,
			EquipStart = 5,
			StartStrangle = 6
		}

		private static readonly CachedUserSetting<float> VolumeSetting = new CachedUserSetting<float>(MixerAudioSettings.VolumeSliderSetting.Scp3114Voice);

		[SerializeField]
		private VoiceLinesDefinition[] _voiceLines;

		[SerializeField]
		private AudioSource _source;

		[SerializeField]
		private float _idleCycleTime;

		private float _idleRemaining;

		private byte _syncName;

		private ushort _syncId;

		private bool _hasDisguise;

		private bool _randomized;

		protected override void Awake()
		{
			base.Awake();
			_voiceLines.ForEach((VoiceLinesDefinition x) =>
			{
				x.Init();
			});
			base.CastRole.CurIdentity.OnStatusChanged += OnStatusChanged;
			GetSubroutine<Scp3114Slap>(out var sr);
			sr.ServerOnHit += () =>
			{
				ServerPlayConditionally(VoiceLinesName.Slap);
			};
			sr.ServerOnKill += () =>
			{
				ServerPlayConditionally(VoiceLinesName.KillSlap);
			};
			GetSubroutine<Scp3114Strangle>(out var sr2);
			sr2.ServerOnBegin += () =>
			{
				ServerPlayConditionally(VoiceLinesName.StartStrangle);
			};
			sr2.ServerOnKill += () =>
			{
				ServerPlayConditionally(VoiceLinesName.KillStrangle);
			};
		}

		private void OnStatusChanged()
		{
			switch (base.CastRole.CurIdentity.Status)
			{
			case Scp3114Identity.DisguiseStatus.Active:
				_hasDisguise = true;
				_idleRemaining = _idleCycleTime;
				break;
			case Scp3114Identity.DisguiseStatus.Equipping:
				ServerPlayConditionally(VoiceLinesName.EquipStart);
				break;
			case Scp3114Identity.DisguiseStatus.None:
				if (_hasDisguise)
				{
					_hasDisguise = false;
					ServerPlayConditionally(VoiceLinesName.Reveal);
				}
				break;
			}
		}

		private void Update()
		{
			if (!_randomized)
			{
				RandomizeWhenReady();
			}
			if (NetworkServer.active && !_hasDisguise)
			{
				_idleRemaining -= Time.deltaTime;
				if (!(_idleRemaining > 0f))
				{
					_idleRemaining = _idleCycleTime;
					ServerPlayConditionally(VoiceLinesName.RandomIdle);
				}
			}
		}

		private void RandomizeWhenReady()
		{
			if (SeedSynchronizer.MapGenerated)
			{
				int seed = SeedSynchronizer.Seed + (int)base.Owner.netId;
				_voiceLines.ForEach((VoiceLinesDefinition x) =>
				{
					x.Randomize(seed);
				});
				_randomized = true;
			}
		}

		private void ServerPlayConditionally(VoiceLinesName lineToPlay)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			VoiceLinesDefinition voiceLinesDefinition = null;
			float num = float.PositiveInfinity;
			VoiceLinesDefinition[] voiceLines = _voiceLines;
			foreach (VoiceLinesDefinition voiceLinesDefinition2 in voiceLines)
			{
				num = Mathf.Min(num, voiceLinesDefinition2.LastUseElapsedSeconds);
				if (voiceLinesDefinition2.Label == lineToPlay)
				{
					voiceLinesDefinition = voiceLinesDefinition2;
				}
			}
			if (voiceLinesDefinition != null && !(voiceLinesDefinition.MinIdleTime > num) && voiceLinesDefinition.TryDrawNext(out var clipId))
			{
				_syncName = (byte)lineToPlay;
				_syncId = clipId;
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte(_syncName);
			writer.WriteUShort(_syncId);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncName = reader.ReadByte();
			_syncId = reader.ReadUShort();
			VoiceLinesDefinition[] voiceLines = _voiceLines;
			foreach (VoiceLinesDefinition voiceLinesDefinition in voiceLines)
			{
				if ((byte)voiceLinesDefinition.Label == _syncName)
				{
					if (_source.isPlaying)
					{
						_source.Stop();
					}
					_source.PlayOneShot(voiceLinesDefinition.GetClip(_syncId), VolumeSetting.Value);
					break;
				}
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_randomized = false;
			if (NetworkServer.active)
			{
				_hasDisguise = false;
				_idleRemaining = _idleCycleTime;
			}
		}
	}
}

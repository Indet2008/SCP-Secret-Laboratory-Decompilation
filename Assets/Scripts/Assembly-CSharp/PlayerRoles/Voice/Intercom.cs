using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using GameCore;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using Utils.NonAllocLINQ;
using VoiceChat;

namespace PlayerRoles.Voice
{
	public class Intercom : NetworkBehaviour
	{
		private static Intercom _singleton;

		private static bool _singletonSet;

		private readonly Stopwatch _sustain = new Stopwatch();

		private readonly Stopwatch _clipSw = Stopwatch.StartNew();

		private readonly HashSet<ReferenceHub> _adminOverrides = new HashSet<ReferenceHub>();

		private ReferenceHub _curSpeaker;

		private float _cooldownTime;

		private float _speechTime;

		private float _rangeSqr;

		private Vector3 _worldPos;

		[SerializeField]
		private float _range;

		[SerializeField]
		private float _wakeupTime;

		[SerializeField]
		private float _sustainTime;

		[SerializeField]
		private AudioClip _startClip;

		[SerializeField]
		private AudioClip _endClip;

		[SerializeField]
		private AudioSource _clipSource;

		[SerializeField]
		private float _clipCooldown;

		[SyncVar]
		private byte _state;

		[SyncVar]
		private double _nextTime;

		private Func<ReferenceHub, bool> _checkPlayer;

		public static IntercomState State
		{
			get
			{
				if (_singletonSet)
				{
					return (IntercomState)_singleton._state;
				}
				return IntercomState.NotFound;
			}
			set
			{
				if (!_singletonSet || !NetworkServer.active)
				{
					return;
				}
				Intercom singleton = _singleton;
				switch (value)
				{
				case IntercomState.InUse:
					singleton.Network_nextTime = NetworkTime.time + (double)singleton._speechTime;
					break;
				case IntercomState.Starting:
					singleton.Network_nextTime = NetworkTime.time + (double)singleton._wakeupTime;
					OnServerBeginUsage?.Invoke(singleton._curSpeaker);
					singleton.RpcPlayClip(state: true);
					break;
				case IntercomState.Cooldown:
					singleton.RpcPlayClip(state: false);
					if (singleton._curSpeaker != null && singleton._curSpeaker.serverRoles.BypassMode)
					{
						singleton.Network_nextTime = 0.0;
					}
					else
					{
						singleton.Network_nextTime = NetworkTime.time + (double)singleton._cooldownTime;
					}
					break;
				}
				singleton.Network_state = (byte)value;
			}
		}

		public float RemainingTime => Mathf.Max((float)(_nextTime - NetworkTime.time), 0f);

		public bool BypassMode
		{
			get
			{
				if (State == IntercomState.InUse)
				{
					return _nextTime == 0.0;
				}
				return false;
			}
		}

		public byte Network_state
		{
			get
			{
				return _state;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _state, 1uL, null);
			}
		}

		public double Network_nextTime
		{
			get
			{
				return _nextTime;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _nextTime, 2uL, null);
			}
		}

		public static event Action<ReferenceHub> OnServerBeginUsage;

		private void Start()
		{
			if (_singletonSet)
			{
				throw new InvalidOperationException("Multiple instances of Intercom detected. Last name: '" + base.name + "'");
			}
			_singleton = this;
			_singletonSet = true;
			_checkPlayer = CheckPlayer;
			ConfigFile.OnConfigReloaded = (Action)Delegate.Combine(ConfigFile.OnConfigReloaded, new Action(ReloadConfigs));
			SeedSynchronizer.OnGenerationFinished += SetupPos;
			ReloadConfigs();
			if (SeedSynchronizer.MapGenerated)
			{
				SetupPos();
			}
		}

		private void Update()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			switch (State)
			{
			case IntercomState.Ready:
			{
				if (ReferenceHub.AllHubs.TryGetFirst(_checkPlayer, out var first))
				{
					_curSpeaker = first;
					State = IntercomState.Starting;
				}
				break;
			}
			case IntercomState.Starting:
				if (!(_nextTime > NetworkTime.time))
				{
					_sustain.Restart();
					State = IntercomState.InUse;
				}
				break;
			case IntercomState.InUse:
			{
				bool flag;
				if (_curSpeaker != null && CheckPlayer(_curSpeaker))
				{
					flag = true;
					_sustain.Restart();
				}
				else
				{
					flag = _sustain.Elapsed.TotalSeconds < (double)_sustainTime;
				}
				if (!flag || (!(_nextTime > NetworkTime.time) && _nextTime != 0.0))
				{
					State = IntercomState.Cooldown;
					PlayerEvents.OnUsedIntercom(new PlayerUsedIntercomEventArgs(_curSpeaker, State));
				}
				break;
			}
			case IntercomState.Cooldown:
				if (!(_nextTime > NetworkTime.time))
				{
					State = IntercomState.Ready;
				}
				break;
			}
		}

		private void OnDestroy()
		{
			ConfigFile.OnConfigReloaded = (Action)Delegate.Remove(ConfigFile.OnConfigReloaded, new Action(ReloadConfigs));
			SeedSynchronizer.OnGenerationFinished -= SetupPos;
			_singletonSet = false;
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.green;
			Gizmos.DrawWireSphere(base.transform.position, _range);
		}

		private void SetupPos()
		{
			_worldPos = base.transform.position;
			_rangeSqr = _range * _range;
		}

		private void ReloadConfigs()
		{
			_cooldownTime = ConfigFile.ServerConfig.GetFloat("intercom_cooldown", 120f);
			_speechTime = ConfigFile.ServerConfig.GetFloat("intercom_max_speech_time", 20f);
		}

		private bool CheckRange(ReferenceHub hub)
		{
			if (hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				return (fpcRole.FpcModule.Position - _worldPos).sqrMagnitude < _rangeSqr;
			}
			return false;
		}

		private bool CheckPlayer(ReferenceHub hub)
		{
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (!CheckRange(hub) || !hub.IsHuman() || !(currentRole as IVoiceRole).VoiceModule.ServerIsSending || VoiceChatMutes.IsMuted(hub, checkIntercom: true))
			{
				return false;
			}
			PlayerUsingIntercomEventArgs e = new PlayerUsingIntercomEventArgs(hub, State);
			PlayerEvents.OnUsingIntercom(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			return true;
		}

		[ClientRpc]
		private void RpcPlayClip(bool state)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteBool(state);
			SendRPCInternal("System.Void PlayerRoles.Voice.Intercom::RpcPlayClip(System.Boolean)", -1505159510, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public static bool CheckPerms(ReferenceHub hub)
		{
			if (!_singletonSet)
			{
				return false;
			}
			if (VoiceChatMutes.IsMuted(hub, checkIntercom: true))
			{
				return false;
			}
			bool flag = State == IntercomState.InUse;
			if (!HasOverride(hub))
			{
				if (flag && _singleton.CheckRange(hub))
				{
					return _singleton._curSpeaker == hub;
				}
				return false;
			}
			return true;
		}

		public static bool HasOverride(ReferenceHub hub)
		{
			return _singleton._adminOverrides.Contains(hub);
		}

		public static bool TrySetOverride(ReferenceHub ply, bool newState)
		{
			if (!_singletonSet || ply == null)
			{
				return false;
			}
			HashSet<ReferenceHub> adminOverrides = _singleton._adminOverrides;
			if (!newState)
			{
				return adminOverrides.Remove(ply);
			}
			adminOverrides.Add(ply);
			return true;
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlayClip__Boolean(bool state)
		{
			if (!(_clipSw.Elapsed.TotalSeconds < (double)_clipCooldown))
			{
				_clipSource.PlayOneShot(state ? _startClip : _endClip);
				_clipSw.Restart();
			}
		}

		protected static void InvokeUserCode_RpcPlayClip__Boolean(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				UnityEngine.Debug.LogError("RPC RpcPlayClip called on server.");
			}
			else
			{
				((Intercom)obj).UserCode_RpcPlayClip__Boolean(reader.ReadBool());
			}
		}

		static Intercom()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(Intercom), "System.Void PlayerRoles.Voice.Intercom::RpcPlayClip(System.Boolean)", InvokeUserCode_RpcPlayClip__Boolean);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				NetworkWriterExtensions.WriteByte(writer, _state);
				writer.WriteDouble(_nextTime);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _state);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteDouble(_nextTime);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _state, null, NetworkReaderExtensions.ReadByte(reader));
				GeneratedSyncVarDeserialize(ref _nextTime, null, reader.ReadDouble());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _state, null, NetworkReaderExtensions.ReadByte(reader));
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _nextTime, null, reader.ReadDouble());
			}
		}
	}
}

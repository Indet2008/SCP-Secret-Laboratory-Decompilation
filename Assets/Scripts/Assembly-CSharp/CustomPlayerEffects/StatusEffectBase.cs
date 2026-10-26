using System;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using PlayerRoles.Spectating;
using UnityEngine;

namespace CustomPlayerEffects
{
	public abstract class StatusEffectBase : MonoBehaviour, IEquatable<StatusEffectBase>
	{
		public enum EffectClassification
		{
			Technical = 0,
			Negative = 1,
			Mixed = 2,
			Positive = 3
		}

		private byte _intensity;

		private float _duration;

		private float _timeLeft;

		public byte Intensity
		{
			get
			{
				return _intensity;
			}
			set
			{
				if (value <= _intensity || AllowEnabling)
				{
					ForceIntensity(value);
				}
			}
		}

		public virtual byte MaxIntensity { get; } = byte.MaxValue;

		public bool IsEnabled
		{
			get
			{
				return Intensity > 0;
			}
			set
			{
				if (value != IsEnabled)
				{
					Intensity = (byte)(value ? 1 : 0);
				}
			}
		}

		public virtual bool AllowEnabling
		{
			get
			{
				if (Classification != EffectClassification.Negative)
				{
					return true;
				}
				if (!SpawnProtected.CheckPlayer(Hub))
				{
					return !Vitality.CheckPlayer(Hub);
				}
				return false;
			}
		}

		public virtual EffectClassification Classification => EffectClassification.Negative;

		public bool IsLocalPlayer => Hub.isLocalPlayer;

		public bool IsSpectated => Hub.IsLocallySpectated();

		public bool IsPOV => Hub.IsPOV;

		public float Duration
		{
			get
			{
				return _duration;
			}
			private set
			{
				_duration = Mathf.Max(0f, value);
			}
		}

		public float TimeLeft
		{
			get
			{
				return _timeLeft;
			}
			set
			{
				_timeLeft = Mathf.Max(0f, value);
				if (_timeLeft == 0f && Duration != 0f)
				{
					DisableEffect();
				}
			}
		}

		public ReferenceHub Hub { get; private set; }

		public static event Action<StatusEffectBase> OnEnabled;

		public static event Action<StatusEffectBase> OnDisabled;

		public static event Action<StatusEffectBase, byte, byte> OnIntensityChanged;

		[Server]
		public void ServerSetState(byte intensity, float duration = 0f, bool addDuration = false)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CustomPlayerEffects.StatusEffectBase::ServerSetState(System.Byte,System.Single,System.Boolean)' called when server was not active");
				return;
			}
			Intensity = intensity;
			ServerChangeDuration(duration, addDuration);
		}

		[Server]
		public void ServerDisable()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CustomPlayerEffects.StatusEffectBase::ServerDisable()' called when server was not active");
			}
			else
			{
				DisableEffect();
			}
		}

		[Server]
		public void ServerChangeDuration(float duration, bool addDuration = false)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void CustomPlayerEffects.StatusEffectBase::ServerChangeDuration(System.Single,System.Boolean)' called when server was not active");
			}
			else if (addDuration && duration > 0f)
			{
				Duration += duration;
				TimeLeft += duration;
			}
			else
			{
				Duration = duration;
				TimeLeft = Duration;
			}
		}

		public void ForceIntensity(byte value)
		{
			if (_intensity == value)
			{
				return;
			}
			byte intensity = _intensity;
			bool active = NetworkServer.active;
			bool flag = intensity == 0 && value > 0;
			if (active)
			{
				PlayerEffectUpdatingEventArgs e = new PlayerEffectUpdatingEventArgs(Hub, this, value, Duration);
				PlayerEvents.OnUpdatingEffect(e);
				if (!e.IsAllowed)
				{
					return;
				}
				value = e.Intensity;
				Duration = e.Duration;
			}
			_intensity = (byte)Mathf.Min(value, MaxIntensity);
			if (active)
			{
				Hub.playerEffectsController.ServerSyncEffect(this);
				PlayerEvents.OnUpdatedEffect(new PlayerEffectUpdatedEventArgs(Hub, this, value, Duration));
			}
			if (flag)
			{
				Enabled();
				OnEnabled?.Invoke(this);
			}
			else if (intensity > 0 && value == 0)
			{
				Disabled();
				OnDisabled?.Invoke(this);
			}
			IntensityChanged(intensity, value);
			OnIntensityChanged?.Invoke(this, intensity, value);
		}

		protected virtual void Awake()
		{
			Hub = ReferenceHub.GetHub(base.transform.root.gameObject);
		}

		protected virtual void Start()
		{
		}

		protected virtual void Update()
		{
			if (IsEnabled)
			{
				RefreshTime();
				OnEffectUpdate();
			}
		}

		private void RefreshTime()
		{
			if (Duration != 0f)
			{
				TimeLeft -= Time.deltaTime;
			}
		}

		protected virtual void Enabled()
		{
		}

		protected virtual void Disabled()
		{
		}

		protected virtual void OnEffectUpdate()
		{
		}

		protected virtual void IntensityChanged(byte prevState, byte newState)
		{
		}

		public virtual void OnBeginSpectating()
		{
		}

		public virtual void OnStopSpectating()
		{
		}

		internal virtual void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			DisableEffect();
		}

		internal virtual void OnDeath(PlayerRoleBase previousRole)
		{
			DisableEffect();
		}

		protected virtual void DisableEffect()
		{
			if (NetworkServer.active)
			{
				Duration = 0f;
				Intensity = 0;
			}
		}

		public bool Equals(StatusEffectBase other)
		{
			if (other != null)
			{
				return other.gameObject == base.gameObject;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj == null)
			{
				return false;
			}
			if (this == obj)
			{
				return true;
			}
			if (obj.GetType() != GetType())
			{
				return false;
			}
			return Equals((StatusEffectBase)obj);
		}

		public override int GetHashCode()
		{
			return base.gameObject.GetHashCode();
		}
	}
}

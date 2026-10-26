using System;
using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

namespace MapGeneration.Decoration
{
	public class EnvironmentalAlarmSync : NetworkBehaviour
	{
		[HideInInspector]
		[SyncVar(hook = "HandleActivityChanged")]
		public bool IsEnabled;

		private EnvironmentalAlarm _targetAlarm;

		private float _timeLeft;

		public float TimeLeft
		{
			get
			{
				return _timeLeft;
			}
			set
			{
				if (_timeLeft != value)
				{
					_timeLeft = Mathf.Max(value, 0f);
				}
			}
		}

		public bool NetworkIsEnabled
		{
			get
			{
				return IsEnabled;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref IsEnabled, 1uL, HandleActivityChanged);
			}
		}

		public void ServerTriggerAlarm(float duration)
		{
			TimeLeft += duration;
		}

		private void Start()
		{
			if (!TryGetComponent<EnvironmentalAlarm>(out _targetAlarm))
			{
				throw new NullReferenceException();
			}
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				ProcessActivity();
			}
		}

		private void ProcessActivity()
		{
			TimeLeft -= Time.deltaTime;
			NetworkIsEnabled = TimeLeft > 0f;
		}

		private void HandleActivityChanged(bool oldValue, bool newValue)
		{
			_targetAlarm.IsEnabled = newValue;
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteBool(IsEnabled);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteBool(IsEnabled);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref IsEnabled, HandleActivityChanged, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref IsEnabled, HandleActivityChanged, reader.ReadBool());
			}
		}
	}
}

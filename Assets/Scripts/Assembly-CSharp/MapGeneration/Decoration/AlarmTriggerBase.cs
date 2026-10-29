using System;
using Mirror;
using UnityEngine;

namespace MapGeneration.Decoration
{
	public abstract class AlarmTriggerBase : MonoBehaviour
	{
		protected static readonly int MaxTriggerMeters = 20;

		private bool _hasRoom;

		protected RoomIdentifier CurrentRoom { get; private set; }

		protected EnvironmentalAlarmSync TargetAlarm { get; private set; }

		protected abstract float Duration { get; }

		protected Vector3 RoomPosition
		{
			get
			{
				if (!_hasRoom || CurrentRoom == null)
				{
					return base.transform.position;
				}
				return CurrentRoom.transform.position;
			}
		}

		protected virtual void ServerTriggerAlarm(float? customDuration = null)
		{
			float duration = Duration;
			if (customDuration.HasValue)
			{
				duration = customDuration.Value;
			}
			TargetAlarm.ServerTriggerAlarm(duration);
		}

		protected virtual void Start()
		{
			if (NetworkServer.active)
			{
				if (!TryGetComponent<EnvironmentalAlarmSync>(out var component))
				{
					throw new NullReferenceException();
				}
				TargetAlarm = component;
				if (base.transform.position.TryGetRoom(out var room))
				{
					_hasRoom = true;
					CurrentRoom = room;
				}
			}
		}

		protected bool IsInRange(Vector3 targetPos)
		{
			float sqrMagnitude = (RoomPosition - targetPos).sqrMagnitude;
			int num = MaxTriggerMeters * MaxTriggerMeters;
			return sqrMagnitude <= (float)num;
		}
	}
}

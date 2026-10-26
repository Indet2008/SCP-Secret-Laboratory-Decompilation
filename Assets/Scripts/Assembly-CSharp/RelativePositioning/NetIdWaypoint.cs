using System;
using System.Collections.Generic;
using System.Linq;
using MapGeneration;
using Mirror;
using UnityEngine;

namespace RelativePositioning
{
	public class NetIdWaypoint : WaypointBase
	{
		[SerializeField]
		private NetworkIdentity _targetNetId;

		private Vector3 _pos;

		private const byte Offset = 32;

		private static readonly HashSet<NetIdWaypoint> AllNetWaypoints = new HashSet<NetIdWaypoint>();

		private static bool _refreshNextFrame;

		private static bool _callEvent;

		public static event Action OnNetIdWaypointsSet;

		protected override void Start()
		{
			base.Start();
			SetPosition();
			AllNetWaypoints.Add(this);
			_refreshNextFrame = true;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			AllNetWaypoints.Remove(this);
		}

		protected override float SqrDistanceTo(Vector3 pos)
		{
			float num = pos.x - _pos.x;
			float num2 = pos.y - _pos.y;
			float num3 = pos.z - _pos.z;
			return num * num + num2 * num2 + num3 * num3;
		}

		public override Vector3 GetWorldspacePosition(Vector3 relPosition)
		{
			return relPosition + _pos;
		}

		public override Vector3 GetRelativePosition(Vector3 worldPoint)
		{
			return worldPoint - _pos;
		}

		private void Update()
		{
			if (!_refreshNextFrame)
			{
				base.enabled = false;
				return;
			}
			byte b = 32;
			foreach (NetIdWaypoint item in AllNetWaypoints.OrderBy((NetIdWaypoint x) => x._targetNetId.netId))
			{
				item.SetPosition();
				item.SetId(b);
				b++;
			}
			if (_callEvent)
			{
				OnNetIdWaypointsSet?.Invoke();
				_callEvent = false;
			}
			_refreshNextFrame = false;
		}

		private void Reset()
		{
			_targetNetId = GetComponent<NetworkIdentity>();
		}

		private void SetPosition()
		{
			_pos = _targetNetId.transform.position;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			SeedSynchronizer.OnGenerationStage += (MapGenerationPhase stage) =>
			{
				if (stage == MapGenerationPhase.RelativePositioningWaypoints)
				{
					_refreshNextFrame = true;
					_callEvent = true;
				}
			};
		}
	}
}

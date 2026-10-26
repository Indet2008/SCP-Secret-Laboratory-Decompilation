using System;
using DrawableLine;
using InventorySystem.Items.Pickups;
using Mirror;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class Scp018Physics : PickupPhysicsModule
	{
		private struct BounceData
		{
			public float VerticalSpeed;

			public RelativePosition RelPos;

			public double Time;
		}

		public const int RpcSize = 19;

		private readonly OrderedBufferQueue<BounceData> _buffer;

		private readonly Scp018Projectile _scp018;

		private readonly ParticleSystem _trail;

		private readonly LayerMask _detectionMask;

		private readonly float _radius;

		private readonly float _maxVel;

		private readonly float _velPerBounce;

		private readonly bool _wasServer;

		private const int UpdateFrequency = 10;

		private const float PrecalcTime = 0.2f;

		private Vector3 _lastVelocity;

		private RelativePosition _lastPosition;

		private Vector3? _lastSafeOrigin;

		private double _lastTime;

		private bool _outOfBounds;

		private BounceData _prevBounce;

		private BounceData _nextBounce;

		protected override ItemPickupBase Pickup => _scp018;

		public Vector3 Position
		{
			get
			{
				double time = NetworkTime.time;
				bool flag = false;
				while (time > _nextBounce.Time)
				{
					if (!_buffer.TryDequeue(out var data))
					{
						return _nextBounce.RelPos.Position;
					}
					_prevBounce = _nextBounce;
					_nextBounce = data;
					flag = true;
					if (WaypointBase.TryGetWaypoint(_prevBounce.RelPos.WaypointId, out var wp))
					{
						ParticleSystem.MainModule main = _trail.main;
						if (wp is ElevatorWaypoint)
						{
							main.simulationSpace = ParticleSystemSimulationSpace.Custom;
							main.customSimulationSpace = wp.transform;
						}
						else
						{
							main.simulationSpace = ParticleSystemSimulationSpace.World;
						}
					}
				}
				Vector3 position = _prevBounce.RelPos.Position;
				Vector3 position2 = _nextBounce.RelPos.Position;
				float num = (float)(time - _prevBounce.Time);
				float num2 = (float)(_nextBounce.Time - _prevBounce.Time);
				if (flag)
				{
					float velocity = Vector3.Distance(position, position2) / num2;
					_scp018.RegisterBounce(velocity, position);
				}
				float freefallHeight = GetFreefallHeight(num);
				float freefallHeight2 = GetFreefallHeight(num2);
				float num3 = position2.y - position.y - freefallHeight2;
				float num4 = num / num2;
				position2.y = (position.y = position.y + freefallHeight + num3 * num4);
				return Vector3.Lerp(position, position2, num4);
			}
		}

		public Scp018Physics(Scp018Projectile thrownScp018, ParticleSystem trail, float radius, float maxVel, float velPerBounce)
		{
			if (!(thrownScp018.PhysicsModule is PickupStandardPhysics pickupStandardPhysics))
			{
				throw new InvalidOperationException("SCP-018's physics module can only replace PickupStandardPhysics");
			}
			_scp018 = thrownScp018;
			_trail = trail;
			_radius = radius;
			_maxVel = maxVel;
			_velPerBounce = velPerBounce;
			_buffer = new OrderedBufferQueue<BounceData>((BounceData x, BounceData y) => x.Time > y.Time);
			_lastTime = NetworkTime.time;
			_lastVelocity = pickupStandardPhysics.Rb.linearVelocity;
			_lastPosition = new RelativePosition(_scp018.Position);
			_prevBounce = new BounceData
			{
				RelPos = _lastPosition,
				Time = _lastTime,
				VerticalSpeed = _lastVelocity.y
			};
			pickupStandardPhysics.Rb.isKinematic = true;
			int layer = _scp018.gameObject.layer;
			for (int num = 0; num < 32; num++)
			{
				if (!Physics.GetIgnoreLayerCollision(layer, num))
				{
					_detectionMask = (int)_detectionMask | (1 << num);
				}
			}
			_nextBounce = PrecomputeNextBounce();
			if (NetworkServer.active)
			{
				_wasServer = true;
				StaticUnityMethods.OnUpdate += ServerUpdatePrediction;
				Pickup.GetComponentsInChildren<Collider>().ForEach((Collider x) =>
				{
					x.isTrigger = true;
				});
			}
		}

		public override void DestroyModule()
		{
			base.DestroyModule();
			if (_wasServer)
			{
				StaticUnityMethods.OnUpdate -= ServerUpdatePrediction;
			}
		}

		internal override void ClientProcessRpc(NetworkReader rpcData)
		{
			base.ClientProcessRpc(rpcData);
			double num = rpcData.ReadDouble();
			if (!NetworkServer.active && !(NetworkTime.time > num))
			{
				RelativePosition relPos = rpcData.ReadRelativePosition();
				float verticalSpeed = rpcData.ReadFloat();
				_buffer.Enqueue(new BounceData
				{
					RelPos = relPos,
					Time = num,
					VerticalSpeed = verticalSpeed
				});
			}
		}

		[Server]
		private void ServerUpdatePrediction()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void InventorySystem.Items.ThrowableProjectiles.Scp018Physics::ServerUpdatePrediction()' called when server was not active");
				return;
			}
			while (!_outOfBounds && _lastTime - 0.20000000298023224 < NetworkTime.time)
			{
				BounceData data = PrecomputeNextBounce();
				_buffer.Enqueue(data);
				ServerSendRpc((NetworkWriter writer) =>
				{
					writer.WriteDouble(data.Time);
					writer.WriteRelativePosition(data.RelPos);
					writer.WriteFloat(data.VerticalSpeed);
				});
			}
		}

		private float GetFreefallHeight(float elapsed)
		{
			float num = Physics.gravity.y / 2f;
			float num2 = elapsed * elapsed;
			return _prevBounce.VerticalSpeed * elapsed + num * num2;
		}

		private BounceData PrecomputeNextBounce()
		{
			while (true)
			{
				float magnitude = _lastVelocity.magnitude;
				float maxDis = magnitude * 0.1f;
				bool num = TrySphereCast(_lastPosition.Position, _lastVelocity, maxDis, out var hit);
				_lastPosition = new RelativePosition(hit.point);
				if (num)
				{
					_lastTime += hit.distance / magnitude;
					BounceTrajectory(hit.normal);
					break;
				}
				_lastTime += 0.10000000149011612;
				_lastVelocity += Physics.gravity * 0.1f;
				if (_lastPosition.OutOfRange)
				{
					_outOfBounds = true;
					break;
				}
			}
			return new BounceData
			{
				RelPos = _lastPosition,
				Time = _lastTime,
				VerticalSpeed = _lastVelocity.y
			};
		}

		private void BounceTrajectory(Vector3 normal)
		{
			_lastVelocity = Vector3.Reflect(_lastVelocity, normal);
			float magnitude = _lastVelocity.magnitude;
			Vector3 vector = _lastVelocity / magnitude;
			_lastVelocity = vector * Mathf.Min(magnitude + _velPerBounce, _maxVel);
		}

		private bool TrySphereCast(Vector3 origin, Vector3 dir, float maxDis, out RaycastHit hit)
		{
			dir.Normalize();
			if (Physics.CheckSphere(origin, _radius, _detectionMask, QueryTriggerInteraction.Ignore) && _lastSafeOrigin.HasValue)
			{
				origin = _lastSafeOrigin.Value;
				dir = UnityEngine.Random.insideUnitSphere;
			}
			DrawableLines.GenerateSphere(origin, _radius, Color.cyan);
			if (!Physics.SphereCast(origin, _radius, dir, out hit, maxDis + 0.04f, _detectionMask, QueryTriggerInteraction.Ignore))
			{
				hit.point = origin + dir * maxDis;
				return false;
			}
			hit.point += hit.normal * _radius - dir * 0.04f;
			_lastSafeOrigin = origin;
			return true;
		}
	}
}

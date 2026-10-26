using System;
using InventorySystem.Items.Pickups;
using Mirror;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class TrajectoryPhysics : PickupPhysicsModule
	{
		private const int UpdateFrequency = 10;

		private const float InaccuracyCompensation = 0.04f;

		private readonly ItemPickupBase _pickup;

		private double _startTime;

		private double _endTime;

		private RelativePosition _startPosition;

		private RelativePosition _endPosition;

		private float _startVerticalVelocity;

		private Vector3 HalfGravity => Physics.gravity / 2f;

		protected override ItemPickupBase Pickup => _pickup;

		public bool DestinationReached { get; private set; }

		public Vector3 LastVelocity { get; private set; }

		public TrajectoryPhysics(ItemPickupBase ipb)
		{
			_pickup = ipb;
			_pickup.PhysicsModuleSyncData.OnModified += OnSyncVarsModified;
			StaticUnityMethods.OnUpdate += UpdateTrajectory;
		}

		public override void DestroyModule()
		{
			base.DestroyModule();
			StaticUnityMethods.OnUpdate -= UpdateTrajectory;
		}

		public void ServerSetup(Vector3 position, Vector3 velocity, float radius, LayerMask detectionMask)
		{
			RelativePosition startPosition = new RelativePosition(position);
			float y = velocity.y;
			float num = 0f;
			bool num2;
			RelativePosition endPosition;
			do
			{
				velocity += HalfGravity * 0.1f;
				num2 = TrySphereCast(velocity.magnitude * 0.1f, out var hit);
				velocity += HalfGravity * 0.1f;
				position = hit.point;
				num += 0.1f;
				endPosition = new RelativePosition(position);
			}
			while (!num2 && !endPosition.OutOfRange && !Physics.CheckSphere(position, radius + 0.04f, detectionMask));
			ServerSetup(NetworkTime.time, NetworkTime.time + (double)num, startPosition, endPosition, y);
			bool TrySphereCast(float maxDis, out RaycastHit reference)
			{
				Vector3 normalized = velocity.normalized;
				if (!Physics.SphereCast(position, radius, normalized, out reference, maxDis, detectionMask))
				{
					reference.point = position + normalized * maxDis;
					return false;
				}
				reference.point += reference.normal * radius;
				return true;
			}
		}

		public void ServerSetup(double startTime, double endTime, RelativePosition startPosition, RelativePosition endPosition, float verticalVelocity)
		{
			_startTime = startTime;
			_endTime = endTime;
			_startPosition = startPosition;
			_endPosition = endPosition;
			_startVerticalVelocity = verticalVelocity;
			ServerSetSyncData((NetworkWriter writer) =>
			{
				writer.WriteDouble(startTime);
				writer.WriteDouble(_endTime);
				writer.WriteRelativePosition(startPosition);
				writer.WriteRelativePosition(endPosition);
				writer.WriteFloat(verticalVelocity);
			});
		}

		private void OnSyncVarsModified()
		{
			ClientReadSyncData((NetworkReader reader) =>
			{
				_startTime = reader.ReadDouble();
				_endTime = reader.ReadDouble();
				_startPosition = reader.ReadRelativePosition();
				_endPosition = reader.ReadRelativePosition();
				_startVerticalVelocity = reader.ReadFloat();
			});
		}

		private void UpdateTrajectory()
		{
			double num = _endTime - _startTime;
			double num2 = Math.Clamp(NetworkTime.time - _startTime, 0.0, num);
			double num3 = num2 * num2;
			double num4 = num2 / num;
			Vector3 position = _startPosition.Position;
			Vector3 position2 = _endPosition.Position;
			float num5 = (float)((double)(0f - _startVerticalVelocity) * num2 - (double)HalfGravity.y * num3);
			Vector3 vector = Vector3.Lerp(position, position2, (float)num4);
			double num6 = num4 * num4;
			float t = (float)(num6 * num6);
			float y = Mathf.Lerp(position.y - num5, position2.y, t);
			_pickup.Position = new Vector3(vector.x, y, vector.z);
			if (Math.Abs(num4 - 1.0) <= 1.401298464324817E-45)
			{
				DestinationReached = true;
				return;
			}
			double num7 = (double)_startVerticalVelocity + (double)Physics.gravity.y * num2;
			Vector3 vector2 = (position2 - position) / (float)num;
			LastVelocity = new Vector3(vector2.x, (float)num7, vector2.z);
		}
	}
}

using GameObjectPools;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.Scp106Events;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using ProgressiveCulling;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106HuntersAtlasAbility : Scp106VigorAbilityBase, IPoolResettable
	{
		public const float CostPerMeter = 0.015f;

		private const ActionName SelectKey = ActionName.Shoot;

		private const int SyncAccuracy = 50;

		private const float HeightOffset = 0.2f;

		private const float NormalMultiplier = 1.1f;

		private const float GroundDetectorHeight = 2f;

		private const float DissolvePercent = 0.5f;

		private const float MaxRetakeRange = 15f;

		private const float HeightTolerance = 100f;

		private const float DoorHeightTolerance = 40f;

		private const int PhysicsMaxDetections = 8;

		private const float MinVigor = 0.25f;

		private const float BaseCostPerUse = 0.15f;

		private const float EmergeNoticeRange = 4f;

		private Vector3 _syncPos;

		private RoomIdentifier _syncRoom;

		private bool _syncSubmerged;

		private float _lastDissolveAmount;

		private float _estimatedCost;

		[SerializeField]
		private CooldownAudio _cooldownAudio;

		private static LayerMask? _absoluteCollisionMask;

		private static readonly float DebugDuration = 0f;

		private static readonly Collider[] DetectionsNonAlloc = new Collider[8];

		private static readonly RaycastHit[] HitsNonAlloc = new RaycastHit[8];

		protected override ActionName TargetKey => ActionName.Inventory;

		public override bool ServerWantsSubmerged => _syncSubmerged;

		public override float SubmergeTime => 2f;

		public override float EmergeTime => 1f;

		protected override bool KeyPressable => base.Owner.isLocalPlayer;

		private void UpdateAny()
		{
			if (base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated())
			{
				float submergeProgress = base.CastRole.Sinkhole.SubmergeProgress;
				_lastDissolveAmount = (_syncSubmerged ? Mathf.InverseLerp(0.5f, 1f, submergeProgress) : 0f);
				Scp106Hud.SetDissolveAnimation(_lastDissolveAmount);
			}
		}

		private void UpdateClientside()
		{
			Scp106Minimap singleton = Scp106Minimap.Singleton;
			if (singleton == null)
			{
				return;
			}
			if (base.CastRole.Sinkhole.SubmergeProgress != 0f || !IsKeyHeld || !base.CastRole.FpcModule.IsGrounded || !base.Owner.TryGetCurrentRoom(out var _))
			{
				singleton.IsVisible = false;
				return;
			}
			if (!base.CastRole.Sinkhole.ReadonlyCooldown.IsReady)
			{
				singleton.IsVisible = false;
				Scp106Hud.PlayFlash(vigor: false);
				return;
			}
			if (base.VigorAmount < 0.25f)
			{
				singleton.IsVisible = false;
				Scp106Hud.PlayFlash(vigor: true);
				return;
			}
			singleton.IsVisible = true;
			if (Scp106MinimapElement.AnyHighlighted && Input.GetKey(NewInput.GetKey(ActionName.Shoot)))
			{
				_syncPos = singleton.LastWorldPos;
				_syncRoom = Scp106MinimapElement.LastHighlighted.Room;
				ClientSendCmd();
			}
		}

		private void UpdateServerside()
		{
			if (_syncSubmerged && !(base.CastRole.Sinkhole.SubmergeProgress < 1f))
			{
				Vector3 safePosition = GetSafePosition();
				Vector3 position = base.CastRole.FpcModule.Position;
				float num = (safePosition - position).MagnitudeIgnoreY();
				base.VigorAmount -= Mathf.Min(_estimatedCost, num * 0.015f) + 0.15f;
				base.CastRole.FpcModule.ServerOverridePosition(safePosition);
				_syncSubmerged = false;
				Scp106Events.OnUsedHunterAtlas(new Scp106UsedHunterAtlasEventArgs(base.Owner, position));
				ServerSendRpc(toAll: true);
			}
		}

		private Vector3 GetSafePosition()
		{
			Vector3 result = base.CastRole.FpcModule.Position;
			float num = float.MaxValue;
			foreach (Pose location in SafeLocationFinder.GetLocations(ValidateDestinationConnection, ValidateDestinationDoor))
			{
				if (!(Mathf.Abs(location.position.y - _syncPos.y) > 40f))
				{
					Vector3 vector = ClosestDoorPosition(location.position);
					float num2 = (vector - _syncPos).SqrMagnitudeIgnoreY();
					if (!(num2 > num))
					{
						num = num2;
						result = vector;
					}
				}
			}
			return result;
		}

		private bool ValidateDestinationDoor(DoorVariant dv)
		{
			if (!(dv is IScp106PassableDoor { IsScp106Passable: not false }))
			{
				return false;
			}
			if (!dv.Rooms.Contains(_syncRoom))
			{
				return false;
			}
			return true;
		}

		private bool ValidateDestinationConnection(RoomCullingConnection connection)
		{
			RoomCullingConnection.RoomLink link = connection.Link;
			if (link.Valid)
			{
				if (!(_syncRoom == link.RoomA))
				{
					return _syncRoom == link.RoomB;
				}
				return true;
			}
			return false;
		}

		private Vector3 ClosestDoorPosition(Vector3 doorPos)
		{
			Vector3 vector = _syncPos - doorPos;
			Vector3 dir = new Vector3(vector.x, 0f, vector.z);
			float num = dir.magnitude;
			if (num > 0f)
			{
				dir /= num;
			}
			float radius = base.CastRole.FpcModule.CharController.radius;
			float height = base.CastRole.FpcModule.CharController.height;
			Vector3 origin = doorPos + Vector3.up * (0.2f + radius);
			Color debugColor = ((DebugDuration > 0f) ? Random.ColorHSV(0f, 1f, 0.5f, 1f, 0.4f, 0.8f) : Color.clear);
			do
			{
				if (TrySphereCast(debugColor, origin, dir, radius, height, num, out var pos))
				{
					return pos;
				}
				num = Mathf.Min(15f, num - radius);
			}
			while (!(num < radius));
			return doorPos + Vector3.up * height;
		}

		private bool TrySphereCast(Color debugColor, Vector3 origin, Vector3 dir, float radius, float height, float maxDis, out Vector3 pos)
		{
			LayerMask valueOrDefault = _absoluteCollisionMask.GetValueOrDefault();
			if (!_absoluteCollisionMask.HasValue)
			{
				valueOrDefault = (int)FpcStateProcessor.Mask & ~Scp106MovementModule.PassableDetectionMask;
				_absoluteCollisionMask = valueOrDefault;
			}
			LayerMask value = _absoluteCollisionMask.Value;
			Debug.DrawRay(origin, dir, debugColor, DebugDuration);
			if (Physics.SphereCast(origin, radius, dir, out var hitInfo, maxDis + radius, value))
			{
				hitInfo.point += 1.1f * radius * hitInfo.normal;
			}
			else
			{
				hitInfo.point = origin + dir * maxDis;
			}
			pos = hitInfo.point;
			if (DebugDuration > 0f)
			{
				DebugHitPoint(hitInfo.point, debugColor);
			}
			if (!Physics.Raycast(pos + Vector3.up * 0.2f, Vector3.down, out var hitInfo2, 2f, value))
			{
				return false;
			}
			int num = Physics.OverlapSphereNonAlloc(hitInfo2.point, radius * 2f, DetectionsNonAlloc);
			for (int i = 0; i < num; i++)
			{
				if (DetectionsNonAlloc[i].TryGetComponent<TeslaGate>(out var _))
				{
					return false;
				}
			}
			pos = hitInfo2.point + Vector3.up * (0.2f + radius);
			if (Physics.CheckCapsule(pos, pos + Vector3.up * (height - radius - 0.2f), radius, value))
			{
				return false;
			}
			if (!TryClearPath(pos, dir, maxDis))
			{
				return false;
			}
			pos = hitInfo2.point + Vector3.up * height;
			return true;
		}

		private bool TryClearPath(Vector3 start, Vector3 dir, float dis)
		{
			int num = Physics.RaycastNonAlloc(new Ray(start, dir), HitsNonAlloc, dis, Scp106MovementModule.PassableDetectionMask);
			for (int i = 0; i < num; i++)
			{
				Scp106MovementModule.GetSlowdownFromCollider(HitsNonAlloc[i].collider, out var isPassable);
				if (!isPassable)
				{
					return false;
				}
			}
			return true;
		}

		private void DebugHitPoint(Vector3 point, Color debugColor)
		{
			Vector3[] array = new Vector3[6]
			{
				Vector3.up,
				Vector3.down,
				Vector3.left,
				Vector3.right,
				Vector3.forward,
				Vector3.back
			};
			foreach (Vector3 vector in array)
			{
				Debug.DrawLine(point, point + vector * 0.1f, debugColor, DebugDuration);
			}
		}

		protected override void Update()
		{
			base.Update();
			UpdateAny();
			if (base.Owner.isLocalPlayer)
			{
				UpdateClientside();
			}
			if (NetworkServer.active)
			{
				UpdateServerside();
			}
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			Vector3 position = _syncRoom.transform.position;
			writer.WriteRelativePosition(new RelativePosition(position));
			Vector3Int vector3Int = Vector3Int.RoundToInt((_syncPos - position) * 50f);
			writer.WriteShort((short)vector3Int.x);
			writer.WriteShort((short)vector3Int.z);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (base.CastRole.Sinkhole.SubmergeProgress > 0f || !base.CastRole.Sinkhole.ReadonlyCooldown.IsReady)
			{
				return;
			}
			Vector3 position = reader.ReadRelativePosition().Position;
			if (!position.TryGetRoom(out _syncRoom))
			{
				return;
			}
			Vector3 vector = new Vector3(reader.ReadShort(), 0f, reader.ReadShort());
			_syncPos = position + vector / 50f;
			Vector3 position2 = base.CastRole.FpcModule.Position;
			if (Mathf.Abs(position2.y - _syncPos.y) > 100f)
			{
				return;
			}
			float num = (position2 - _syncPos).MagnitudeIgnoreY() * 0.015f;
			if (!(num > base.VigorAmount))
			{
				Scp106UsingHunterAtlasEventArgs e = new Scp106UsingHunterAtlasEventArgs(base.Owner, _syncPos);
				Scp106Events.OnUsingHunterAtlas(e);
				if (e.IsAllowed)
				{
					_syncPos = e.DestinationPosition;
					_estimatedCost = num;
					_syncSubmerged = true;
					ServerSendRpc(toAll: true);
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBool(_syncSubmerged);
			if (!_syncSubmerged)
			{
				writer.WriteVector3(base.Owner.GetPosition());
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncSubmerged = reader.ReadBool();
			if (!_syncSubmerged)
			{
				base.CastRole.Sinkhole.PlayEmergenceAlert(reader.ReadVector3(), 4f);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_syncSubmerged = false;
			if (_lastDissolveAmount > 0f)
			{
				_lastDissolveAmount = 0f;
				Scp106Hud.SetDissolveAnimation(0f);
			}
		}
	}
}

using DrawableLine;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.Modules.Misc;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchHitRegModule : StandardSubroutine<OverwatchRole>
	{
		public const char HitChar = 'X';

		public const char HeadshotChar = 'H';

		public const char MissChar = 'O';

		private const float GeneratedLineDuration = 2f;

		private char _lastToSend = ' ';

		private Vector3 _lastStartPos;

		private Vector3 _lastEndPos;

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteChar(_lastToSend);
			writer.WriteVector3(_lastStartPos);
			writer.WriteVector3(_lastEndPos);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			char next = reader.ReadChar();
			Vector3 vector = reader.ReadVector3();
			Vector3 vector2 = reader.ReadVector3();
			if (OverwatchHitRegLog.Instance != null)
			{
				OverwatchHitRegLog.Instance.AddEntry(next);
			}
			DrawableLines.GenerateLine(2f, Color.yellow, vector, vector2);
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			HitscanHitregModuleBase.ServerAnyPlayerFired += OnAnyFired;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			HitscanHitregModuleBase.ServerAnyPlayerFired -= OnAnyFired;
		}

		private void OnAnyFired(ReferenceHub owner, HitscanResult hitscan)
		{
			if (base.Owner == null || !(base.Owner.roleManager.CurrentRole is OverwatchRole overwatchRole) || owner == null || hitscan == null || overwatchRole.SyncedSpectatedNetId != owner.netId)
			{
				return;
			}
			if (hitscan.Destructibles.IsEmpty() && hitscan.Obstacles.IsEmpty())
			{
				_lastToSend = 'O';
				ServerSendRpc(base.Owner);
				return;
			}
			foreach (DestructibleHitPair destructible in hitscan.Destructibles)
			{
				if (destructible.Destructible is HitboxIdentity hitboxIdentity)
				{
					_lastToSend = ((hitboxIdentity.HitboxType == HitboxType.Headshot) ? 'H' : 'X');
					_lastStartPos = destructible.Raycast.Ray.origin;
					_lastEndPos = destructible.Hit.point;
					ServerSendRpc(base.Owner);
				}
			}
			foreach (HitRayPair obstacle in hitscan.Obstacles)
			{
				_lastToSend = 'O';
				_lastStartPos = obstacle.Ray.origin;
				_lastEndPos = obstacle.Hit.point;
				ServerSendRpc(base.Owner);
			}
		}
	}
}

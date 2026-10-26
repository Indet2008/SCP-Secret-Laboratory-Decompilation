using System.Collections.Generic;
using System.Diagnostics;
using Mirror;
using PlayerRoles;
using RelativePositioning;
using UnityEngine;
using UnityEngine.VFX;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class HitscanBulletTracer : TracerBase
	{
		private const float MinLength = 1f;

		private const float MaxLength = 15f;

		private const float RandomMaxChanceDot = 0.08f;

		private const float RandomNoChanceDot = 0.35f;

		private const float WhizzTriggerRangeSqr = 25f;

		private const float RandomFriendlyFireMultiplier = 0.5f;

		private static readonly int TracerOriginHash = Shader.PropertyToID("Origin");

		private static readonly int TracerFriendlyHash = Shader.PropertyToID("IsFriendly");

		private static readonly Dictionary<FirearmCategory, float> CategoryMultipliers = new Dictionary<FirearmCategory, float>
		{
			[FirearmCategory.Revolver] = 2f,
			[FirearmCategory.SubmachineGun] = 0.5f
		};

		[SerializeField]
		private VisualEffect _vfx;

		[SerializeField]
		private float _minimalDuration;

		private Transform _tr;

		private BulletWhizzHandler _whizzHandler;

		private bool _supportsWhizz;

		private Stopwatch _stopwatch;

		protected override bool IsBusy
		{
			get
			{
				if (!(_stopwatch.Elapsed.TotalSeconds < (double)_minimalDuration))
				{
					if (_supportsWhizz)
					{
						return _whizzHandler.IsPlaying;
					}
					return false;
				}
				return true;
			}
		}

		public override void ServerWriteExtraData(Firearm firearm, NetworkWriter writer)
		{
			base.ServerWriteExtraData(firearm, writer);
			writer.WriteByte((byte)firearm.Owner.GetTeam());
		}

		protected override void OnCreated()
		{
			base.OnCreated();
			_tr = base.transform;
			_supportsWhizz = TryGetComponent<BulletWhizzHandler>(out _whizzHandler);
			_stopwatch = Stopwatch.StartNew();
		}

		protected override void OnDequeued()
		{
			base.OnDequeued();
			_stopwatch.Restart();
		}

		protected override void OnFired(NetworkReader reader)
		{
			if (!ReferenceHub.TryGetPovHub(out var hub) || !WaypointBase.TryGetWaypoint(base.RelativeHitPosition.WaypointId, out var wp))
			{
				return;
			}
			Vector3 worldspacePosition = wp.GetWorldspacePosition(base.RelativeHitPosition.Relative);
			bool flag = !HitboxIdentity.IsEnemy(hub.GetTeam(), (Team)reader.ReadByte());
			Vector3 position = MainCameraController.CurrentCamera.position;
			if (global::Misc.TryGetClosestLineSegment(base.OriginPosition, worldspacePosition, position, 1f, 15f, out var newStart, out var newEnd, out var closestPointOnLine, out var normalizedDir) && ValidateRandom(Mathf.Abs(normalizedDir.y), flag, base.Template.FirearmCategory))
			{
				_vfx.SetVector3(TracerOriginHash, newStart - newEnd);
				_vfx.SetBool(TracerFriendlyHash, flag);
				_vfx.Play();
				_tr.SetPositionAndRotation(newEnd, Quaternion.identity);
				_tr.SetParent(wp.transform);
				if (!flag && _supportsWhizz && !((closestPointOnLine - position).sqrMagnitude > 25f))
				{
					_whizzHandler.Play(normalizedDir, closestPointOnLine);
				}
			}
		}

		private static bool ValidateRandom(float verticalDot, bool isFriendly, FirearmCategory cat)
		{
			float num = 1f - Mathf.InverseLerp(0.08f, 0.35f, verticalDot);
			float num2 = (isFriendly ? 0.5f : 1f);
			float num3 = (CategoryMultipliers.TryGetValue(cat, out var value) ? value : 1f);
			return Random.value < num * num2 * num3;
		}
	}
}

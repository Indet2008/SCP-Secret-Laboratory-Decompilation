using System;
using System.Diagnostics;
using Mirror;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class DisruptorTracer : TracerBase
	{
		[Serializable]
		private class EffectsPair
		{
			private const float DistanceToSpeed = 100f;

			public ParticleSystem[] Particles;

			public BulletWhizzHandler WhizzHandler;

			public float WhizzTriggerRangeSqr;

			public void Play(float distance)
			{
				ParticleSystem[] particles = Particles;
				foreach (ParticleSystem obj in particles)
				{
					ParticleSystem.MainModule main = obj.main;
					main.startSpeed = 100f * distance;
					obj.Play();
				}
			}
		}

		private const float RecycleTime = 5f;

		private const float MinLength = 0.5f;

		private const float MaxLength = 35f;

		[SerializeField]
		private EffectsPair _singleShotEffects;

		[SerializeField]
		private EffectsPair _rapidFireEffects;

		private Transform _tr;

		private Stopwatch _stopwatch;

		protected override bool IsBusy => _stopwatch.Elapsed.TotalSeconds < 5.0;

		protected override void OnCreated()
		{
			base.OnCreated();
			_tr = base.transform;
			_stopwatch = Stopwatch.StartNew();
		}

		protected override void OnDequeued()
		{
			base.OnDequeued();
			_stopwatch.Restart();
		}

		protected override void OnFired(NetworkReader reader)
		{
			if (!WaypointBase.TryGetWaypoint(base.RelativeHitPosition.WaypointId, out var wp))
			{
				return;
			}
			EffectsPair effectsPair;
			switch ((DisruptorActionModule.FiringState)reader.ReadByte())
			{
			case DisruptorActionModule.FiringState.FiringSingle:
				effectsPair = _singleShotEffects;
				break;
			case DisruptorActionModule.FiringState.FiringRapid:
				effectsPair = _rapidFireEffects;
				break;
			default:
				return;
			}
			Vector3 worldspacePosition = wp.GetWorldspacePosition(base.RelativeHitPosition.Relative);
			Vector3 position = MainCameraController.CurrentCamera.position;
			if (global::Misc.TryGetClosestLineSegment(base.OriginPosition, worldspacePosition, position, 0.5f, 35f, out var newStart, out var newEnd, out var closestPointOnLine, out var normalizedDir))
			{
				effectsPair.Play(Vector3.Distance(newStart, newEnd));
				_tr.position = newStart;
				_tr.forward = normalizedDir;
				_tr.SetParent(wp.transform);
				if (!((closestPointOnLine - position).sqrMagnitude > effectsPair.WhizzTriggerRangeSqr))
				{
					effectsPair.WhizzHandler.Play(normalizedDir, closestPointOnLine);
				}
			}
		}

		public override void ServerWriteExtraData(Firearm firearm, NetworkWriter writer)
		{
			base.ServerWriteExtraData(firearm, writer);
			if (!firearm.TryGetModule<DisruptorHitregModule>(out var module))
			{
				writer.WriteByte(0);
			}
			else
			{
				writer.WriteByte((byte)module.LastFiringState);
			}
		}
	}
}

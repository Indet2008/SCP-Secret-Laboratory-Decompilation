using System;
using PlayerRoles.PlayableScps;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcBacktracker : IDisposable
	{
		private readonly Vector3 _prevPos;

		private readonly Quaternion _prevRot;

		private readonly Vector3 _newPos;

		private readonly ReferenceHub _movedHub;

		private bool _moved;

		private bool _restoreUponDeath;

		public float MoveAmount => Vector3.Distance(_newPos, _prevPos);

		public FpcBacktracker(ReferenceHub attacker, Vector3 claimedPos, Quaternion claimedRot, float backtrack = 0.1f, float forecast = 0.15f)
			: this(attacker, claimedPos, claimedRot, backtrack, forecast, ignoreTp: true, restoreUponDeath: true)
		{
		}

		public FpcBacktracker(ReferenceHub target, Vector3 claimedPos, float backtrack = 0.4f)
			: this(target, claimedPos, target.PlayerCameraReference.rotation, backtrack, 0f, ignoreTp: true, restoreUponDeath: true)
		{
		}

		public FpcBacktracker(ReferenceHub hub, Vector3 claimedPos, Quaternion claimedRot, float backtrack, float forecast, bool ignoreTp, bool restoreUponDeath)
		{
			if (hub.roleManager.CurrentRole is IFpcRole { FpcModule: var fpcModule })
			{
				_moved = true;
				_movedHub = hub;
				_prevPos = fpcModule.Position;
				_prevRot = hub.PlayerCameraReference.rotation;
				Bounds bounds = ((backtrack <= 0f) ? new Bounds(fpcModule.Position, Vector3.zero) : fpcModule.Tracer.GenerateBounds(backtrack, ignoreTp));
				if (forecast > 0f && !Physics.Linecast(hub.PlayerCameraReference.position, claimedPos, VisionInformation.VisionLayerMask))
				{
					bounds.Encapsulate(_prevPos + fpcModule.Motor.Velocity * forecast);
				}
				_newPos = bounds.ClosestPoint(claimedPos);
				fpcModule.Position = _newPos;
				hub.PlayerCameraReference.rotation = claimedRot;
			}
			else
			{
				_moved = false;
			}
			if (restoreUponDeath)
			{
				PlayerStats.OnAnyPlayerDied += OnDied;
				_restoreUponDeath = true;
			}
			else
			{
				_restoreUponDeath = false;
			}
		}

		public void Cancel()
		{
			_moved = true;
			_restoreUponDeath = false;
		}

		public void Dispose()
		{
			RestorePosition();
		}

		public void RestorePosition()
		{
			if (_moved)
			{
				if (_movedHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					fpcRole.FpcModule.Position = _prevPos;
					_movedHub.PlayerCameraReference.rotation = _prevRot;
				}
				_moved = false;
			}
			if (_restoreUponDeath)
			{
				PlayerStats.OnAnyPlayerDied -= OnDied;
				_restoreUponDeath = false;
			}
		}

		private void OnDied(ReferenceHub ply, DamageHandlerBase dhb)
		{
			if (!(ply != _movedHub))
			{
				RestorePosition();
			}
		}
	}
}

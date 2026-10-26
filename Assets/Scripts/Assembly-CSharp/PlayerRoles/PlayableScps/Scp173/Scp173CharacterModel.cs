using System;
using System.Diagnostics;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173CharacterModel : CharacterModel
	{
		public delegate void ModelFrozen(Scp173Role target);

		[SerializeField]
		private float _lowestPitch;

		[SerializeField]
		private AudioSource[] _footstepSources;

		[SerializeField]
		private float _footstepOverallLoundess;

		[SerializeField]
		private float _footstepSwapSpeed;

		[SerializeField]
		private float _footstepEnableSpeed;

		[SerializeField]
		private float _footstepDisableSpeed;

		[SerializeField]
		private float _groundedSustainTime;

		[SerializeField]
		private float _footstepGroundedSustainMultiplier;

		private readonly Stopwatch _groundedSw = Stopwatch.StartNew();

		private int _sourcesCount;

		private float _stepSize;

		private bool _isFrozen;

		private float _currentVolume;

		private Quaternion _frozenRot;

		private Scp173Role _role;

		private Scp173MovementModule _fpc;

		private Scp173ObserversTracker _observers;

		public bool Frozen
		{
			get
			{
				return _isFrozen;
			}
			set
			{
				if (value != _isFrozen)
				{
					_isFrozen = value;
					if (_isFrozen)
					{
						_frozenRot = base.transform.rotation;
						OnFrozen?.Invoke(_role);
					}
					else
					{
						base.transform.localRotation = Quaternion.identity;
					}
				}
			}
		}

		public static event ModelFrozen OnFrozen;

		private void LateUpdate()
		{
			if (base.HasOwner && ReferenceHub.TryGetLocalHub(out var hub))
			{
				Frozen = HitboxIdentity.IsEnemy(Team.SCPs, hub.GetTeam()) && _observers.IsObservedBy(hub);
				UpdateFootsteps(!Frozen && _fpc.Motor.Velocity != Vector3.zero, _fpc.IsGrounded);
				if (Frozen)
				{
					base.transform.rotation = _frozenRot;
				}
			}
		}

		private void UpdateFootsteps(bool isMoving, bool grounded)
		{
			float num = (isMoving ? _footstepEnableSpeed : _footstepDisableSpeed);
			if (grounded)
			{
				_groundedSw.Restart();
			}
			else if (isMoving && _groundedSw.Elapsed.TotalSeconds < (double)_groundedSustainTime)
			{
				num *= _footstepGroundedSustainMultiplier;
			}
			float num2 = Mathf.MoveTowards(_currentVolume, (isMoving & grounded) ? 1 : 0, Time.deltaTime * num);
			float pitch = Mathf.Lerp(_lowestPitch, 1f, num2);
			float num3 = Time.timeSinceLevelLoad * _footstepSwapSpeed;
			_currentVolume = num2;
			num2 *= _footstepOverallLoundess;
			for (int i = 0; i < _sourcesCount; i++)
			{
				AudioSource obj = _footstepSources[i];
				float f = Mathf.Sin(num3 + MathF.PI * _stepSize * (float)i);
				obj.pitch = pitch;
				obj.volume = num2 * Mathf.Abs(f);
			}
		}

		private void OnGrounded()
		{
			_currentVolume = 1f;
		}

		public override void Setup(ReferenceHub owner, IFpcRole role, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, role, localPos, localRot);
			_role = base.OwnerHub.roleManager.CurrentRole as Scp173Role;
			_fpc = _role.FpcModule as Scp173MovementModule;
			Scp173MovementModule fpc = _fpc;
			fpc.OnGrounded = (Action)Delegate.Combine(fpc.OnGrounded, new Action(OnGrounded));
			_role.SubroutineModule.TryGetSubroutine<Scp173ObserversTracker>(out _observers);
			_sourcesCount = _footstepSources.Length;
			_stepSize = 1f / (float)_sourcesCount;
			for (int i = 0; i < _sourcesCount; i++)
			{
				AudioSource obj = _footstepSources[i];
				obj.volume = 0f;
				obj.PlayDelayed(obj.clip.length * _stepSize * (float)i);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			FirstPersonMovementModule fpcModule = _role.FpcModule;
			fpcModule.OnGrounded = (Action)Delegate.Remove(fpcModule.OnGrounded, new Action(OnGrounded));
			for (int i = 0; i < _sourcesCount; i++)
			{
				_footstepSources[i].Stop();
			}
		}
	}
}

using System;
using AudioPooling;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.PlayableScps.Subroutines;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507Model : CharacterModel
	{
		[SerializeField]
		private float _minPosDiff;

		[SerializeField]
		private float _minAngularDiff;

		[SerializeField]
		private float _relocationSpeed;

		[SerializeField]
		private AnimationCurve _relocationLerpOverProgress;

		[SerializeField]
		private AnimationCurve _relocationHeightAnim;

		[SerializeField]
		private Color _outlineColor;

		[SerializeField]
		private AudioClip[] _footsteps;

		[SerializeField]
		private Animator _animator;

		[SerializeField]
		private Transform _footstepOrigin;

		[SerializeField]
		private AnimationCurve _hitboxesSizeMultiplierOverTime;

		private Scp1507Role _role;

		private FirstPersonMovementModule _fpc;

		private Scp1507AttackAbility _peck;

		private Scp1507VocalizeAbility _vocalize;

		private Transform _fpcTr;

		private Transform _ownTr;

		private RelativePosition _prevRelPosition;

		private Quaternion _prevRelRotation;

		private float _relocationProgress;

		private double _lastRelocation;

		private float _lastSize;

		private static readonly int SelectionColorId = Shader.PropertyToID("_SelectionColor");

		private static readonly int WalkAnimHash = Animator.StringToHash("flamingo|walk");

		private static readonly int AttackAnimHash = Animator.StringToHash("Attack");

		private static readonly int VocalizeAnimHash = Animator.StringToHash("Vocalize");

		private static bool _hitboxCacheSet;

		private static float[] _hitboxRadiuses;

		private static float[] _hitboxHeights;

		public const int FootstepRange = 30;

		public static event Action<Scp1507Model> OnFootstepPlayed;

		private void LateUpdate()
		{
			if (base.Pooled)
			{
				return;
			}
			UpdateHitboxes();
			Vector3 position = _prevRelPosition.Position;
			Quaternion worldRotation = WaypointBase.GetWorldRotation(_prevRelPosition.WaypointId, _prevRelRotation);
			Vector3 position2 = _fpc.Position;
			Quaternion rotation = _fpcTr.rotation;
			if (_fpc.IsGrounded && !(_relocationProgress > 0f) && !(Quaternion.Angle(worldRotation, rotation) > _minAngularDiff) && !(Vector3.Distance(position, position2) > _minPosDiff))
			{
				Vector3 position3 = new Vector3(position.x, position2.y, position.z);
				_ownTr.SetPositionAndRotation(position3, worldRotation);
				return;
			}
			_relocationProgress = Mathf.Clamp01(_relocationProgress + Time.deltaTime * _relocationSpeed);
			float t = _relocationLerpOverProgress.Evaluate(_relocationProgress);
			Vector3 vector = Vector3.up * _relocationHeightAnim.Evaluate(_relocationProgress);
			Vector3 position4 = Vector3.Lerp(position, position2 + vector, t);
			Quaternion rotation2 = Quaternion.Lerp(worldRotation, rotation, t);
			_ownTr.SetPositionAndRotation(position4, rotation2);
			_animator.Play(WalkAnimHash, 0, _relocationProgress);
			if (!(_relocationProgress < 1f) && _fpc.IsGrounded)
			{
				_prevRelPosition = new RelativePosition(_fpc.Position);
				_prevRelRotation = WaypointBase.GetRelativeRotation(_prevRelPosition.WaypointId, _ownTr.rotation);
				AudioSourcePoolManager.PlayOnTransform(_footsteps.RandomItem(), _footstepOrigin, 30f, 1f, FalloffType.Footstep);
				OnFootstepPlayed?.Invoke(this);
				_relocationProgress = 0f;
				_lastRelocation = NetworkTime.time;
			}
		}

		private void UpdateHitboxes()
		{
			float time = (float)(NetworkTime.time - _lastRelocation);
			float num = _hitboxesSizeMultiplierOverTime.Evaluate(time);
			if (num != _lastSize)
			{
				_lastSize = num;
				for (int i = 0; i < base.Hitboxes.Length; i++)
				{
					CapsuleCollider obj = base.Hitboxes[i].TargetColliders[0] as CapsuleCollider;
					obj.height = _hitboxHeights[i] * num;
					obj.radius = _hitboxRadiuses[i] * num;
				}
			}
		}

		private void PlayPeckAnim(AttackResult result)
		{
			_animator.SetTrigger(AttackAnimHash);
		}

		private void PlayVocalizeAnim()
		{
			_animator.SetTrigger(VocalizeAnimHash);
		}

		protected override void Awake()
		{
			base.Awake();
			_ownTr = base.transform;
			ReadOnlySpan<Renderer> renderers = base.Renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				Renderer obj = renderers[i];
				MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
				obj.GetPropertyBlock(materialPropertyBlock);
				materialPropertyBlock.SetColor(SelectionColorId, _outlineColor);
				obj.SetPropertyBlock(materialPropertyBlock);
			}
			if (!_hitboxCacheSet)
			{
				_hitboxCacheSet = true;
				_hitboxHeights = new float[base.Hitboxes.Length];
				_hitboxRadiuses = new float[base.Hitboxes.Length];
				for (int j = 0; j < base.Hitboxes.Length; j++)
				{
					CapsuleCollider component = base.Hitboxes[j].GetComponent<CapsuleCollider>();
					_hitboxHeights[j] = component.height;
					_hitboxRadiuses[j] = component.radius;
				}
			}
		}

		public override void Setup(ReferenceHub owner, IFpcRole role, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, role, localPos, localRot);
			_role = role as Scp1507Role;
			_fpc = _role.FpcModule;
			_fpcTr = _fpc.transform;
			_role.SubroutineModule.TryGetSubroutine<Scp1507AttackAbility>(out _peck);
			_peck.OnAttacked += PlayPeckAnim;
			_role.SubroutineModule.TryGetSubroutine<Scp1507VocalizeAbility>(out _vocalize);
			Scp1507VocalizeAbility vocalize = _vocalize;
			vocalize.OnVocalized = (Action)Delegate.Combine(vocalize.OnVocalized, new Action(PlayVocalizeAnim));
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_peck.OnAttacked -= PlayPeckAnim;
			Scp1507VocalizeAbility vocalize = _vocalize;
			vocalize.OnVocalized = (Action)Delegate.Remove(vocalize.OnVocalized, new Action(PlayVocalizeAnim));
		}
	}
}

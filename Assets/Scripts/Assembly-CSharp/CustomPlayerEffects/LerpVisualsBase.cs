using PlayerRoles;
using PlayerRoles.Spectating;
using UnityEngine;

namespace CustomPlayerEffects
{
	// Restored from the 14.2.8 client disassembly.
	public abstract class LerpVisualsBase : MonoBehaviour
	{
		private bool _enableInstant;

		private bool _disableInstant;

		private float _weight;

		[SerializeField]
		protected bool UpdateOnRoleChange = true;

		[SerializeField]
		protected float EnableSpeed = 1f;

		[SerializeField]
		protected float DisableSpeed = 1f;

		protected StatusEffectBase TargetEffect { get; private set; }

		protected float Weight
		{
			get
			{
				return _weight;
			}
			set
			{
				if (_weight == 0f && value > 0f)
				{
					OnActivated();
				}
				_weight = Mathf.Clamp01(value);
				OnWeightChanged(_weight);
				if (_weight == 0f)
				{
					OnShutdown();
					base.enabled = false;
				}
			}
		}

		protected abstract void OnWeightChanged(float weight);

		protected virtual void OnActivated()
		{
		}

		protected virtual void OnShutdown()
		{
		}

		protected virtual void Update()
		{
			if (TargetEffect.Intensity > 0)
			{
				Weight = (_enableInstant ? 1f : (_weight + Time.deltaTime / EnableSpeed));
			}
			else
			{
				Weight = (_disableInstant ? 0f : (_weight - Time.deltaTime / DisableSpeed));
			}
		}

		protected virtual void Awake()
		{
			TargetEffect = GetComponent<StatusEffectBase>();
			StatusEffectBase.OnEnabled += UpdateState;
			StatusEffectBase.OnDisabled += UpdateState;
			PlayerRoleManager.OnRoleChanged += UpdateRoleChange;
			SpectatorTargetTracker.OnTargetChanged += UpdateSpectator;
			_enableInstant = Mathf.Abs(EnableSpeed) < 0.001f;
			_disableInstant = Mathf.Abs(DisableSpeed) < 0.001f;
		}

		private void OnDestroy()
		{
			StatusEffectBase.OnEnabled -= UpdateState;
			StatusEffectBase.OnDisabled -= UpdateState;
			PlayerRoleManager.OnRoleChanged -= UpdateRoleChange;
			SpectatorTargetTracker.OnTargetChanged -= UpdateSpectator;
		}

		private void UpdateState(StatusEffectBase triggeredEffect)
		{
			if ((TargetEffect.Hub.isLocalPlayer || TargetEffect.Hub.IsLocallySpectated()) && !(triggeredEffect != TargetEffect))
			{
				base.enabled = true;
			}
		}

		private void UpdateSpectator()
		{
			if (TargetEffect.Hub.IsLocallySpectated())
			{
				Weight = ((TargetEffect.Intensity > 0) ? 1f : 0f);
			}
		}

		private void UpdateRoleChange(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!(hub != TargetEffect.Hub) && UpdateOnRoleChange)
			{
				Weight = 0f;
			}
		}
	}
}

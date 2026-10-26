using UnityEngine;

namespace CustomPlayerEffects
{
	// Client-only behaviour stripped from the server build: fades an effect's visuals
	// in while the owning effect is enabled on the player we are looking through.
	public abstract class LerpVisualsBase : MonoBehaviour
	{
		[SerializeField]
		protected bool UpdateOnRoleChange;

		[SerializeField]
		protected float EnableSpeed;

		[SerializeField]
		protected float DisableSpeed;

		private bool _effectSearched;

		protected StatusEffectBase Effect { get; private set; }

		protected float CurrentWeight { get; private set; }

		protected virtual float TargetWeight
		{
			get
			{
				if (Effect == null || !Effect.IsEnabled || Effect.Hub == null || !Effect.IsPOV)
				{
					return 0f;
				}
				return 1f;
			}
		}

		protected virtual void Awake()
		{
			FindEffect();
			ApplyWeight(0f);
		}

		protected virtual void Update()
		{
			if (!_effectSearched)
			{
				FindEffect();
			}
			float targetWeight = TargetWeight;
			float num = ((targetWeight > CurrentWeight) ? EnableSpeed : DisableSpeed);
			float num2 = ((num > 0f) ? Mathf.MoveTowards(CurrentWeight, targetWeight, num * Time.deltaTime) : targetWeight);
			if (num2 != CurrentWeight)
			{
				CurrentWeight = num2;
				ApplyWeight(num2);
			}
		}

		protected virtual void OnDisable()
		{
			CurrentWeight = 0f;
			ApplyWeight(0f);
		}

		private void FindEffect()
		{
			_effectSearched = true;
			Effect = GetComponentInParent<StatusEffectBase>(includeInactive: true);
			if (Effect == null)
			{
				Effect = GetComponentInChildren<StatusEffectBase>(includeInactive: true);
			}
		}

		protected abstract void ApplyWeight(float weight);
	}
}

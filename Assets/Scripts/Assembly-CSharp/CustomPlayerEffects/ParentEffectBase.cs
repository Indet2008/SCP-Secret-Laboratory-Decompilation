using PlayerRoles;
using UnityEngine;

namespace CustomPlayerEffects
{
	public abstract class ParentEffectBase<T> : StatusEffectBase where T : SubEffectBase
	{
		[field: SerializeField]
		public T[] SubEffects { get; private set; }

		internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			base.OnRoleChanged(previousRole, newRole);
			T[] subEffects = SubEffects;
			for (int i = 0; i < subEffects.Length; i++)
			{
				subEffects[i].DisableEffect();
			}
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			T[] subEffects = SubEffects;
			for (int i = 0; i < subEffects.Length; i++)
			{
				subEffects[i].DisableEffect();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			T[] subEffects = SubEffects;
			for (int i = 0; i < subEffects.Length; i++)
			{
				subEffects[i].Init(this);
			}
		}

		protected virtual void UpdateSubEffects()
		{
			T[] subEffects = SubEffects;
			for (int i = 0; i < subEffects.Length; i++)
			{
				subEffects[i].UpdateEffect();
			}
		}
	}
}

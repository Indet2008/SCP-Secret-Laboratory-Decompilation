using CustomPlayerEffects;
using UnityEngine;

namespace PlayerRoles.Spectating.SpectatableListEffects
{
	public class Scp1576SpectatorIconEffect : SpectatorSliderIconEffect
	{
		private const float TotalDuration = 32f;

		private const float SliderSpeed = 1f / 32f;

		private const float SliderLerpMaxDelta = 0.0625f;

		private static int? _effectIndexCache;

		public override void Update()
		{
			base.Update();
			UpdateIconVisibility(TryGetScp1576Effect(out var effect) && effect.IsEnabled);
		}

		private bool TryGetScp1576Effect(out Scp1576 effect)
		{
			PlayerRoleBase mainRole = base.SpectatableListElement.Target.MainRole;
			if (!_effectIndexCache.HasValue && !TryCacheEffectIndex(mainRole))
			{
				effect = null;
				return false;
			}
			if (!mainRole.TryGetOwner(out var hub))
			{
				effect = null;
				return false;
			}
			StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
			effect = allEffects[_effectIndexCache.Value] as Scp1576;
			return true;
		}

		public override void UpdateVisible()
		{
			base.UpdateVisible();
			if (TryGetScp1576Effect(out var effect))
			{
				float num = (float)(int)effect.Intensity / 32f;
				if (Mathf.Abs(base.SliderValue - num) > 0.0625f)
				{
					base.SliderValue = num;
				}
				else
				{
					base.SliderValue = Mathf.MoveTowards(base.SliderValue, num, Time.deltaTime * (1f / 32f));
				}
			}
		}

		private static bool TryCacheEffectIndex(PlayerRoleBase role)
		{
			if (!role.TryGetOwner(out var hub))
			{
				return false;
			}
			StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
			for (int i = 0; i < allEffects.Length; i++)
			{
				if (allEffects[i] is Scp1576)
				{
					_effectIndexCache = i;
					return true;
				}
			}
			return false;
		}
	}
}

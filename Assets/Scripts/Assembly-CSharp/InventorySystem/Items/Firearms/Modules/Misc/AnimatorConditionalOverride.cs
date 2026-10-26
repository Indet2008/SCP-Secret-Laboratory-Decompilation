using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	[Serializable]
	public class AnimatorConditionalOverride
	{
		[SerializeField]
		private AnimatorLayerMask _mask;

		[SerializeField]
		private float _enableSpeed;

		[SerializeField]
		private float _disableSpeed;

		[SerializeField]
		private bool _disableWhenHandling;

		private float _weight;

		private float _handlingElapsed;

		private bool _wasReloading;

		private const float HandlingTransitionCompensation = 0.2f;

		private static readonly int HandlingTag = FirearmAnimatorHashes.Reload;

		private bool IsReloading(Firearm firearm)
		{
			if (firearm.TryGetModule<IReloaderModule>(out var module))
			{
				return module.IsReloadingOrUnloading;
			}
			return false;
		}

		private bool IsHandling(Firearm firearm)
		{
			AnimatedViewmodelBase clientViewmodelInstance = firearm.ClientViewmodelInstance;
			int num = clientViewmodelInstance.AnimatorGetLayerCount();
			bool flag = false;
			for (int i = 0; i < num; i++)
			{
				if (clientViewmodelInstance.AnimatorStateInfo(i).tagHash == HandlingTag)
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				if (IsReloading(firearm))
				{
					_wasReloading = true;
					return true;
				}
				return !_wasReloading;
			}
			_wasReloading = false;
			return false;
		}

		public void Update(Firearm firearm, bool enabled)
		{
			if (firearm.HasViewmodel)
			{
				if (_disableWhenHandling && IsHandling(firearm))
				{
					_handlingElapsed += Time.deltaTime;
				}
				else
				{
					_handlingElapsed = 0f;
				}
				float num = ((!enabled || !(_handlingElapsed < 0.2f)) ? ((_disableSpeed <= 0f) ? (-1f) : ((0f - _disableSpeed) * Time.deltaTime)) : ((_enableSpeed <= 0f) ? 1f : (_enableSpeed * Time.deltaTime)));
				_weight = Mathf.Clamp01(num + _weight);
				_mask.SetWeight(firearm.ClientViewmodelInstance.AnimatorSetLayerWeight, _weight);
			}
		}
	}
}

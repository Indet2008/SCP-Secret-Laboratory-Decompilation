using System;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ViewmodelReloadOnlyLayerExtension : MonoBehaviour, IViewmodelExtension
	{
		private enum Mode
		{
			DuringReloadsAndUnloads = 0,
			OutsideReloadsAndUnloads = 1
		}

		[SerializeField]
		private AnimatorLayerMask _mask;

		[Header("When should the layers be active?")]
		[SerializeField]
		private Mode _mode;

		private AnimatedFirearmViewmodel _viewmodel;

		private IReloaderModule _reloaderModule;

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_viewmodel = viewmodel;
			_viewmodel.ParentFirearm.TryGetModule<IReloaderModule>(out _reloaderModule);
		}

		private void Update()
		{
			bool isReloadingOrUnloading = _reloaderModule.IsReloadingOrUnloading;
			bool flag = _mode switch
			{
				Mode.DuringReloadsAndUnloads => isReloadingOrUnloading, 
				Mode.OutsideReloadsAndUnloads => !isReloadingOrUnloading, 
				_ => throw new NotImplementedException("Unknown operating mode of ViewmodelReloadOnlyLayerExtension"), 
			};
			_viewmodel.AnimatorSetLayerWeight(_mask, flag ? 1 : 0);
		}
	}
}

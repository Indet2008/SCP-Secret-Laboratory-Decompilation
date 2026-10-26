using System;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ViewmodelRevolverExtension : MonoBehaviour, IViewmodelExtension
	{
		[SerializeField]
		private WorldmodelRevolverExtension.RoundsSet[] _roundsSets;

		[SerializeField]
		private int _cockedOffset;

		[SerializeField]
		private int _insertionOffset;

		[SerializeField]
		private AnimatorLayerMask _inspectTriggerOverrides;

		[SerializeField]
		private float _inspectTriggerWeightScale;

		private RevolverClipReloaderModule _clipModule;

		private CylinderAmmoModule _cylinderModule;

		private DoubleActionModule _doubleActionModule;

		private Action<int, float> _setWeightAction;

		private int _prevWithheld;

		private ushort _serial;

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			viewmodel.ParentFirearm.TryGetModules<CylinderAmmoModule, RevolverClipReloaderModule, DoubleActionModule>(out _cylinderModule, out _clipModule, out _doubleActionModule);
			_clipModule.OnWithheld += OnAmmoWithheld;
			_clipModule.OnAmmoInserted += OnAmmoInserted;
			_setWeightAction = viewmodel.AnimatorSetLayerWeight;
			_serial = viewmodel.ItemId.SerialNumber;
			WorldmodelRevolverExtension.RoundsSet[] roundsSets = _roundsSets;
			for (int i = 0; i < roundsSets.Length; i++)
			{
				roundsSets[i].Init(viewmodel.ParentFirearm);
			}
		}

		private void OnDisable()
		{
			_prevWithheld = 0;
		}

		private void OnAmmoInserted(int amt)
		{
			WorldmodelRevolverExtension.RoundsSet[] roundsSets = _roundsSets;
			for (int i = 0; i < roundsSets.Length; i++)
			{
				roundsSets[i].UpdateAmount(amt, _insertionOffset);
			}
			_prevWithheld = 0;
		}

		private void OnAmmoWithheld()
		{
			int withheldAmmo = _clipModule.WithheldAmmo;
			if (withheldAmmo > _prevWithheld)
			{
				WorldmodelRevolverExtension.RoundsSet[] roundsSets = _roundsSets;
				for (int i = 0; i < roundsSets.Length; i++)
				{
					roundsSets[i].UpdateAmount(withheldAmmo, _insertionOffset);
				}
				_prevWithheld = withheldAmmo;
			}
		}

		private void LateUpdate()
		{
			_inspectTriggerOverrides.SetWeight(_setWeightAction, Mathf.Clamp01(_doubleActionModule.TriggerPullProgress * _inspectTriggerWeightScale));
			if (!_clipModule.IsReloading && !_clipModule.IsUnloading)
			{
				int offset = (_doubleActionModule.Cocked ? _cockedOffset : 0);
				WorldmodelRevolverExtension.RoundsSet[] roundsSets = _roundsSets;
				for (int i = 0; i < roundsSets.Length; i++)
				{
					roundsSets[i].UpdateAmount(_serial, offset);
				}
			}
		}
	}
}

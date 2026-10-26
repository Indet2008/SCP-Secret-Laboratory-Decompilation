using InventorySystem.Items.Firearms.Attachments;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	[PresetPrefabExtension("Flashlight Worldmodel", true)]
	[PresetPrefabExtension("Flashlight Viewmodel", false)]
	public class FlashlightExtension : MixedExtension, IDestroyExtensionReceiver
	{
		private const float ThirdpersonRange = 22f;

		private const float PickupRange = 3.5f;

		[SerializeField]
		private Light _lightSource;

		[SerializeField]
		private Renderer[] _renderers;

		[SerializeField]
		private Material _enabledMaterial;

		[SerializeField]
		private Material _disabledMaterial;

		private bool _updateEveryFrame;

		private bool _eventAssigned;

		private bool? _prevState;

		public override void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			base.InitViewmodel(viewmodel);
			_updateEveryFrame = true;
		}

		public override void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			base.SetupWorldmodel(worldmodel);
			UpdateState();
			switch (worldmodel.WorldmodelType)
			{
			case FirearmWorldmodelType.Thirdperson:
				_lightSource.range = 22f;
				break;
			case FirearmWorldmodelType.Pickup:
			case FirearmWorldmodelType.Presentation:
				_lightSource.range = 3.5f;
				break;
			}
			if (!_eventAssigned)
			{
				FlashlightAttachment.OnAnyStatusChanged += UpdateState;
				_eventAssigned = true;
			}
		}

		public void OnDestroyExtension()
		{
			if (_eventAssigned)
			{
				FlashlightAttachment.OnAnyStatusChanged -= UpdateState;
			}
		}

		private void UpdateState()
		{
			bool flag = FlashlightAttachment.GetEnabled(base.Identifier.SerialNumber);
			if (!_prevState.HasValue || _prevState.Value != flag)
			{
				_prevState = flag;
				_lightSource.enabled = flag;
				Renderer[] renderers = _renderers;
				for (int i = 0; i < renderers.Length; i++)
				{
					renderers[i].sharedMaterial = (flag ? _enabledMaterial : _disabledMaterial);
				}
			}
		}

		private void Update()
		{
			if (_updateEveryFrame)
			{
				UpdateState();
			}
		}
	}
}

using AudioPooling;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ViewmodelTriggerExtension : MonoBehaviour, IViewmodelExtension
	{
		private AnimatedFirearmViewmodel _viewmodel;

		private Firearm _firearm;

		private float _lastShotTime;

		private float _weight;

		private bool _released;

		private const float DefaultPullSpeed = 15f;

		private const float DefaultReleaseSpeed = 6.5f;

		[Range(0f, 1f)]
		[SerializeField]
		private float _triggerVisualReleaseRate;

		[SerializeField]
		private float _pullSpeed = 15f;

		[SerializeField]
		private float _releaseSpeed = 6.5f;

		[SerializeField]
		private AnimatorLayerMask _triggerOverrideLayer;

		[SerializeField]
		private AudioClip _triggerSound;

		private bool TriggerHeld
		{
			get
			{
				if (!_firearm.TryGetModule<ITriggerControllerModule>(out var module) || !module.TriggerHeld)
				{
					return false;
				}
				if (!_firearm.TryGetModule<IActionModule>(out var module2))
				{
					return true;
				}
				float num = 1f / module2.DisplayCyclicRate;
				float num2 = (1f - _triggerVisualReleaseRate) * num;
				double num3 = Time.timeSinceLevelLoad - _lastShotTime;
				if (!(num3 < (double)num2))
				{
					return num3 > (double)(num + Time.deltaTime);
				}
				return true;
			}
		}

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_viewmodel = viewmodel;
			_firearm = viewmodel.ParentFirearm;
		}

		private void Awake()
		{
			ShotEventManager.OnShot += OnShot;
		}

		private void OnDestroy()
		{
			ShotEventManager.OnShot -= OnShot;
		}

		private void OnShot(ShotEvent ev)
		{
			if (!(_viewmodel.ItemId != ev.ItemId))
			{
				_lastShotTime = Time.timeSinceLevelLoad;
			}
		}

		private void Update()
		{
			if (TriggerHeld)
			{
				if (_released)
				{
					AudioSourcePoolManager.Play2D(_triggerSound);
					_released = false;
				}
				_weight += Time.deltaTime * _pullSpeed;
			}
			else
			{
				_weight -= Time.deltaTime * _releaseSpeed;
				_released = true;
			}
			_weight = Mathf.Clamp01(_weight);
			_triggerOverrideLayer.SetWeight(_viewmodel.AnimatorSetLayerWeight, _weight);
		}
	}
}

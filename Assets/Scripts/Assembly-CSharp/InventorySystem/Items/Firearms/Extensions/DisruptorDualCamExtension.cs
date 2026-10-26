using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.ShotEvents;
using MEC;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class DisruptorDualCamExtension : ViewmodelDualCamExtension
	{
		[Serializable]
		private struct IconDefinition
		{
			public IconType Type;

			public GameObject Root;
		}

		private enum IconType
		{
			None = 0,
			DesintegratorMode = 1,
			BurstMode = 2,
			CriticalWarn = 3,
			CrashWarn = 4
		}

		[SerializeField]
		private Transform _root;

		[SerializeField]
		private IconDefinition[] _icons;

		private IconType _selectedIcon;

		private CoroutineHandle _lastHandle;

		private ItemIdentifier _itemId;

		private MagazineModule _magModule;

		private DisruptorModeSelector _selectorModule;

		public override void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			base.InitViewmodel(viewmodel);
			_itemId = viewmodel.ItemId;
			if (viewmodel.ParentFirearm.TryGetModules<MagazineModule, DisruptorModeSelector>(out _magModule, out _selectorModule))
			{
				ShotEventManager.OnShot += OnShot;
				_selectorModule.OnAnimationRequested += OnAnimationRequested;
			}
		}

		protected override void LateUpdate()
		{
			base.LateUpdate();
			IconDefinition[] icons = _icons;
			for (int i = 0; i < icons.Length; i++)
			{
				IconDefinition iconDefinition = icons[i];
				iconDefinition.Root.SetActive(iconDefinition.Type == _selectedIcon);
			}
			_root.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
		}

		private void OnDestroy()
		{
			ShotEventManager.OnShot -= OnShot;
			if (_selectorModule != null)
			{
				_selectorModule.OnAnimationRequested -= OnAnimationRequested;
			}
		}

		private void OnDisable()
		{
			_selectedIcon = IconType.None;
		}

		private void SetIcon(IconType newIcon)
		{
			_selectedIcon = newIcon;
		}

		private void PlayAnimation(IconType icon)
		{
			switch (icon)
			{
			case IconType.None:
				SetIcon(icon);
				break;
			case IconType.DesintegratorMode:
				RunCoroutine(AnimateDisintegratorMode());
				break;
			case IconType.BurstMode:
				RunCoroutine(AnimateBurstMode());
				break;
			case IconType.CriticalWarn:
				RunCoroutine(AnimateCriticalWarn());
				break;
			case IconType.CrashWarn:
				RunCoroutine(AnimateCrash());
				break;
			}
		}

		private void RunCoroutine(IEnumerator<float> coroutine)
		{
			if (_lastHandle.IsRunning)
			{
				Timing.KillCoroutines(_lastHandle);
				SetIcon(IconType.None);
			}
			_lastHandle = Timing.RunCoroutine(coroutine.CancelWith(base.gameObject), Segment.Update);
		}

		private IEnumerator<float> AnimateDisintegratorMode()
		{
			SetIcon(IconType.DesintegratorMode);
			yield return Timing.WaitForSeconds(0.4f);
			SetIcon(IconType.None);
		}

		private IEnumerator<float> AnimateBurstMode()
		{
			for (int i = 0; i < 3; i++)
			{
				SetIcon(IconType.BurstMode);
				yield return Timing.WaitForSeconds(0.082f);
				SetIcon(IconType.None);
				yield return Timing.WaitForSeconds(0.035f);
			}
		}

		private IEnumerator<float> AnimateCriticalWarn()
		{
			for (int i = 0; i < 3; i++)
			{
				SetIcon(IconType.CriticalWarn);
				yield return Timing.WaitForSeconds(0.082f);
				SetIcon(IconType.None);
				yield return Timing.WaitForSeconds(0.055f);
			}
		}

		private IEnumerator<float> AnimateCrash()
		{
			for (int i = 0; i < 20; i++)
			{
				SetIcon(IconType.CriticalWarn);
				yield return Timing.WaitForSeconds(UnityEngine.Random.Range(0.03f, 0.07f));
				SetIcon(IconType.CrashWarn);
				yield return Timing.WaitForSeconds(UnityEngine.Random.Range(0.12f, 0.2f));
				if (UnityEngine.Random.value > 0.6f)
				{
					SetIcon(IconType.None);
					yield return Timing.WaitForSeconds(0.05f);
				}
			}
		}

		private void OnShot(ShotEvent shotEvent)
		{
			if (!(shotEvent.ItemId != _itemId))
			{
				switch (_magModule.AmmoStored)
				{
				case 0:
					PlayAnimation(IconType.CrashWarn);
					break;
				case 1:
					PlayAnimation(IconType.CriticalWarn);
					break;
				}
			}
		}

		private void OnAnimationRequested()
		{
			PlayAnimation(_selectorModule.SingleShotSelected ? IconType.DesintegratorMode : IconType.BurstMode);
		}
	}
}

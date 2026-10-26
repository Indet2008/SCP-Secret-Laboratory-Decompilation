using System.Diagnostics;
using InventorySystem.Items.Firearms.Ammo;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class MagazineRoundsViewmodelExtension : MonoBehaviour, IViewmodelExtension
	{
		[SerializeField]
		private GameObject[] _rounds;

		[SerializeField]
		private Transform _visibilityBeacon;

		[SerializeField]
		private int _onShotOffset;

		[SerializeField]
		private float _onShotSustain;

		private Firearm _fa;

		private ItemIdentifier _itemId;

		private bool _magRefilled;

		private readonly Stopwatch _onShotSw = new Stopwatch();

		private int DisplayedAmount
		{
			get
			{
				int num = IDisplayableAmmoProviderModule.GetCombinedDisplayAmmo(_fa).Magazines;
				if (_onShotSw.IsRunning && _onShotSw.Elapsed.TotalSeconds < (double)_onShotSustain)
				{
					num += _onShotOffset;
				}
				return num;
			}
		}

		public void RemoveOffsets()
		{
			_onShotSw.Reset();
			SetAmmo(DisplayedAmount);
		}

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_fa = viewmodel.ParentFirearm;
			_itemId = viewmodel.ItemId;
		}

		private void OnShot(ShotEvent shotEvent)
		{
			if (!(shotEvent.ItemId != _itemId))
			{
				_onShotSw.Restart();
			}
		}

		private void Awake()
		{
			ShotEventManager.OnShot += OnShot;
		}

		private void OnDestroy()
		{
			ShotEventManager.OnShot -= OnShot;
		}

		private void Update()
		{
			if (_fa.TryGetModule<IReloaderModule>(out var module))
			{
				Vector3 viewport;
				IPrimaryAmmoContainerModule module2;
				int reserveAmmo;
				if (!module.IsReloadingOrUnloading)
				{
					SetAmmo(DisplayedAmount);
					_magRefilled = false;
				}
				else if (ViewmodelCamera.TryGetViewportPoint(_visibilityBeacon.position, out viewport) && (_magRefilled || !(viewport.y > 0f)) && _fa.TryGetModule<IPrimaryAmmoContainerModule>(out module2) && ReserveAmmoSync.TryGet(_fa.Owner, module2.AmmoType, out reserveAmmo))
				{
					SetAmmo(reserveAmmo);
				}
			}
		}

		private void SetAmmo(int ammo)
		{
			for (int i = 0; i < _rounds.Length; i++)
			{
				_rounds[i].SetActive(i < ammo);
			}
		}
	}
}

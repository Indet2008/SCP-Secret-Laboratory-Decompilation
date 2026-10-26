using System;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class WorldmodelRevolverExtension : MonoBehaviour, IWorldmodelExtension, IDestroyExtensionReceiver
	{
		[Serializable]
		public class RoundsSet
		{
			[SerializeField]
			private AttachmentLink _attachment;

			[SerializeField]
			private GameObject[] _liveRounds;

			[SerializeField]
			private GameObject[] _dischargedRounds;

			private bool _worldmodelMode;

			private bool _attachmentActive;

			private uint? _filter;

			public void Init(Firearm fa)
			{
				_attachment.InitCache(fa);
				_worldmodelMode = false;
			}

			public void Init(FirearmWorldmodel worldmodel)
			{
				_worldmodelMode = true;
				if (!_filter.HasValue)
				{
					_attachment.TryGetFilter(worldmodel.Identifier.TypeId, out var filter);
					_filter = filter;
				}
				_attachmentActive = (worldmodel.AttachmentCode & _filter.Value) != 0;
			}

			public void UpdateAmount(int amt, int offset)
			{
				if (Setup())
				{
					for (int i = 0; i < amt; i++)
					{
						GetSafe(_liveRounds, i + offset).SetActive(value: true);
					}
				}
			}

			public void UpdateAmount(ushort serial, int offset)
			{
				if (!Setup())
				{
					return;
				}
				int num = Mathf.Min(_liveRounds.Length, _dischargedRounds.Length);
				CylinderAmmoModule.Chamber[] chambersArrayForSerial = CylinderAmmoModule.GetChambersArrayForSerial(serial, num);
				for (int i = 0; i < num; i++)
				{
					int index = i + offset;
					switch (chambersArrayForSerial[i].ContextState)
					{
					case CylinderAmmoModule.ChamberState.Live:
						GetSafe(_liveRounds, index).SetActive(value: true);
						break;
					case CylinderAmmoModule.ChamberState.Discharged:
						GetSafe(_dischargedRounds, index).SetActive(value: true);
						break;
					}
				}
			}

			private bool Setup()
			{
				GameObject[] liveRounds = _liveRounds;
				for (int i = 0; i < liveRounds.Length; i++)
				{
					liveRounds[i].SetActive(value: false);
				}
				liveRounds = _dischargedRounds;
				for (int i = 0; i < liveRounds.Length; i++)
				{
					liveRounds[i].SetActive(value: false);
				}
				if (!_worldmodelMode)
				{
					return _attachment.Instance.IsEnabled;
				}
				return _attachmentActive;
			}

			private GameObject GetSafe(GameObject[] arr, int index)
			{
				int num = arr.Length;
				return arr[(index % num + num) % num];
			}
		}

		[SerializeField]
		private RoundsSet[] _roundsSets;

		[SerializeField]
		private int _chambersOffset;

		[SerializeField]
		private BipolarTransform _hammer;

		private ushort _serial;

		private bool _eventsAssigned;

		public void OnDestroyExtension()
		{
			if (_eventsAssigned)
			{
				DoubleActionModule.OnCockedChanged -= OnCockedChanged;
				CylinderAmmoModule.OnChambersModified -= UpdateChambers;
			}
		}

		public void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			RoundsSet[] roundsSets = _roundsSets;
			for (int i = 0; i < roundsSets.Length; i++)
			{
				roundsSets[i].Init(worldmodel);
			}
			_serial = worldmodel.Identifier.SerialNumber;
			_hammer.Polarity = DoubleActionModule.GetCocked(_serial);
			if (!_eventsAssigned)
			{
				_eventsAssigned = true;
				DoubleActionModule.OnCockedChanged += OnCockedChanged;
				CylinderAmmoModule.OnChambersModified += UpdateChambers;
				UpdateChambers(worldmodel.Identifier.SerialNumber);
			}
		}

		private void UpdateChambers(ushort serial)
		{
			RoundsSet[] roundsSets = _roundsSets;
			for (int i = 0; i < roundsSets.Length; i++)
			{
				roundsSets[i].UpdateAmount(serial, _chambersOffset);
			}
		}

		private void OnCockedChanged(ushort serial, bool cocked)
		{
			if (serial == _serial)
			{
				_hammer.Polarity = cocked;
			}
		}
	}
}

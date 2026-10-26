using System;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class WorldmodelMagazineExtension : MonoBehaviour, IWorldmodelExtension
	{
		[Serializable]
		private class Magazine
		{
			private uint? _filter;

			private bool? _lastIsActive;

			public GameObject Target;

			public AttachmentLink[] Attachments;

			public void UpdateState(WorldmodelMagazineExtension extRef, bool magInserted)
			{
				if (magInserted)
				{
					if (!_filter.HasValue)
					{
						SetFilter(extRef._lastId);
					}
					uint num = extRef._lastAttCode & _filter.Value;
					SetVisibility(extRef._removalMode, num != 0 || _filter == (uint?)uint.MaxValue);
				}
				else
				{
					SetVisibility(extRef._removalMode, isActive: false);
				}
			}

			private void SetVisibility(RemovalMode removalMode, bool isActive)
			{
				if (!_lastIsActive.HasValue || _lastIsActive != isActive)
				{
					switch (removalMode)
					{
					case RemovalMode.SetScaleZero:
						Target.transform.localScale = (isActive ? Vector3.one : Vector3.zero);
						break;
					case RemovalMode.DeactivateObject:
						Target.SetActive(isActive);
						break;
					}
					_lastIsActive = isActive;
				}
			}

			private void SetFilter(ItemIdentifier id)
			{
				if (Attachments == null || Attachments.Length == 0)
				{
					_filter = uint.MaxValue;
					return;
				}
				uint num = 0u;
				AttachmentLink[] attachments = Attachments;
				for (int i = 0; i < attachments.Length; i++)
				{
					if (attachments[i].TryGetFilter(id.TypeId, out var filter))
					{
						num |= filter;
					}
				}
				_filter = num;
			}
		}

		private enum RemovalMode
		{
			DeactivateObject = 0,
			SetScaleZero = 1
		}

		private ItemIdentifier _lastId;

		private uint _lastAttCode;

		private bool _forceInserted;

		[SerializeField]
		private Magazine[] _magazines;

		[SerializeField]
		private RemovalMode _removalMode;

		public void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			_lastId = worldmodel.Identifier;
			_lastAttCode = worldmodel.AttachmentCode;
			_forceInserted = worldmodel.WorldmodelType == FirearmWorldmodelType.Presentation;
			UpdateAllMags();
		}

		private void UpdateAllMags()
		{
			bool magInserted = _forceInserted || MagazineModule.GetMagazineInserted(_lastId.SerialNumber);
			Magazine[] magazines = _magazines;
			for (int i = 0; i < magazines.Length; i++)
			{
				magazines[i].UpdateState(this, magInserted);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			MagazineModule.OnDataReceived += (ushort serial) =>
			{
				if (FirearmWorldmodel.Instances.TryGetValue(serial, out var value) && value.TryGetExtension<WorldmodelMagazineExtension>(out var extension))
				{
					extension.UpdateAllMags();
				}
			};
		}
	}
}

using System;
using InventorySystem.Items.Firearms.Attachments;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class BarrelTipExtension : MixedExtension
	{
		[Serializable]
		private class TipPosition
		{
			public AttachmentLink Attachment;

			public Vector3 Position;
		}

		private const float OffsetScale = 0.001f;

		[SerializeField]
		private Vector3 _localDirection = Vector3.forward;

		[SerializeField]
		private Vector3 _baselineOffset;

		[SerializeField]
		private TipPosition[] _attachmentOffsets;

		[SerializeField]
		[Header("These transforms will always be at the barrel tip position.")]
		private Transform[] _followers;

		private uint[] _cachedFilters;

		private Vector3 _curTipPosition;

		private Transform _cachedTr;

		private bool _transformCacheSet;

		public Vector3 WorldspaceDirection => CachedTr.TransformDirection(_localDirection);

		public Vector3 WorldspacePosition => CachedTr.TransformPoint(_curTipPosition);

		private Transform CachedTr
		{
			get
			{
				if (!_transformCacheSet)
				{
					_cachedTr = base.transform;
					_transformCacheSet = true;
				}
				return _cachedTr;
			}
		}

		public static bool TryFindWorldmodelBarrelTip(ushort serial, out BarrelTipExtension foundExtension)
		{
			if (FirearmWorldmodel.Instances.TryGetValue(serial, out var value))
			{
				return value.TryGetExtension<BarrelTipExtension>(out foundExtension);
			}
			foundExtension = null;
			return false;
		}

		public override void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			base.SetupWorldmodel(worldmodel);
			SetAttachments(worldmodel.AttachmentCode);
		}

		public override void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			base.InitViewmodel(viewmodel);
			viewmodel.OnAttachmentsUpdated += UpdateViewmodel;
			UpdateViewmodel();
		}

		private void UpdateViewmodel()
		{
			SetAttachments(base.Viewmodel.ParentFirearm.GetCurrentAttachmentsCode());
		}

		private void ValidateCache()
		{
			if (_cachedFilters != null)
			{
				return;
			}
			_cachedFilters = new uint[_attachmentOffsets.Length];
			for (int i = 0; i < _cachedFilters.Length; i++)
			{
				if (!_attachmentOffsets[i].Attachment.TryGetFilter(base.Identifier.TypeId, out var filter))
				{
					throw new InvalidOperationException($"Cannot generate filter for barrel tip {i}.");
				}
				_cachedFilters[i] = filter;
			}
		}

		private void SetAttachments(uint attCode)
		{
			ValidateCache();
			_curTipPosition = _baselineOffset;
			for (int i = 0; i < _cachedFilters.Length; i++)
			{
				if ((_cachedFilters[i] & attCode) != 0)
				{
					_curTipPosition += _attachmentOffsets[i].Position;
				}
			}
			_curTipPosition *= 0.001f;
			int num = _followers.Length;
			if (num > 0)
			{
				Vector3 worldspacePosition = WorldspacePosition;
				for (int j = 0; j < num; j++)
				{
					_followers[j].position = worldspacePosition;
				}
			}
		}
	}
}

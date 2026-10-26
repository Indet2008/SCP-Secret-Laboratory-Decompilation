using System;
using InventorySystem.Items.Firearms.Extensions;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public class ConditionalSerializableAttachment : SerializableAttachment
	{
		[Serializable]
		private struct ConditionalOverride
		{
			public ConditionalEvaluator Condition;

			public AttachmentDescriptiveAdvantages ExtraPros;

			public AttachmentDescriptiveDownsides ExtraCons;

			public AttachmentParameterValuePair[] Params;
		}

		private int? _lastAppliedOverride;

		private bool _initialized;

		private bool _needsRefreshing;

		[SerializeField]
		private ConditionalOverride[] _overrides;

		private ConditionalOverride? LastOverride
		{
			get
			{
				if (!_lastAppliedOverride.HasValue)
				{
					return null;
				}
				return _overrides[_lastAppliedOverride.Value];
			}
		}

		public override AttachmentDescriptiveAdvantages DescriptivePros => LastOverride?.ExtraPros ?? base.DescriptivePros;

		public override AttachmentDescriptiveDownsides DescriptiveCons => LastOverride?.ExtraCons ?? base.DescriptiveCons;

		protected override void OnInit()
		{
			base.OnInit();
			ConditionalOverride[] overrides = _overrides;
			for (int i = 0; i < overrides.Length; i++)
			{
				overrides[i].Condition.InitInstance(base.Firearm);
			}
			if (_needsRefreshing)
			{
				RefreshOverrides();
			}
			_initialized = true;
		}

		internal override void OnAttachmentsApplied()
		{
			base.OnAttachmentsApplied();
			if (_initialized)
			{
				RefreshOverrides();
			}
			else
			{
				_needsRefreshing = true;
			}
		}

		private void RefreshOverrides()
		{
			for (int i = 0; i < _overrides.Length; i++)
			{
				if (_overrides[i].Condition.Evaluate())
				{
					if (_lastAppliedOverride != i)
					{
						ApplyOverride(i);
					}
					return;
				}
			}
			if (_lastAppliedOverride.HasValue)
			{
				ApplyOverride(null);
			}
		}

		private void ApplyOverride(int? index)
		{
			ClearAllParameters();
			if (!index.HasValue)
			{
				SetDefaultParameters();
			}
			else
			{
				_overrides[index.Value].Params.ForEach(base.SetParameter);
			}
			_lastAppliedOverride = index;
		}
	}
}

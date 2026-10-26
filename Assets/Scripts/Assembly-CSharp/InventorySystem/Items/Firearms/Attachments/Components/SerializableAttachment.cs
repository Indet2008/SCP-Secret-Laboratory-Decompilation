using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public class SerializableAttachment : Attachment, IDisplayableAttachment
	{
		[SerializeField]
		private AttachmentName _name;

		[SerializeField]
		private AttachmentSlot _slot;

		[Space]
		[SerializeField]
		private float _weight;

		[SerializeField]
		private float _length;

		[Space]
		[SerializeField]
		private AttachmentDescriptiveAdvantages _extraPros;

		[SerializeField]
		private AttachmentDescriptiveDownsides _extraCons;

		[Space]
		[SerializeField]
		private Texture2D _icon;

		[SerializeField]
		private Vector2 _iconOffset;

		[SerializeField]
		private int _parentId;

		[SerializeField]
		private Vector2 _parentOffset;

		[Space]
		[SerializeField]
		private AttachmentParameterValuePair[] _params;

		public override AttachmentName Name => _name;

		public override AttachmentSlot Slot => _slot;

		public override float Weight => _weight;

		public override float Length => _length;

		public override AttachmentDescriptiveAdvantages DescriptivePros => _extraPros;

		public override AttachmentDescriptiveDownsides DescriptiveCons => _extraCons;

		public Texture2D Icon
		{
			get
			{
				return _icon;
			}
			set
			{
				_icon = value;
			}
		}

		public Vector2 IconOffset
		{
			get
			{
				return _iconOffset;
			}
			set
			{
				_iconOffset = value;
			}
		}

		public int ParentId => _parentId;

		public Vector2 ParentOffset => _parentOffset;

		protected virtual void Awake()
		{
			SetDefaultParameters();
		}

		protected void SetDefaultParameters()
		{
			_params.ForEach(base.SetParameter);
		}

		protected virtual void Reset()
		{
			if (TryGetComponent<SerializableAttachment>(out var component) && !(component == this))
			{
				_name = component._name;
				_slot = component._slot;
				_weight = component._weight;
				_length = component._length;
				_extraPros = component._extraPros;
				_extraCons = component._extraCons;
				_icon = component._icon;
				_iconOffset = component._iconOffset;
				_parentId = component._parentId;
				_parentOffset = component._parentOffset;
				_params = component._params;
			}
		}
	}
}

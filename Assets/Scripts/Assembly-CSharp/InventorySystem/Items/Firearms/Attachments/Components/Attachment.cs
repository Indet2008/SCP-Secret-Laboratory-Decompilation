using System;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public abstract class Attachment : FirearmSubcomponentBase
	{
		private AttachmentParamState[] _parameterStates;

		private float[] _parameterValues;

		private bool _arraysInitialized;

		private const string AttNamesFilename = "AttachmentNames";

		public abstract AttachmentName Name { get; }

		public abstract AttachmentSlot Slot { get; }

		public abstract float Weight { get; }

		public abstract float Length { get; }

		public abstract AttachmentDescriptiveAdvantages DescriptivePros { get; }

		public abstract AttachmentDescriptiveDownsides DescriptiveCons { get; }

		public byte Index { get; private set; }

		public virtual bool IsEnabled { get; set; }

		private void SetupArrays()
		{
			if (!_arraysInitialized)
			{
				int totalNumberOfParams = AttachmentsUtils.TotalNumberOfParams;
				_parameterValues = new float[totalNumberOfParams];
				_parameterStates = new AttachmentParamState[totalNumberOfParams];
				_arraysInitialized = true;
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			if (base.Firearm.AllSubcomponents.TryGet(base.SyncId - 1, out var element) && element is Attachment attachment)
			{
				Index = (byte)(attachment.Index + 1);
			}
		}

		protected virtual void EnabledEquipUpdate()
		{
		}

		protected void SetParameter(AttachmentParameterValuePair pair)
		{
			SetParameter((int)pair.Parameter, pair.Value, pair.UIOnly ? AttachmentParamState.UserInterface : AttachmentParamState.ActiveAndDisplayed);
		}

		protected void SetParameter(int param, float val, AttachmentParamState state)
		{
			SetupArrays();
			_parameterValues[param] = val;
			_parameterStates[param] = state;
		}

		protected void ClearParameter(AttachmentParam param)
		{
			if (_arraysInitialized)
			{
				_parameterStates[(int)param] = AttachmentParamState.Disabled;
			}
		}

		protected void ClearAllParameters()
		{
			if (_arraysInitialized)
			{
				Array.Clear(_parameterStates, 0, AttachmentsUtils.TotalNumberOfParams);
			}
		}

		public void GetParameterData(int param, out float val, out AttachmentParamState state)
		{
			SetupArrays();
			val = _parameterValues[param];
			state = _parameterStates[param];
		}

		public bool TryGetActiveValue(AttachmentParam param, out float val)
		{
			GetParameterData((int)param, out val, out var state);
			return (state & AttachmentParamState.SilentlyActive) != 0;
		}

		public bool TryGetDisplayValue(AttachmentParam param, out float val)
		{
			GetParameterData((int)param, out val, out var state);
			return (state & AttachmentParamState.UserInterface) != 0;
		}

		public void GetNameAndDescription(out string n, out string d)
		{
			if (TranslationReader.TryGet("AttachmentNames", (int)Name, out var val))
			{
				string[] array = val.Split('~');
				n = array[0];
				d = ((array.Length == 1) ? string.Empty : array[1]);
			}
			else
			{
				n = Name.ToString();
				d = string.Empty;
			}
		}

		internal sealed override void EquipUpdate()
		{
			base.EquipUpdate();
			if (IsEnabled)
			{
				EnabledEquipUpdate();
			}
		}
	}
}

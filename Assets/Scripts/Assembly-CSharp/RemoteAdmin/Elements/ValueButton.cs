using RemoteAdmin.Interfaces;
using UnityEngine;

namespace RemoteAdmin.Elements
{
	public class ValueButton : CustomButton, IValueHolder<string>
	{
		[SerializeField]
		protected bool AllowMultipleSelection;

		[SerializeField]
		[Tooltip("If any other buttons have the same Choice ID as this one, they will be toggled off when this button is selected.")]
		private int _choiceIdentifier;

		[SerializeField]
		private string _value;

		public string Value
		{
			get
			{
				return _value;
			}
			set
			{
				_value = value;
			}
		}

		public int ChoiceId
		{
			get
			{
				return _choiceIdentifier;
			}
			set
			{
				_choiceIdentifier = value;
			}
		}

		public override void SetState(bool isSelected)
		{
			base.SetState(isSelected);
			if (!isSelected || base.CommandMenu == null || base.CommandMenu.Options == null)
			{
				return;
			}
			bool flag = CanSelectMultiple();
			foreach (ValueButton option in base.CommandMenu.Options)
			{
				if (!(option == null) && !(option == this) && (!flag || !option.AllowMultipleSelection) && option.IsSelected && option._choiceIdentifier == _choiceIdentifier)
				{
					option.SetState(isSelected: false);
				}
			}
		}

		protected override void OnInitialize()
		{
			base.OnInitialize();
			if (base.CommandMenu != null && base.CommandMenu.Options != null && !base.CommandMenu.Options.Contains(this))
			{
				base.CommandMenu.Options.Add(this);
			}
		}

		private bool CanSelectMultiple()
		{
			if (AllowMultipleSelection)
			{
				if (!Input.GetKey(KeyCode.LeftControl))
				{
					return Input.GetKey(KeyCode.RightControl);
				}
				return true;
			}
			return false;
		}
	}
}
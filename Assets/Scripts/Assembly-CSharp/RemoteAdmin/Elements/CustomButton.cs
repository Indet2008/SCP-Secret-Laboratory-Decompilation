using RemoteAdmin.Interfaces;
using RemoteAdmin.Menus;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Elements
{
	public abstract class CustomButton : MonoBehaviour, ISelectableElement
	{
		[Header("-- Tools --")]
		[SerializeField]
		[Tooltip("When toggled, it'll search for any Outline, Builder and more components to initialize the properties shown above.")]
		private bool _magicButton;

		[Header("-- Properties --")]
		[SerializeField]
		private string _selectedText;

		[SerializeField]
		private string _unselectedText;

		[SerializeField]
		private bool _modifyText;

		private bool _isSelected;

		private string _oldText;

		private bool _initialized;

		public bool IsSelected
		{
			get
			{
				return _isSelected;
			}
			set
			{
				SetState(value);
			}
		}

		[field: SerializeField]
		public TMP_Text Text { get; set; }

		[field: SerializeField]
		public Outline Outline { get; set; }

		[field: SerializeField]
		public RaCommandMenu CommandMenu { get; set; }

		protected virtual void Awake()
		{
			EnsureInitialized();
		}

		protected void EnsureInitialized()
		{
			if (!_initialized)
			{
				_initialized = true;
				OnInitialize();
			}
		}

		public virtual void Select()
		{
			SetState(!_isSelected);
		}

		public virtual void SetState(bool isSelected)
		{
			_isSelected = isSelected;
			if (Outline != null)
			{
				SubmenuSelector singleton = SubmenuSelector.Singleton;
				Outline.effectColor = ((singleton == null) ? (isSelected ? Color.white : Color.gray) : (isSelected ? singleton.c_selected : singleton.c_deselected));
			}
			if (_modifyText && !(Text == null))
			{
				if (isSelected)
				{
					_oldText = Text.text;
					Text.text = _selectedText;
				}
				else
				{
					Text.text = (string.IsNullOrEmpty(_unselectedText) ? _oldText : _unselectedText);
				}
			}
		}

		protected virtual void OnInitialize()
		{
			if (Outline == null && TryGetComponent<Outline>(out var component))
			{
				Outline = component;
			}
			if (CommandMenu == null)
			{
				CommandMenu = GetComponentInParent<RaCommandMenu>(includeInactive: true);
			}
			if (Text == null)
			{
				Text = GetComponentInChildren<TMP_Text>(includeInactive: true);
			}
		}
	}
}
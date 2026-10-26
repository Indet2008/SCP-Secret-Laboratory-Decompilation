using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UserSettings.GUIElements
{
	public abstract class UserSettingsUIBase<TBehaviour, TStoredValue> : MonoBehaviour where TBehaviour : UIBehaviour
	{
		[SerializeField]
		private bool _setupOnAwake = true;

		private bool _cachedTargetSet;

		private TBehaviour _cachedTargetUi;

		[field: SerializeField]
		public LinkableEnum TargetEnum { get; private set; }

		[field: SerializeField]
		public TStoredValue DefaultValue { get; private set; }

		[field: SerializeField]
		public bool OverrideDefaultValue { get; private set; }

		public bool IsSetup { get; private set; }

		public TBehaviour TargetUI
		{
			get
			{
				if (!_cachedTargetSet)
				{
					_cachedTargetUi = GetComponent<TBehaviour>();
					_cachedTargetSet = true;
				}
				return _cachedTargetUi;
			}
		}

		protected abstract UnityEvent<TStoredValue> OnValueChangedEvent { get; }

		protected TStoredValue StoredValue
		{
			get
			{
				return ReadSavedValue();
			}
			set
			{
				SaveValue(value);
			}
		}

		protected virtual void SaveValue(TStoredValue val)
		{
			UserSetting<TStoredValue>.Set(TargetEnum.TypeHash, TargetEnum.Value, val);
		}

		protected virtual TStoredValue ReadSavedValue()
		{
			if (OverrideDefaultValue)
			{
				return UserSetting<TStoredValue>.Get(TargetEnum.TypeHash, TargetEnum.Value, DefaultValue);
			}
			return UserSetting<TStoredValue>.Get(TargetEnum.TypeHash, TargetEnum.Value);
		}

		protected virtual void Awake()
		{
			if (_setupOnAwake)
			{
				Setup();
			}
		}

		protected virtual void OnDestroy()
		{
			Unlink();
		}

		protected abstract void SetValueAndTriggerEvent(TStoredValue val);

		protected abstract void SetValueWithoutNotify(TStoredValue val);

		public void Setup()
		{
			if (!IsSetup)
			{
				IsSetup = true;
				SetValueWithoutNotify(StoredValue);
				OnValueChangedEvent?.AddListener(SaveValue);
				UserSetting<TStoredValue>.AddListener(TargetEnum.TypeHash, TargetEnum.Value, SetValueWithoutNotify);
			}
		}

		public void Unlink()
		{
			if (IsSetup)
			{
				IsSetup = false;
				OnValueChangedEvent?.RemoveListener(SaveValue);
				UserSetting<TStoredValue>.RemoveListener(SetValueWithoutNotify);
			}
		}

		public void ChangeTargetEnum(LinkableEnum newEnum, bool autoSetup = true)
		{
			Unlink();
			TargetEnum = newEnum;
			if (autoSetup)
			{
				Setup();
			}
		}
	}
}

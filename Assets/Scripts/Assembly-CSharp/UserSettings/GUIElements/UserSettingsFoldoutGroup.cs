using UnityEngine;
using UnityEngine.UI;

namespace UserSettings.GUIElements
{
	public class UserSettingsFoldoutGroup : MonoBehaviour
	{
		private static readonly Quaternion CollapsedRot = Quaternion.Euler(0f, 0f, 90f);

		private static readonly Quaternion ExtendedRot = Quaternion.Euler(0f, 0f, 180f);

		private const float FullAnimTime = 0.15f;

		private const float ExtendTime = 0.08f;

		[Tooltip("Fader of the collapsable group. Note the height of this grooup will be added to the start height when the group is extended.")]
		[SerializeField]
		private CanvasGroup _fadeGroup;

		[Tooltip("Deactivates the game object of the group is folded")]
		[SerializeField]
		private bool _disableWhenInvisible;

		[Tooltip("Will be rotated downwards when the group is extended, and will point to the left when the group is extended.")]
		[SerializeField]
		private RectTransform _arrow;

		[SerializeField]
		private Toggle _extendToggle;

		[SerializeField]
		private bool _collapseOthers;

		[SerializeField]
		private bool _collapseOnDisable;

		private Vector2 _startSize;

		private RectTransform _parentRt;

		private RectTransform _fadeGroupRt;

		private float _animStatus;

		private bool _initialized;

		private static UserSettingsFoldoutGroup _lastFoldedOut;

		public float ExtendRate => Mathf.Clamp01(_animStatus / 0.15f);

		private void Awake()
		{
			Initialize();
		}

		private void OnDisable()
		{
			if (_collapseOnDisable)
			{
				FoldInstantly();
			}
		}

		private void Initialize()
		{
			if (!_initialized)
			{
				_parentRt = GetComponent<RectTransform>();
				_startSize = _parentRt.sizeDelta;
				_fadeGroupRt = _fadeGroup.GetComponent<RectTransform>();
				_initialized = true;
			}
		}

		private void LateUpdate()
		{
			bool isOn = _extendToggle.isOn;
			if (isOn)
			{
				if (_lastFoldedOut != this && _collapseOthers)
				{
					if (_lastFoldedOut != null)
					{
						_lastFoldedOut._extendToggle.isOn = false;
					}
					_lastFoldedOut = this;
				}
				if (_animStatus < 0.15f)
				{
					_animStatus += Time.deltaTime;
				}
				RefreshSize();
			}
			if (!isOn && _animStatus > 0f)
			{
				_animStatus -= Time.deltaTime;
				RefreshSize();
			}
		}

		public void FoldInstantly()
		{
			_extendToggle.isOn = false;
			_animStatus = 0f;
			RefreshSize();
		}

		public void ExtendInstantly()
		{
			_extendToggle.isOn = true;
			_animStatus = 0.15f;
			RefreshSize();
		}

		public void RefreshSize()
		{
			Initialize();
			float num = Mathf.Clamp01(_animStatus / 0.08f);
			_parentRt.sizeDelta = _startSize + _fadeGroupRt.sizeDelta.y * num * Vector2.up;
			_arrow.localRotation = Quaternion.Lerp(CollapsedRot, ExtendedRot, num);
			float num2 = Mathf.InverseLerp(0.08f, 0.15f, _animStatus);
			_fadeGroup.gameObject.SetActive(_animStatus > 0f || !_disableWhenInvisible);
			_fadeGroup.blocksRaycasts = num2 >= 1f;
			_fadeGroup.alpha = num2;
		}
	}
}

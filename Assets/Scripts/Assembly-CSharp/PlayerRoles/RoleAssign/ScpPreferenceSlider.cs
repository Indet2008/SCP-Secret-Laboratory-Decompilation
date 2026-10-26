using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace PlayerRoles.RoleAssign
{
	public class ScpPreferenceSlider : Slider
	{
		private static ScpPreferenceSlider _highlighted;

		[SerializeField]
		private RoleTypeId _role = RoleTypeId.None;

		public static bool AnyHighlighted { get; private set; }

		private int SavedPreference
		{
			get
			{
				return ScpSpawnPreferences.GetPreference(_role);
			}
			set
			{
				ScpSpawnPreferences.SavePreference(_role, value);
			}
		}

		private void OnValueChanged(float x)
		{
			SavedPreference = Mathf.RoundToInt(x);
		}

		private void Deselect()
		{
			if (!(_highlighted != this))
			{
				AnyHighlighted = false;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			base.onValueChanged.AddListener(OnValueChanged);
		}

		protected override void OnEnable()
		{
			base.OnEnable();
			SetValueWithoutNotify(SavedPreference);
		}

		protected override void OnDisable()
		{
			base.OnDisable();
			Deselect();
		}

		public override void OnPointerDown(PointerEventData eventData)
		{
			base.OnPointerDown(eventData);
			AnyHighlighted = true;
			_highlighted = this;
		}

		public override void OnPointerUp(PointerEventData eventData)
		{
			base.OnPointerUp(eventData);
			Deselect();
		}

		public void SetRole(RoleTypeId rt)
		{
			_role = rt;
			SetValueWithoutNotify(SavedPreference);
		}
	}
}

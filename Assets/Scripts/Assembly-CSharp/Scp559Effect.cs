using CustomPlayerEffects;
using InventorySystem.Items.Firearms.Attachments;
using MapGeneration.Holidays;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

public class Scp559Effect : StatusEffectBase, IMovementSpeedModifier, IStaminaModifier, IWeaponModifierPlayerEffect, IHealableEffect, IHolidayEffect
{
	private const float Height = 0.628f;

	public static bool LocallyActive;

	public static float LocalPitchMultiplier;

	[SerializeField]
	private float _heightReduction;

	[SerializeField]
	private float _scaleReduction;

	[SerializeField]
	private float _adjustSpeed;

	[SerializeField]
	private float _voicePitch;

	private float _state;

	private Transform _offset;

	public float ModelScale { get; private set; }

	public bool MovementModifierActive => base.IsEnabled;

	public float MovementSpeedMultiplier => 1.05f;

	public float MovementSpeedLimit => float.MaxValue;

	public bool StaminaModifierActive => base.IsEnabled;

	public float StaminaUsageMultiplier => 0.5f;

	public float StaminaRegenMultiplier => 1f;

	public bool SprintingDisabled => false;

	public bool ParamsActive => base.IsEnabled;

	public HolidayType[] TargetHolidays { get; } = new HolidayType[2]
	{
		HolidayType.Christmas,
		HolidayType.AprilFools
	};

	public override EffectClassification Classification => EffectClassification.Technical;

	private void UpdateSize()
	{
		_offset.localPosition = Vector3.up * (0.628f - _heightReduction * _state);
		ModelScale = _scaleReduction * _state;
		if (base.IsLocalPlayer)
		{
			LocallyActive = _state > 0f;
			LocalPitchMultiplier = Mathf.Lerp(1f, _voicePitch, _state);
		}
		if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
		{
			Transform transform = fpcRole.FpcModule.CharacterModelInstance.transform;
			Vector3 localScale = fpcRole.FpcModule.CharacterModelTemplate.transform.localScale;
			transform.localScale = Vector3.Lerp(localScale, localScale * _scaleReduction, _state);
		}
	}

	protected override void Awake()
	{
		base.Awake();
		_offset = base.Hub.PlayerCameraReference.parent;
		ModelScale = 1f;
	}

	internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
	{
		base.OnRoleChanged(previousRole, newRole);
		_state = 0f;
		UpdateSize();
	}

	protected override void Update()
	{
		base.Update();
		float num = Mathf.MoveTowards(_state, base.IsEnabled ? 1 : 0, _adjustSpeed * Time.deltaTime);
		if (num != _state)
		{
			_state = num;
			UpdateSize();
		}
	}

	public bool TryGetWeaponParam(AttachmentParam param, out float val)
	{
		switch (param)
		{
		case AttachmentParam.ReloadSpeedMultiplier:
			val = 0.8f;
			return true;
		case AttachmentParam.DrawSpeedMultiplier:
			val = 0.7f;
			return true;
		case AttachmentParam.OverallRecoilMultiplier:
			val = 1.1f;
			return true;
		default:
			val = 0f;
			return false;
		}
	}

	public bool IsHealable(ItemType item)
	{
		return item == ItemType.SCP500;
	}
}

using CursorManagement;
using CustomPlayerEffects;
using InventorySystem.Items;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

public class Scp956Target : StatusEffectBase, IMovementSpeedModifier, ICursorOverride, IInteractionBlocker, IHolidayEffect
{
	public enum EffectReason
	{
		None = 0,
		Child = 254,
		HasCandy = 255
	}

	private float _activeTime;

	[SerializeField]
	private AudioSource _musicSource;

	[SerializeField]
	private AudioClip _shortClip;

	[SerializeField]
	private AudioClip _longClip;

	public bool IsAffected
	{
		get
		{
			float num = ((base.Intensity != byte.MaxValue) ? 2.2f : 10f);
			float num2 = num;
			if (base.IsEnabled)
			{
				return (double)_activeTime > (double)num2 - NetworkTime.rtt;
			}
			return false;
		}
	}

	public Vector3 Position => (base.Hub.roleManager.CurrentRole as HumanRole).FpcModule.Position;

	public bool MovementModifierActive => IsAffected;

	public float MovementSpeedMultiplier => 0f;

	public float MovementSpeedLimit => 0f;

	public CursorOverrideMode CursorOverride => CursorOverrideMode.NoOverride;

	public bool LockMovement => IsAffected;

	public BlockedInteraction BlockedInteractions => BlockedInteraction.All;

	public bool CanBeCleared => !base.IsEnabled;

	public HolidayType[] TargetHolidays { get; } = new HolidayType[2]
	{
		HolidayType.Christmas,
		HolidayType.AprilFools
	};

	public override EffectClassification Classification => EffectClassification.Technical;

	protected override void Start()
	{
		base.Start();
	}

	protected override void Enabled()
	{
		base.Enabled();
		_musicSource.Stop();
		_musicSource.volume = 1f;
		_musicSource.loop = false;
		switch ((EffectReason)base.Intensity)
		{
		case EffectReason.HasCandy:
			_musicSource.PlayOneShot(_longClip);
			break;
		case EffectReason.Child:
			_musicSource.PlayOneShot(_shortClip);
			break;
		}
		Scp956Pinata.IsSpawned = true;
		if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
		{
			fpcRole.FpcModule.Motor.RegisterMovementLock(this);
		}
	}

	protected override void Disabled()
	{
		base.Disabled();
		if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
		{
			fpcRole.FpcModule.Motor.UnregisterMovementLock(this);
		}
	}

	protected override void Update()
	{
		base.Update();
		_musicSource.mute = !base.IsLocalPlayer && !base.IsSpectated;
		if (base.IsEnabled)
		{
			_activeTime += Time.deltaTime;
			if (IsAffected)
			{
				if (NetworkServer.active || base.IsLocalPlayer)
				{
					base.Hub.interCoordinator.AddBlocker(this);
				}
				if (NetworkServer.active)
				{
					base.Hub.inventory.ServerSelectItem(0);
				}
				if (base.IsLocalPlayer)
				{
					LookAtPinata();
				}
				if (!_musicSource.loop)
				{
					_musicSource.loop = true;
					_musicSource.volume = 1f;
					_musicSource.Stop();
					_musicSource.Play();
				}
			}
			return;
		}
		_activeTime = 0f;
		if (_musicSource.isPlaying)
		{
			_musicSource.volume -= Time.deltaTime * 3f;
			if (_musicSource.volume <= 0f)
			{
				_musicSource.Stop();
			}
		}
	}

	private void LookAtPinata()
	{
		Vector3 position = MainCameraController.CurrentCamera.position;
		Vector3 eulerAngles = Quaternion.LookRotation(Scp956Pinata.LastPosition - position, Vector3.up).eulerAngles;
		if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
		{
			FpcMouseLook mouseLook = fpcRole.FpcModule.MouseLook;
			mouseLook.CurrentHorizontal = Mathf.LerpAngle(mouseLook.CurrentHorizontal, eulerAngles.y, Time.deltaTime * 4f);
			mouseLook.CurrentVertical = Mathf.LerpAngle(mouseLook.CurrentVertical, 0f - eulerAngles.x, Time.deltaTime * 4f);
		}
	}
}

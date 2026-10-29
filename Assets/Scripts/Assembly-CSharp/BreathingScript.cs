using GameCore;
using GameObjectPools;
using MapGeneration.Holidays;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp106;
using PlayerRoles.PlayableScps.Scp3114;
using UnityEngine;

public class BreathingScript : MonoBehaviour, IPoolResettable
{
	[SerializeField]
	private float _breatheDelay = 2.2f;

	[SerializeField]
	private float _breatheDuration = 0.5f;

	[SerializeField]
	private float _sprintBreatheDelay = 0.3f;

	[SerializeField]
	private float _sprintBreatheDuration = 0.2f;

	private float _breathTimer;

	private bool _breathing;

	private ParticleSystem _particleSystem;

	private ReferenceHub _hub;

	private PlayerRoleBase _lastRole;

	private bool IsSprinting => (_lastRole as IFpcRole).FpcModule.CurrentMovementState == PlayerMovementState.Sprinting;

	private bool CanBreath
	{
		get
		{
			if (_hub == null && !ReferenceHub.TryGetHub(base.transform.root.gameObject, out _hub))
			{
				return false;
			}
			RoleTypeId roleId = _hub.GetRoleId();
			bool flag = roleId == RoleTypeId.Scp3114 || roleId == RoleTypeId.Scp106 || roleId.IsHuman();
			if (roleId == RoleTypeId.Scp106)
			{
				if (_lastRole is Scp106Role scp106Role && scp106Role.IsStalking)
				{
					return false;
				}
			}
			else if (roleId == RoleTypeId.Scp3114 && _lastRole is Scp3114Role scp3114Role && !scp3114Role.Disguised)
			{
				return false;
			}
			if (_lastRole != null && _lastRole.RoleTypeId == roleId)
			{
				return flag;
			}
			_lastRole = _hub.roleManager.CurrentRole;
			if (!_hub.isLocalPlayer)
			{
				base.transform.localPosition = ((roleId == RoleTypeId.Scp106) ? new Vector3(0f, 0.13f, 0.25f) : new Vector3(0f, 0.03f, 0f));
			}
			if (!flag)
			{
				_particleSystem.Stop();
			}
			return flag;
		}
	}

	public void ResetObject()
	{
		_hub = null;
		_lastRole = null;
		_particleSystem.Stop();
	}

	private void Awake()
	{
		if (Version.ActiveHoliday == HolidayType.Christmas)
		{
			_particleSystem = GetComponent<ParticleSystem>();
		}
		else
		{
			Object.Destroy(base.gameObject);
		}
	}

	private void Update()
	{
		if (!CanBreath)
		{
			return;
		}
		_breathTimer += Time.deltaTime;
		if (_breathing)
		{
			if (!((IsSprinting ? _sprintBreatheDuration : _breatheDuration) > _breathTimer))
			{
				_particleSystem.Stop();
				_breathing = false;
				_breathTimer = 0f;
			}
		}
		else if (!((IsSprinting ? _sprintBreatheDelay : _breatheDelay) > _breathTimer))
		{
			_particleSystem.Play();
			_breathing = true;
			_breathTimer = 0f;
		}
	}
}

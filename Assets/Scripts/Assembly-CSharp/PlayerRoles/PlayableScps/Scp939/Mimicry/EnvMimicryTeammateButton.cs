using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class EnvMimicryTeammateButton : EnvMimicryStandardButton
	{
		[SerializeField]
		private RoleTypeId _targetRole;

		private bool _isActive;

		private bool _eventAssigned;

		private bool EventAssigned
		{
			get
			{
				return _eventAssigned;
			}
			set
			{
				if (EventAssigned != value)
				{
					if (value)
					{
						PlayerRoleManager.OnRoleChanged += OnRoleChanged;
					}
					else
					{
						PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
					}
					_eventAssigned = value;
				}
			}
		}

		protected override bool IsAvailable => _isActive;

		protected override void Awake()
		{
			base.Awake();
			if (ReferenceHub.AllHubs.Any((ReferenceHub x) => x.GetRoleId() == _targetRole))
			{
				_isActive = true;
			}
			else
			{
				EventAssigned = true;
			}
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			EventAssigned = false;
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (newRole.RoleTypeId == _targetRole)
			{
				_isActive = true;
				EventAssigned = false;
			}
		}
	}
}

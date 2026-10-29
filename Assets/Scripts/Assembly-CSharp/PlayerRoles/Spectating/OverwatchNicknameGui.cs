using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp079;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchNicknameGui : MonoBehaviour
	{
		[SerializeField]
		private RectTransform _fullscreenRect;

		[SerializeField]
		private RectTransform _template;

		private NicknameGuiDrawer _nicknameGuiDrawer;

		private Transform _cam;

		private void Start()
		{
			Camera main = Camera.main;
			_nicknameGuiDrawer = base.gameObject.AddComponent<NicknameGuiDrawer>();
			_nicknameGuiDrawer.Init(main, _fullscreenRect, _template, forceShowNicknames: true);
			if (main != null)
			{
				_cam = main.transform;
			}
		}

		// Draws nickname boxes over every visible player except the one being spectated.
		private void LateUpdate()
		{
			if (_cam == null)
			{
				return;
			}
			_nicknameGuiDrawer.ClearAll();
			uint netId = (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub) ? hub.netId : 0u);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.netId != netId && allHub.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase)
				{
					PlayerRoleBase currentRole = allHub.roleManager.CurrentRole;
					bool isScp = currentRole.Team == Team.SCPs && currentRole.RoleTypeId != RoleTypeId.Scp0492;
					_nicknameGuiDrawer.TryDrawPlayer(fpcStandardRoleBase.FpcModule.CharacterModelInstance, allHub.nicknameSync.DisplayName, 1f, _cam.transform.position, isScp);
				}
			}
		}

		private void OnDestroy()
		{
			_nicknameGuiDrawer.ClearAll();
		}
	}
}

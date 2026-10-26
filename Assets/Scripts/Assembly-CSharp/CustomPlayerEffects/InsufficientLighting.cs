using Mirror;
using PlayerRoles;
using RemoteAdmin.Interfaces;
using UserSettings;
using UserSettings.VideoSettings;

namespace CustomPlayerEffects
{
	public class InsufficientLighting : StatusEffectBase, ICustomDisplayName
	{
		private static readonly CachedUserSetting<bool> RenderLights = new CachedUserSetting<bool>(LightingVideoSetting.RenderLights);

		private bool _prevTarget;

		private const float NoLightsAmbient = 0.03f;

		private PlayerRoleBase CurRole => base.Hub.roleManager.CurrentRole;

		public string DisplayName { get; }

		public bool CanBeDisplayed { get; }

		public override EffectClassification Classification => EffectClassification.Technical;

		public static float DefaultIntensity => 0f;

		internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			base.OnRoleChanged(previousRole, newRole);
			_prevTarget = false;
		}

		protected override void Start()
		{
			base.Start();
			StaticUnityMethods.OnUpdate += AlwaysUpdate;
		}

		private void OnDestroy()
		{
			StaticUnityMethods.OnUpdate -= AlwaysUpdate;
		}

		private void AlwaysUpdate()
		{
			if (NetworkServer.active)
			{
				UpdateServer();
			}
		}

		private void UpdateServer()
		{
			bool flag = CurRole is IAmbientLightRole ambientLightRole && ambientLightRole.InsufficientLight;
			if (flag != _prevTarget)
			{
				base.Intensity = (byte)(flag ? 1u : 0u);
				_prevTarget = flag;
			}
		}
	}
}

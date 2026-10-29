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

		public static float DefaultIntensity => RenderLights.Value ? 0f : NoLightsAmbient;

		internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			base.OnRoleChanged(previousRole, newRole);
			_prevTarget = false;
		}

		// Client half restored from the client build (IL2CPP): the effect object carries a Volume with an interior
		// GradientSky (ambient light). For the local player it follows the rooms' stacked ambient colors plus the
		// current role's ambient boost.
		private const float LightLerpSpeed = 7f;

		private UnityEngine.Rendering.HighDefinition.GradientSky _skyInterior;

		private UnityEngine.Rendering.Volume _volume;

		protected override void Start()
		{
			base.Start();
			StaticUnityMethods.OnUpdate += AlwaysUpdate;
			_volume = GetComponent<UnityEngine.Rendering.Volume>();
			if (_volume != null && base.Hub.isLocalPlayer && _volume.profile != null)
			{
				_volume.profile.TryGet(out _skyInterior);
			}
		}

		private void UpdateLocal()
		{
			if (_skyInterior == null)
			{
				return;
			}
			// Matches the client build: the role's ambient boost (0.2 for SCPs in the dark, night vision, ...) is added
			// to every gradient colour, and ForceBlackAmbient replaces the room colours with black.
			float boost = DefaultIntensity;
			bool forceBlack = false;
			if (CurRole is IAmbientLightRole ambientLightRole)
			{
				boost = ambientLightRole.AmbientBoost;
				forceBlack = ambientLightRole.ForceBlackAmbient;
			}
			UnityEngine.Color top;
			UnityEngine.Color mid;
			UnityEngine.Color bottom;
			float diffusion = 1f;
			if (forceBlack)
			{
				top = mid = bottom = new UnityEngine.Color(0f, 0f, 0f, 1f);
			}
			else
			{
				StackableGradientSky.GetCombinedColor(out top, out mid, out bottom, out diffusion);
			}
			UnityEngine.Color add = new UnityEngine.Color(boost, boost, boost, boost);
			top += add;
			mid += add;
			bottom += add;
			float t = UnityEngine.Time.deltaTime * LightLerpSpeed;
			LerpTo(_skyInterior.top, top, t);
			LerpTo(_skyInterior.middle, mid, t);
			LerpTo(_skyInterior.bottom, bottom, t);
			_skyInterior.gradientDiffusion.Override(UnityEngine.Mathf.MoveTowards(_skyInterior.gradientDiffusion.value, diffusion, t));
			// The prefab ships this Volume disabled; the client turns it on whenever the target gradient is not pure black.
			UnityEngine.Color black = new UnityEngine.Color(0f, 0f, 0f, 1f);
			_volume.enabled = !(IsNear(top, black) && IsNear(mid, black) && IsNear(bottom, black));
		}

		private static bool IsNear(UnityEngine.Color a, UnityEngine.Color b)
		{
			UnityEngine.Color d = a - b;
			return d.r * d.r + d.g * d.g + d.b * d.b + d.a * d.a < 1E-10f;
		}

		private static void LerpTo(UnityEngine.Rendering.ColorParameter param, UnityEngine.Color target, float t)
		{
			param.Override(UnityEngine.Color.Lerp(param.value, target, UnityEngine.Mathf.Clamp01(t)));
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
			if (base.Hub != null && base.Hub.isLocalPlayer)
			{
				UpdateLocal();
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

using System;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Spectating
{
	// Client-only in the original (stripped from the server build): while spectating, the HUD stat bars
	// show the spectated player's stats, with the health bar tinted in their role colour.
	public class SpectatorStatBarEmulator : MonoBehaviour
	{
		private static readonly Type[] RecolorableModules = new Type[1] { typeof(HealthStat) };

		private GameObject _statsRoot;

		private void Start()
		{
			SpectatorTargetTracker.OnTargetChanged += OnTargetChanged;
			_statsRoot = UserMainInterface.singleton.PlyStats;
		}

		private void OnDestroy()
		{
			SpectatorTargetTracker.OnTargetChanged -= OnTargetChanged;
		}

		private void OnTargetChanged()
		{
			if (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub) && hub.roleManager.CurrentRole is IHealthbarRole)
			{
				_statsRoot.SetActive(value: true);
				StatSliderManager.TryForEach(delegate(StatSlider slider)
				{
					OnTargetSwitched(hub, slider);
				});
			}
			else if (_statsRoot != null)
			{
				_statsRoot.SetActive(value: false);
			}
		}

		private static void OnTargetSwitched(ReferenceHub hub, StatSlider slider)
		{
			if (slider.TryGetModule(out _))
			{
				slider.ForceUpdate();
				if (slider.gameObject.TryGetComponent<StatusBar>(out var component))
				{
					component.UpdateBar(bypassAnims: true);
				}
			}
			if (slider.TryGetModule(out var sb) && Array.IndexOf(RecolorableModules, sb.GetType()) >= 0)
			{
				Color roleColor = hub.roleManager.CurrentRole.RoleColor;
				slider.gameObject.ForEachComponentInChildren(delegate(Graphic g)
				{
					RecolorRetainAlpha(g, roleColor);
				}, includeInactive: true);
			}
		}

		private static void RecolorRetainAlpha(Graphic target, Color toApply)
		{
			target.color = new Color(toApply.r, toApply.g, toApply.b, target.color.a);
		}
	}
}

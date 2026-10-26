using System.Collections.Generic;
using PlayerRoles;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace FacilitySoundtrack.ChaseThemes
{
	public static class ChaseThemeProviders
	{
		public static readonly List<IChaseThemeProvider> Instances = new List<IChaseThemeProvider>();

		public static bool IsValid(this IChaseThemeProvider provider)
		{
			if (provider == null)
			{
				return false;
			}
			if (provider is Object obj && obj == null)
			{
				return false;
			}
			if (!Instances.Contains(provider))
			{
				return false;
			}
			return true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		private static void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (TryFindProvider(prevRole, out var provider))
			{
				Instances.Remove(provider);
			}
			if (TryFindProvider(newRole, out var provider2))
			{
				Instances.Add(provider2);
			}
		}

		private static bool TryFindProvider(PlayerRoleBase prb, out IChaseThemeProvider provider)
		{
			if (prb is ISubroutinedRole subroutinedRole)
			{
				SubroutineBase[] allSubroutines = subroutinedRole.SubroutineModule.AllSubroutines;
				for (int i = 0; i < allSubroutines.Length; i++)
				{
					if (allSubroutines[i] is IChaseThemeProvider chaseThemeProvider)
					{
						provider = chaseThemeProvider;
						return true;
					}
				}
			}
			provider = null;
			return false;
		}
	}
}

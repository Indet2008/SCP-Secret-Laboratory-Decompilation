using System;
using System.Collections.Generic;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson
{
	public static class ThirdpersonItemAnimationManager
	{
		private static readonly List<KeyValuePair<AnimationClip, AnimationClip>> OverridesPuller = new List<KeyValuePair<AnimationClip, AnimationClip>>();

		private static readonly Dictionary<AnimState3p, AnimationClip> CachedClips = new Dictionary<AnimState3p, AnimationClip>();

		public static bool TryGetDefaultAnimation(AnimatedCharacterModel target, AnimState3p name, out AnimationClip clip)
		{
			if (CachedClips.TryGetValue(name, out clip))
			{
				return true;
			}
			clip = null;
			OverridesPuller.Clear();
			target.AnimatorOverride.GetOverrides(OverridesPuller);
			foreach (KeyValuePair<AnimationClip, AnimationClip> item in OverridesPuller)
			{
				if (Enum.TryParse<AnimState3p>(item.Key.name, out var result))
				{
					if (result == name)
					{
						clip = item.Key;
					}
					CachedClips[result] = item.Key;
				}
			}
			return clip != null;
		}

		public static void ResetOverrides(AnimatedCharacterModel target, Dictionary<AnimationClip, AnimationClip> defaultOverrides)
		{
			OverridesPuller.Clear();
			target.AnimatorOverride.GetOverrides(OverridesPuller);
			for (int i = 0; i < OverridesPuller.Count; i++)
			{
				AnimationClip key = OverridesPuller[i].Key;
				AnimationClip value;
				if (defaultOverrides != null)
				{
					defaultOverrides.TryGetValue(key, out value);
				}
				else
				{
					value = null;
				}
				OverridesPuller[i] = new KeyValuePair<AnimationClip, AnimationClip>(key, value);
			}
			target.AnimatorOverride.ApplyOverrides(OverridesPuller);
		}

		public static void SetAnimation(AnimatedCharacterModel target, AnimState3p name, AnimationClip clip)
		{
			if (TryGetDefaultAnimation(target, name, out var clip2))
			{
				target.AnimatorOverride[clip2] = clip;
			}
		}

		public static void SetAnimation(AnimatedCharacterModel target, AnimOverrideState3pPair pair)
		{
			SetAnimation(target, pair.State, pair.Override);
		}
	}
}

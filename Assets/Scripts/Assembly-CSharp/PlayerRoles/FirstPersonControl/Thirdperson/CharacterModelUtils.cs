using System;
using System.Collections.Generic;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using PlayerRoles.Ragdolls;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson
{
	public static class CharacterModelUtils
	{
		private static readonly List<ModelReferencePoint> ModelRefResultNonAlloc = new List<ModelReferencePoint>();

		private static readonly Dictionary<Material, int[]> TextureHashes = new Dictionary<Material, int[]>();

		private static readonly List<Renderer> RenderersNonAlloc = new List<Renderer>();

		private static readonly List<Material> MaterialsNonAlloc = new List<Material>();

		private static readonly int[] FloatsToCopy = new int[1] { Shader.PropertyToID("_UseMaskMap") };

		public static bool TryGetWearableSubcontroller<T>(this ReferenceHub userHub, out T subcontroller) where T : class
		{
			if (!(userHub.roleManager.CurrentRole is IFpcRole role))
			{
				subcontroller = null;
				return false;
			}
			if (!role.TryGetRpcTarget(out var target))
			{
				subcontroller = null;
				return false;
			}
			return target.TryGetSubcontroller<T>(out subcontroller);
		}

		public static void ConvertRagdoll(BasicRagdoll ragdoll, Func<Renderer, List<Material>, bool> filter, Material template, List<Material> appliedMaterials)
		{
			appliedMaterials.Clear();
			RenderersNonAlloc.Clear();
			ragdoll.GetComponentsInChildren(includeInactive: true, RenderersNonAlloc);
			foreach (Renderer item in RenderersNonAlloc)
			{
				if (item is ParticleSystemRenderer)
				{
					continue;
				}
				item.GetSharedMaterials(MaterialsNonAlloc);
				if (filter == null || filter(item, MaterialsNonAlloc))
				{
					int count = MaterialsNonAlloc.Count;
					Material[] array = new Material[count];
					for (int i = 0; i < count; i++)
					{
						array[i] = ConvertShader(item.sharedMaterials[i], template);
					}
					item.materials = array;
					appliedMaterials.AddRange(array);
				}
			}
		}

		public static Material ConvertShader(Material original, Material shaderTemplate)
		{
			int[] orAdd = TextureHashes.GetOrAdd(shaderTemplate, () => shaderTemplate.GetTexturePropertyNameIDs());
			Material result = new Material(shaderTemplate);
			CopyProperties(orAdd, original, result, (Material og, int hash) => og.HasTexture(hash), (Material og, int hash, Material res) =>
			{
				res.SetTexture(hash, og.GetTexture(hash));
			});
			CopyProperties(FloatsToCopy, original, result, (Material og, int hash) => og.HasFloat(hash), (Material og, int hash, Material res) =>
			{
				res.SetFloat(hash, og.GetFloat(hash));
			});
			return result;
		}

		public static List<ModelReferencePoint> GetHardpointsOfType(this CharacterModel model, RefpointType filter)
		{
			model.GetHardpointsOfType(filter, ModelRefResultNonAlloc);
			return ModelRefResultNonAlloc;
		}

		public static void GetHardpointsOfType(this CharacterModel model, RefpointType filter, List<ModelReferencePoint> result)
		{
			result.Clear();
			ModelReferencePoint[] hardpoints = model.Hardpoints;
			foreach (ModelReferencePoint modelReferencePoint in hardpoints)
			{
				if (modelReferencePoint.Type.HasFlagFast(filter))
				{
					result.Add(modelReferencePoint);
				}
			}
		}

		public static bool HasFlagFast(this RefpointType val, RefpointType checkFlag)
		{
			return (val & checkFlag) == checkFlag;
		}

		private static void CopyProperties(int[] ids, Material original, Material result, Func<Material, int, bool> hasChecker, Action<Material, int, Material> applier)
		{
			foreach (int arg in ids)
			{
				if (hasChecker(original, arg))
				{
					applier(original, arg, result);
				}
			}
		}
	}
}

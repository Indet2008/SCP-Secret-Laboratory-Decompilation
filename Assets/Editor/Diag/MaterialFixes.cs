using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

// Repairs material data lost by the asset ripper.
public static class MaterialFixes
{
	private static readonly string[] LinearMapProperties =
	{
		"_MaskMap", "_ThicknessMap", "_SubsurfaceMaskMap", "_TransmissionMaskMap", "_CoatMaskMap",
		"_HeightMap", "_DetailMap", "_AnisotropyMap", "_IridescenceMaskMap", "_IridescenceThicknessMap"
	};

	private static readonly string[] ColorMapProperties = { "_BaseColorMap", "_MainTex", "_EmissiveColorMap", "_SpecularColorMap" };

	[MenuItem("Tools/Decompile Fixes/Run All Material Fixes")]
	public static void RunAll()
	{
		var log = new StringBuilder();
		RegisterDiffusionProfiles(log);
		AssignMissingDiffusionProfiles(log);
		FixLinearTextures(log);
		AssetDatabase.SaveAssets();
		Debug.Log(log.ToString());
		string outPath = System.Environment.GetEnvironmentVariable("MATFIX_OUT");
		if (!string.IsNullOrEmpty(outPath))
		{
			System.IO.File.WriteAllText(outPath, log.ToString());
		}
	}

	private static DiffusionProfileSettings LoadProfile(string name)
	{
		return AssetDatabase.LoadAssetAtPath<DiffusionProfileSettings>("Assets/MonoBehaviour/" + name + ".asset");
	}

	private static void RegisterDiffusionProfiles(StringBuilder log)
	{
		var wanted = new[] { "Skin Diffusion Profile", "Head Diffusion Profile", "Hands Diffusion Profile", "Foliage Diffusion Profile", "OrangeCandy Profile", "OrangeWitness Profile" }
			.Select(LoadProfile).Where(p => p != null).ToList();
		var profiles = new List<VolumeProfile>();
		foreach (string guid in AssetDatabase.FindAssets("t:VolumeProfile", new[] { "Assets" }))
		{
			var vp = AssetDatabase.LoadAssetAtPath<VolumeProfile>(AssetDatabase.GUIDToAssetPath(guid));
			if (vp != null && vp.TryGet<DiffusionProfileList>(out _))
			{
				profiles.Add(vp);
			}
		}
		foreach (VolumeProfile vp in profiles)
		{
			vp.TryGet<DiffusionProfileList>(out var list);
			var current = (list.diffusionProfiles.value ?? new DiffusionProfileSettings[0]).Where(p => p != null).ToList();
			foreach (var p in wanted)
			{
				if (!current.Contains(p) && current.Count < 15)
				{
					current.Add(p);
				}
			}
			list.diffusionProfiles.overrideState = true;
			list.diffusionProfiles.value = current.ToArray();
			EditorUtility.SetDirty(vp);
			log.AppendLine("Diffusion list in " + AssetDatabase.GetAssetPath(vp) + ": " + string.Join(", ", current.Select(p => p.name)));
		}
	}

	private static void AssignMissingDiffusionProfiles(StringBuilder log)
	{
		DiffusionProfileSettings hands = LoadProfile("Hands Diffusion Profile");
		DiffusionProfileSettings skin = LoadProfile("Skin Diffusion Profile");
		foreach (string guid in AssetDatabase.FindAssets("t:Material", new[] { "Assets/Material" }))
		{
			string path = AssetDatabase.GUIDToAssetPath(guid);
			var mat = AssetDatabase.LoadAssetAtPath<Material>(path);
			if (mat == null || !mat.HasProperty("_DiffusionProfileHash"))
			{
				continue;
			}
			bool usesProfile = mat.IsKeywordEnabled("_MATERIAL_FEATURE_SUBSURFACE_SCATTERING") || mat.IsKeywordEnabled("_MATERIAL_FEATURE_TRANSMISSION");
			if (!usesProfile || mat.GetFloat("_DiffusionProfileHash") != 0f)
			{
				continue;
			}
			string lower = mat.name.ToLowerInvariant();
			DiffusionProfileSettings profile = (lower.Contains("hand") ? hands : (lower.Contains("skin") || lower.Contains("head") || lower.Contains("face")) ? skin : null);
			if (profile == null)
			{
				log.AppendLine("SKIP (no matching profile): " + path);
				continue;
			}
			HDMaterial.SetDiffusionProfile(mat, profile);
			HDMaterial.ValidateMaterial(mat);
			EditorUtility.SetDirty(mat);
			log.AppendLine("Diffusion profile " + profile.name + " -> " + path);
		}
	}

	private static void FixLinearTextures(StringBuilder log)
	{
		var linear = new HashSet<string>();
		var color = new HashSet<string>();
		foreach (string guid in AssetDatabase.FindAssets("t:Material", new[] { "Assets/Material" }))
		{
			var mat = AssetDatabase.LoadAssetAtPath<Material>(AssetDatabase.GUIDToAssetPath(guid));
			if (mat == null || mat.shader == null || !mat.shader.name.StartsWith("HDRP/"))
			{
				continue;
			}
			foreach (string prop in LinearMapProperties)
			{
				if (mat.HasProperty(prop) && mat.GetTexture(prop) is Texture2D t)
				{
					linear.Add(AssetDatabase.GetAssetPath(t));
				}
			}
			foreach (string prop in ColorMapProperties)
			{
				if (mat.HasProperty(prop) && mat.GetTexture(prop) is Texture2D t)
				{
					color.Add(AssetDatabase.GetAssetPath(t));
				}
			}
		}
		int changed = 0;
		foreach (string path in linear)
		{
			if (color.Contains(path) || !(AssetImporter.GetAtPath(path) is TextureImporter importer))
			{
				continue;
			}
			if (importer.sRGBTexture && importer.textureType == TextureImporterType.Default)
			{
				importer.sRGBTexture = false;
				importer.SaveAndReimport();
				changed++;
			}
		}
		log.AppendLine("Linear data textures switched off sRGB: " + changed + " / " + linear.Count);
	}
}

using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

// Materials that were transparent in the original game but came out of the ripper as opaque HDRP/Lit.
// Their albedo alpha still holds the original transparency (e.g. SCP-2176's glass is ~0.3, the metal base 1.0).
[InitializeOnLoad]
public static class TransparentMaterialFixes
{
	// Mat_2176 was removed: its original HDRP/Lit values are now restored from the game data,
	// and the glass look comes from MultiPassDistortion ("Shader Graphs/scp 2176").
	private static readonly string[] Materials = { };

	static TransparentMaterialFixes()
	{
		EditorApplication.delayCall += () => Apply(force: false);
	}

	[MenuItem("Tools/Decompile Fixes/Make Glass Materials Transparent")]
	public static void ApplyFromMenu()
	{
		Apply(force: true);
	}

	private static void Apply(bool force)
	{
		bool changed = false;
		foreach (string path in Materials)
		{
			Material material = AssetDatabase.LoadAssetAtPath<Material>(path);
			if (material == null || !material.HasProperty("_SurfaceType"))
			{
				continue;
			}
			if (!force && material.GetFloat("_SurfaceType") == 1f)
			{
				continue;
			}
			HDMaterial.SetSurfaceType(material, transparent: true);
			material.SetFloat("_BlendMode", 0f); // Alpha
			material.SetFloat("_EnableBlendModePreserveSpecularLighting", 1f);
			material.SetFloat("_TransparentDepthPrepassEnable", 1f);
			HDMaterial.ValidateMaterial(material);
			EditorUtility.SetDirty(material);
			changed = true;
			Debug.Log("[TransparentMaterialFixes] Made " + path + " transparent.");
		}
		if (changed)
		{
			AssetDatabase.SaveAssets();
		}
	}
}

using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;

// The ripped VFX graphs reference compiled compute shaders (Assets/ComputeShader/_*.asset) that run in the editor
// but are rejected by the player build ("was not imported correctly"). For the build only, point them at an empty
// stub kernel, then put the original references back so the effects keep working in the editor.
public class VfxRippedComputeBuildSwap : IPreprocessBuildWithReport, IPostprocessBuildWithReport
{
	private const string VfxFolder = "Assets/VisualEffectAsset";

	private const string RippedComputeGlob = "_*.asset.meta";

	private const string StubGuid = "85240774b91e444fab380c72409f34e6";

	private static readonly Dictionary<string, string> Originals = new Dictionary<string, string>();

	public int callbackOrder => 0;

	public void OnPreprocessBuild(BuildReport report)
	{
		Originals.Clear();
		List<string> rippedGuids = new List<string>();
		foreach (string meta in Directory.GetFiles("Assets/ComputeShader", RippedComputeGlob))
		{
			foreach (string line in File.ReadAllLines(meta))
			{
				if (line.StartsWith("guid: "))
				{
					rippedGuids.Add(line.Substring(6).Trim());
				}
			}
		}
		foreach (string path in Directory.GetFiles(VfxFolder, "*.asset"))
		{
			string text = File.ReadAllText(path);
			string swapped = text;
			foreach (string guid in rippedGuids)
			{
				swapped = swapped.Replace("guid: " + guid + ", type: 2", "guid: " + StubGuid + ", type: 3");
			}
			if (swapped != text)
			{
				Originals[path] = text;
				File.WriteAllText(path, swapped);
			}
		}
		Reimport();
		// A failed build skips OnPostprocessBuild; restore after the build either way.
		EditorApplication.delayCall += Restore;
	}

	public void OnPostprocessBuild(BuildReport report)
	{
		Restore();
	}

	private static void Restore()
	{
		if (Originals.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<string, string> pair in Originals)
		{
			File.WriteAllText(pair.Key, pair.Value);
		}
		Reimport();
		Originals.Clear();
	}

	private static void Reimport()
	{
		foreach (string path in Originals.Keys)
		{
			AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);
		}
	}
}

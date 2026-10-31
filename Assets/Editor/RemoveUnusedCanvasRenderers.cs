using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

// Ripped prefabs keep CanvasRenderers on 3D TextMeshPro objects (and on objects with no UI Graphic at all), which makes
// TMP log "Please remove the CanvasRenderer component ... no longer necessary" every time they are instantiated.
public static class RemoveUnusedCanvasRenderers
{
	[MenuItem("Tools/SCPSL/Remove Unused CanvasRenderers")]
	private static void Run()
	{
		int removed = 0;
		int prefabs = 0;
		string[] guids = AssetDatabase.FindAssets("t:Prefab", new[] { "Assets" });
		try
		{
			for (int i = 0; i < guids.Length; i++)
			{
				string path = AssetDatabase.GUIDToAssetPath(guids[i]);
				if (EditorUtility.DisplayCancelableProgressBar("Remove Unused CanvasRenderers", path, (float)i / guids.Length))
				{
					break;
				}
				GameObject root = PrefabUtility.LoadPrefabContents(path);
				int before = removed;
				foreach (CanvasRenderer renderer in root.GetComponentsInChildren<CanvasRenderer>(true))
				{
					// Components that come from a nested prefab are cleaned when that prefab itself is processed.
					// TextMeshPro (3D) derives from Graphic but renders through a MeshRenderer, and it is what logs the warning.
					bool unused = renderer.GetComponent<Graphic>() == null || renderer.GetComponent<TMPro.TextMeshPro>() != null;
					if (unused && !PrefabUtility.IsPartOfPrefabInstance(renderer))
					{
						Object.DestroyImmediate(renderer);
						removed++;
					}
				}
				if (removed != before)
				{
					PrefabUtility.SaveAsPrefabAsset(root, path);
					prefabs++;
				}
				PrefabUtility.UnloadPrefabContents(root);
			}
		}
		finally
		{
			EditorUtility.ClearProgressBar();
		}
		Debug.Log($"Removed {removed} unused CanvasRenderers from {prefabs} prefabs.");
	}
}

using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

// Batchmode diagnostic: reports how Unity resolves the scripts referenced by prefabs.
// Run with: Unity.exe -batchmode -projectPath <proj> -executeMethod MissingScriptDiag.Run -quit
public static class MissingScriptDiag
{
	public static void Run()
	{
		StringBuilder report = new StringBuilder();
		int missingTotal = 0;
		int prefabsWithMissing = 0;
		var missingGuids = new Dictionary<string, int>();
		foreach (string scenePath in new[] { "Assets/_Scenes/PreLoader.unity", "Assets/_Scenes/Loader.unity", "Assets/_Scenes/NewMainMenu.unity", "Assets/_Scenes/Facility.unity" })
		{
			var scene = UnityEditor.SceneManagement.EditorSceneManager.OpenScene(scenePath, UnityEditor.SceneManagement.OpenSceneMode.Single);
			int sceneMissing = 0;
			foreach (GameObject sceneRoot in scene.GetRootGameObjects())
			{
				foreach (Transform t in sceneRoot.GetComponentsInChildren<Transform>(true))
				{
					sceneMissing += GameObjectUtility.GetMonoBehavioursWithMissingScriptCount(t.gameObject);
				}
			}
			report.AppendLine($"{scenePath}: {sceneMissing} missing");
		}
		foreach (string guid in AssetDatabase.FindAssets("t:Prefab", new[] { "Assets/GameObject", "Assets/Resources" }))
		{
			string path = AssetDatabase.GUIDToAssetPath(guid);
			GameObject root = AssetDatabase.LoadAssetAtPath<GameObject>(path);
			if (root == null)
			{
				report.AppendLine("LOAD FAILED: " + path);
				continue;
			}
			int missing = 0;
			foreach (Transform t in root.GetComponentsInChildren<Transform>(true))
			{
				missing += GameObjectUtility.GetMonoBehavioursWithMissingScriptCount(t.gameObject);
			}
			if (missing > 0)
			{
				prefabsWithMissing++;
				missingTotal += missing;
				if (prefabsWithMissing <= 20)
				{
					report.AppendLine($"{path}: {missing} missing");
				}
			}
		}
		report.AppendLine($"prefabs with missing scripts: {prefabsWithMissing}, missing components: {missingTotal}");

		// How do the scripts on EZ_GateA's root resolve?
		foreach (string scriptGuid in new[] { "7ab7d2c38045983bfc9bc0ed70e4b2be", "2acc7be7b2bd5350b35a6993ae0805c1", "20e81c46ce5eaf8b5fd1d396ff30d364" })
		{
			string scriptPath = AssetDatabase.GUIDToAssetPath(scriptGuid);
			MonoScript script = AssetDatabase.LoadAssetAtPath<MonoScript>(scriptPath);
			System.Type cls = (script != null) ? script.GetClass() : null;
			report.AppendLine($"guid {scriptGuid} -> path '{scriptPath}' monoscript={(script != null)} class={(cls != null ? cls.FullName : "NULL")}");
		}
		File.WriteAllText("MissingScriptDiag.txt", report.ToString());
		Debug.Log("[MissingScriptDiag]\n" + report);
	}
}

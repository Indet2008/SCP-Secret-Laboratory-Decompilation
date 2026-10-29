using UnityEditor;

// Script changes made while in Play mode are applied only after Play mode ends.
// Note: after any script recompile this project's game assemblies (Assembly-CSharp etc.) are not
// reloaded into the editor domain, so Play hangs on the PreLoader until the editor is restarted.
[InitializeOnLoad]
internal static class PlayModeCompileGuard
{
	// Matches Preferences > General > Script Changes While Playing: "Recompile After Finished Playing".
	private const int RecompileAfterFinishedPlaying = 1;

	static PlayModeCompileGuard()
	{
		if (EditorPrefs.GetInt("ScriptCompilationDuringPlay", 0) != RecompileAfterFinishedPlaying)
		{
			EditorPrefs.SetInt("ScriptCompilationDuringPlay", RecompileAfterFinishedPlaying);
		}
	}
}

using System;
using System.Runtime;
using System.Threading;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class MemoryCleaner
{
	[RuntimeInitializeOnLoadMethod]
	private static void OnLoad()
	{
		SceneManager.sceneLoaded += CleanupMemory;
	}

	private static void CleanupMemory(Scene scene, LoadSceneMode mode)
	{
		Resources.UnloadUnusedAssets();
		Thread thread = new Thread(() =>
		{
			GCSettings.LargeObjectHeapCompactionMode = GCLargeObjectHeapCompactionMode.CompactOnce;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			GC.Collect();
		});
		thread.IsBackground = true;
		thread.Start();
	}
}

namespace Mirror
{
	public static class Utils
	{
		public static uint GetTrueRandomUInt()
		{
			using global::System.Security.Cryptography.RNGCryptoServiceProvider rNGCryptoServiceProvider = new global::System.Security.Cryptography.RNGCryptoServiceProvider();
			byte[] array = new byte[4];
			rNGCryptoServiceProvider.GetBytes(array);
			return global::System.BitConverter.ToUInt32(array, 0);
		}

		public static bool IsPrefab(global::UnityEngine.GameObject obj)
		{
			return false;
		}

		public static bool IsSceneObject(global::Mirror.NetworkIdentity identity)
		{
			if (identity.gameObject.hideFlags != global::UnityEngine.HideFlags.NotEditable && identity.gameObject.hideFlags != global::UnityEngine.HideFlags.HideAndDontSave)
			{
				return identity.sceneId != 0;
			}
			return false;
		}

		public static bool IsSceneObjectWithPrefabParent(global::UnityEngine.GameObject gameObject, out global::UnityEngine.GameObject prefab)
		{
			prefab = null;
			if (prefab == null)
			{
				global::UnityEngine.Debug.LogError("Failed to find prefab parent for scene object [name:" + gameObject.name + "]");
				return false;
			}
			return true;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static bool IsPointInScreen(global::UnityEngine.Vector2 point)
		{
			if (0f <= point.x && point.x < (float)global::UnityEngine.Screen.width && 0f <= point.y)
			{
				return point.y < (float)global::UnityEngine.Screen.height;
			}
			return false;
		}

		public static string PrettyBytes(long bytes)
		{
			if (bytes < 1024)
			{
				return $"{bytes} B";
			}
			if (bytes < 1048576)
			{
				return $"{(float)bytes / 1024f:F2} KB";
			}
			if (bytes < 1073741824)
			{
				return $"{(float)bytes / 1048576f:F2} MB";
			}
			return $"{(float)bytes / 1.0737418E+09f:F2} GB";
		}

		public static string PrettySeconds(double seconds)
		{
			global::System.TimeSpan timeSpan = global::System.TimeSpan.FromSeconds(seconds);
			string text = "";
			if (timeSpan.Days > 0)
			{
				text += $"{timeSpan.Days}d";
			}
			if (timeSpan.Hours > 0)
			{
				text += string.Format("{0}{1}h", (text.Length > 0) ? " " : "", timeSpan.Hours);
			}
			if (timeSpan.Minutes > 0)
			{
				text += string.Format("{0}{1}m", (text.Length > 0) ? " " : "", timeSpan.Minutes);
			}
			if (timeSpan.Milliseconds > 0)
			{
				text += string.Format("{0}{1}.{2}s", (text.Length > 0) ? " " : "", timeSpan.Seconds, timeSpan.Milliseconds / 100);
			}
			else if (timeSpan.Seconds > 0)
			{
				text += string.Format("{0}{1}s", (text.Length > 0) ? " " : "", timeSpan.Seconds);
			}
			if (!(text != ""))
			{
				return "0s";
			}
			return text;
		}

		public static global::Mirror.NetworkIdentity GetSpawnedInServerOrClient(uint netId)
		{
			if (global::Mirror.NetworkServer.active)
			{
				global::Mirror.NetworkServer.spawned.TryGetValue(netId, out var value);
				return value;
			}
			if (global::Mirror.NetworkClient.active)
			{
				global::Mirror.NetworkClient.spawned.TryGetValue(netId, out var value2);
				return value2;
			}
			return null;
		}

		public static global::UnityEngine.Rect KeepInScreen(global::UnityEngine.Rect rect)
		{
			rect.x = global::System.Math.Max(rect.x, 0f);
			rect.y = global::System.Math.Max(rect.y, 0f);
			rect.x = global::System.Math.Min(rect.x, (float)global::UnityEngine.Screen.width - rect.width);
			rect.y = global::System.Math.Min(rect.y, (float)global::UnityEngine.Screen.width - rect.height);
			return rect;
		}

		public static void CreateLocalConnections(out global::Mirror.LocalConnectionToClient connectionToClient, out global::Mirror.LocalConnectionToServer connectionToServer)
		{
			connectionToServer = new global::Mirror.LocalConnectionToServer();
			connectionToClient = new global::Mirror.LocalConnectionToClient();
			connectionToServer.connectionToClient = connectionToClient;
			connectionToClient.connectionToServer = connectionToServer;
		}

		public static bool IsSceneActive(string scene)
		{
			global::UnityEngine.SceneManagement.Scene activeScene = global::UnityEngine.SceneManagement.SceneManager.GetActiveScene();
			if (!(activeScene.path == scene))
			{
				return activeScene.name == scene;
			}
			return true;
		}
	}
}

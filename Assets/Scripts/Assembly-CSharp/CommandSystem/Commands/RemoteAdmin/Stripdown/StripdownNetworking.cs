using System;
using System.IO;
using Mirror;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin.Stripdown
{
	public static class StripdownNetworking
	{
		public struct StripdownResponse : NetworkMessage
		{
			public string[] Lines;
		}

		private static long _lastTime;

		public static bool FileExportEnabled { get; set; }

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<StripdownResponse>(ProcessMessage);
			};
		}

		public static void ProcessMessage(StripdownResponse file)
		{
			file.Lines.ForEach((string x) =>
			{
				Debug.Log(x);
			});
			if (FileExportEnabled)
			{
				long num = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
				if (num == _lastTime)
				{
					Debug.LogError("Stripdown file creation rate limited.");
					return;
				}
				File.WriteAllLines($"{Application.dataPath}/{num}.txt", file.Lines);
				_lastTime = num;
			}
		}
	}
}

public static class CustomMusicLoader
{
	private static string _musicPath = global::System.IO.Directory.GetCurrentDirectory() + global::System.IO.Path.DirectorySeparatorChar + "music" + global::System.IO.Path.DirectorySeparatorChar;

	public static void LoadCustomAudio()
	{
		if (!global::System.IO.Directory.Exists(_musicPath))
		{
			global::System.IO.Directory.CreateDirectory(_musicPath);
			return;
		}
		string[] files = global::System.IO.Directory.GetFiles(_musicPath, "*", new global::System.IO.EnumerationOptions());
		foreach (string text in files)
		{
			global::UnityEngine.AudioType audioType = Misc.GetAudioType(text);
			if (audioType == global::UnityEngine.AudioType.WAV || audioType == global::UnityEngine.AudioType.OGGVORBIS || audioType == global::UnityEngine.AudioType.MPEG)
			{
				ProcessLocalFile(text, audioType);
			}
		}
	}

	private static async void ProcessLocalFile(string file, global::UnityEngine.AudioType type)
	{
		using global::UnityEngine.Networking.UnityWebRequest request = new global::UnityEngine.Networking.UnityWebRequest("file://" + file, "GET", new global::UnityEngine.Networking.DownloadHandlerAudioClip("file://" + file, type), null);
		request.SendWebRequest();
		while (!request.isDone)
		{
			await global::System.Threading.Tasks.Task.Yield();
		}
		if (!string.IsNullOrEmpty(request.error))
		{
			global::UnityEngine.Debug.Log("Error with processing custom track: " + request.error);
			return;
		}
		global::UnityEngine.AudioClip content = global::UnityEngine.Networking.DownloadHandlerAudioClip.GetContent(request);
		global::MainMenuSoundtrackController.AddTheme(new global::MainMenuSoundtrackController.MenuAltTheme
		{
			Name = global::System.IO.Path.GetFileNameWithoutExtension(file),
			Theme = content
		});
	}
}

using System.IO;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;

// The game reads these from the working directory (next to SCPSL.exe), like the shipped client does.
// In the editor they are found in the project root, so copy them beside the built player.
public class CopyGameFilesPostBuild : IPostprocessBuildWithReport
{
	private static readonly string[] Directories = { "Translations", "ConfigTemplates" };

	private static readonly string[] Files = { "CreditsCache.json", "steam_appid.txt" };

	public int callbackOrder => 0;

	public void OnPostprocessBuild(BuildReport report)
	{
		if (report.summary.platformGroup != BuildTargetGroup.Standalone)
		{
			return;
		}
		string outputDir = Path.GetDirectoryName(report.summary.outputPath);
		foreach (string dir in Directories)
		{
			if (Directory.Exists(dir))
			{
				CopyDirectory(dir, Path.Combine(outputDir, dir));
			}
		}
		foreach (string file in Files)
		{
			if (File.Exists(file))
			{
				File.Copy(file, Path.Combine(outputDir, file), overwrite: true);
			}
		}
	}

	private static void CopyDirectory(string source, string destination)
	{
		Directory.CreateDirectory(destination);
		foreach (string file in Directory.GetFiles(source))
		{
			File.Copy(file, Path.Combine(destination, Path.GetFileName(file)), overwrite: true);
		}
		foreach (string dir in Directory.GetDirectories(source))
		{
			CopyDirectory(dir, Path.Combine(destination, Path.GetFileName(dir)));
		}
	}
}

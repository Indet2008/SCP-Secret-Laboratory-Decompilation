using System;
using GameCore;
using UnityEngine;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class BuildInfoCommand : ICommand
	{
		public static string ModDescription;

		public string Command { get; } = "buildinfo";

		public string[] Aliases { get; } = new string[3] { "v", "ver", "version" };

		public string Description { get; } = "Displays information about the current build.";

		internal static string BuildInfoString => "Build info:\nGame version: " + GameCore.Version.VersionString + $"\nPreauth version: {GameCore.Version.Major}.{GameCore.Version.Minor}.{GameCore.Version.Revision}" + "\nBackward compatibility: " + ((!GameCore.Version.BackwardCompatibility || GameCore.Version.ExtendedVersionCheckNeeded) ? "False" : $"{GameCore.Version.Major}.{GameCore.Version.Minor}.{GameCore.Version.BackwardRevision} and newer") + "\nBuild timestamp: 2026-10-12 18:32:38Z" + $"\nBuild type: {GameCore.Version.BuildType}" + $"\nHoliday type: {GameCore.Version.ActiveHoliday}" + $"\nAlways accept release builds: {GameCore.Version.AlwaysAcceptReleaseBuilds}" + "\nBuild GUID: " + PlatformInfo.singleton.BuildGuid + "\nUnity version: " + Application.unityVersion + $"\n\nPrivate beta: {GameCore.Version.PrivateBeta}" + $"\nPublic beta: {GameCore.Version.PublicBeta}" + $"\nRelease candidate: {GameCore.Version.ReleaseCandidate}" + $"\nStreaming allowed: {GameCore.Version.StreamingAllowed}" + $"\nHeadless: {PlatformInfo.singleton.IsHeadless}" + "\nModded: " + (CustomNetworkManager.Modded ? $"{true}\nMod Description:\n{ModDescription}" : false.ToString());

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = BuildInfoString;
			return true;
		}
	}
}

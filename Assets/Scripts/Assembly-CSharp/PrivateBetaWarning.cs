using UnityEngine;

public class PrivateBetaWarning : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::TMPro.TextMeshProUGUI text;


	private void Start()
	{
		if (global::GameCore.Version.BuildType == global::GameCore.Version.VersionType.Development)
		{
			text.text = "<size=32>DEVELOPMENT BUILD - restricted access</size>\nDo not share or distribute any game files";
		}
		else if (global::GameCore.Version.BuildType == global::GameCore.Version.VersionType.Nightly)
		{
			text.text = "<size=32>NIGHTLY BUILD - restricted access</size>\nDo not share or distribute any game files";
		}
		else if (global::GameCore.Version.PrivateBeta)
		{
			text.text = "<size=32>PRIVATE BETA - restricted access</size>" + (global::GameCore.Version.ReleaseCandidate ? " [RELEASE CANDIDATE]\n" : "\n") + (global::GameCore.Version.StreamingAllowed ? "Sharing footage (recording or streaming) is allowed" : "CONFIDENTIAL - sharing or publishing any information about this version (including recording or streaming) is strictly prohibited") + "\nDo not share or distribute any game files";
		}
		else if (global::GameCore.Version.PublicBeta)
		{
			text.text = "<size=32>PUBLIC BETA - all content is subject to change!</size>" + (global::GameCore.Version.ReleaseCandidate ? " [RELEASE CANDIDATE]\n" : "\n") + "Game version: " + global::GameCore.Version.VersionString;
		}
	}
}

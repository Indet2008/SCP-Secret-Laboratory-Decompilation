using ToggleableMenus;
using UnityEngine;

public class SpectatorInterface : SimpleToggleableMenu
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::TMPro.TextMeshProUGUI PlayerList;

	public global::TMPro.TextMeshProUGUI PlayerInfo;

	[global::UnityEngine.SerializeField]
	private global::TMPro.TextMeshProUGUI _attachmentsEditorText;


	public GameObject RootPanel;

	public static SpectatorInterface Singleton;
}

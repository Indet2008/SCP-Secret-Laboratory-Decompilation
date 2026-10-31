public class PartySlotAnim : global::UnityEngine.MonoBehaviour
{
	public void OnAnimOver()
	{
		GetComponentInParent<SteamPreLobby>().OnAnimOver();
	}
}

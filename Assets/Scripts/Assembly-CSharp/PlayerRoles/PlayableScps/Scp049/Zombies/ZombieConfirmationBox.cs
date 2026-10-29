using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieConfirmationBox : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _progressBar;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _root;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _text;

		// Client logic restored from the client build (IL2CPP): offered to a player killed by SCP-049.
		private const double ShowDuration = 15.0;

		private readonly PlayerRoles.Subroutines.AbilityCooldown _cooldown = new PlayerRoles.Subroutines.AbilityCooldown();

		private void Start()
		{
			_root.SetActive(HideHUDController.IsHUDVisible);
			HideHUDController.ToggleHUD += _root.SetActive;
			string format = TranslationReader.Get("SCP049_HUD", 9, "Press {0} to deny further resurrection.");
			_text.text = string.Format(format, "<color=red>" + new ReadableKeyCode(NewInput.GetKey(ActionName.ToggleFlashlight)) + "</color>");
			_cooldown.Trigger(ShowDuration);
		}

		private void OnDestroy()
		{
			HideHUDController.ToggleHUD -= _root.SetActive;
		}

		private void Update()
		{
			_progressBar.fillAmount = 1f - _cooldown.Readiness;
			if (Input.GetKeyDown(NewInput.GetKey(ActionName.ToggleFlashlight)))
			{
				Confirm();
			}
			if (_cooldown.IsReady || !ReferenceHub.TryGetLocalHub(out var hub) || hub.GetTeam() != Team.Dead)
			{
				Object.Destroy(base.gameObject);
			}
		}

		private void Confirm()
		{
			NetworkClient.Send(default(ScpReviveBlockMessage));
			_text.text = TranslationReader.Get("SCP049_HUD", 8, "You have denied further resurrection from SCP-049!");
			_cooldown.Trigger(3.0);
		}


		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct ScpReviveBlockMessage : NetworkMessage
		{
		}

		private static void ServerReceiveMessage(NetworkConnection conn)
		{
			if (NetworkServer.active && ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub) && Scp049ResurrectAbility.GetResurrectionsNumber(hub) != 0)
			{
				Scp049ResurrectAbility.RegisterPlayerResurrection(hub, 2);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkServer.ReplaceHandler((NetworkConnectionToClient conn, ScpReviveBlockMessage msg) =>
				{
					ServerReceiveMessage(conn);
				});
			};
		}
	}
}

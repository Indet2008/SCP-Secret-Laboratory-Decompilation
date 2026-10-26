using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace GameCore
{
	public class RoundStart : NetworkBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		public global::UnityEngine.GameObject window;

		public global::UnityEngine.GameObject forceButton;

		public global::TMPro.TextMeshProUGUI playersNumber;

		public global::TMPro.TextMeshProUGUI startsIn;

		public global::UnityEngine.UI.Image loadingbar;

		public ushort players;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _background;


		public static RoundStart singleton;

		public static bool LobbyLock;

		private static bool _singletonSet;

		[SyncVar]
		public short Timer = -2;

		private short _lastTimer = -1;

		internal static readonly Stopwatch RoundStartTimer;

		public static bool RoundStarted
		{
			get
			{
				if (_singletonSet)
				{
					return singleton.Timer == -1;
				}
				return false;
			}
		}

		public static TimeSpan RoundLength => RoundStartTimer.Elapsed;

		public short NetworkTimer
		{
			get
			{
				return Timer;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Timer, 1uL, null);
			}
		}

		static RoundStart()
		{
			RoundStartTimer = new Stopwatch();
			SceneManager.sceneLoaded += OnSceneLoaded;
		}

		private static void OnSceneLoaded(Scene scene, LoadSceneMode mode)
		{
			RoundStartTimer.Reset();
		}

		private void Start()
		{
			GetComponent<RectTransform>().localPosition = Vector3.zero;
		}

		private void Awake()
		{
			singleton = this;
			_singletonSet = true;
			PlayerRoles.PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		private void OnDestroy()
		{
			PlayerRoles.PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			_singletonSet = false;
		}

		private string _roundStartText;

		private string _roundStartTextPaused;

		private bool _textLoaded;

		private bool _hideBackground;

		// Client-only lobby UI; the server build left Update empty. Ported from the SL 12 CE client.
		private void Update()
		{
			if (ServerStatic.IsDedicated || window == null)
			{
				return;
			}
			bool lobby = Timer != -1;
			if (window.activeSelf != lobby)
			{
				window.SetActive(lobby);
			}
			if (!lobby)
			{
				return;
			}
			if (forceButton != null)
			{
				// Only the host may force the round to start.
				bool canForce = NetworkServer.active;
				if (forceButton.activeSelf != canForce)
				{
					forceButton.SetActive(canForce);
				}
			}
			if (!_textLoaded)
			{
				_textLoaded = true;
				_roundStartText = TranslationReader.Get("Facility", 38, "ROUND STARTS IN: <color=yellow>{0}</color>s");
				_roundStartTextPaused = TranslationReader.Get("Facility", 39, "ROUND START IS <color=#FF5050>PAUSED</color>");
			}
			if (_background != null)
			{
				_background.color = _hideBackground ? Color.clear : Color.black;
			}
			if (Timer < 0)
			{
				if (loadingbar != null)
				{
					loadingbar.fillAmount = 1f;
				}
				startsIn?.SetText(_roundStartTextPaused);
			}
			else
			{
				if (loadingbar != null)
				{
					loadingbar.fillAmount = Mathf.Lerp(loadingbar.fillAmount, Timer / 20f, Time.deltaTime);
				}
				startsIn?.SetText(_roundStartText.Replace("{0}", Timer.ToString()));
			}
			int count = 0;
			foreach (ReferenceHub hub in ReferenceHub.AllHubs)
			{
				if (hub.Mode == CentralAuth.ClientInstanceMode.ReadyClient || hub.Mode == CentralAuth.ClientInstanceMode.Host)
				{
					count++;
				}
			}
			if (players != count)
			{
				players = (ushort)count;
				playersNumber?.SetText(players.ToString());
			}
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoles.PlayerRoleBase prevRole, PlayerRoles.PlayerRoleBase newRole)
		{
			if (userHub != null && userHub.isLocalPlayer)
			{
				_hideBackground = newRole is PlayerRoles.FirstPersonControl.FpcStandardRoleBase;
			}
		}

		public void ShowButton()
		{
			if (forceButton != null)
			{
				forceButton.SetActive(true);
			}
		}

		public void UseButton()
		{
			if (forceButton != null)
			{
				forceButton.SetActive(false);
			}
			if (!NetworkServer.active)
			{
				Console.AddLog("Force start: only the host can start the round.", Color.red);
				return;
			}
			bool started = CharacterClassManager.ForceRoundStart();
			Console.AddLog("Force start pressed: " + (started ? "round started." : "ForceRoundStart() refused (round starting event was cancelled)."), started ? Color.green : Color.red);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteShort(Timer);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteShort(Timer);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref Timer, null, reader.ReadShort());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Timer, null, reader.ReadShort());
			}
		}
	}
}

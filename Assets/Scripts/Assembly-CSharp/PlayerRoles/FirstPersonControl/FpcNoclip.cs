using System.Collections.Generic;
using System.Diagnostics;
using InventorySystem;
using Mirror;
using PlayerRoles.FirstPersonControl.NetworkMessages;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcNoclip
	{
		public static float CurSpeed = 10f;

		private const float DefaultNoclipSpeed = 10f;

		private const float MinNoclipSpeed = 0.1f;

		private const float MaxNoclipSpeed = 250f;

		private const float NoclipLerp = 16f;

		private const float NoclipMaxDiffSqrt = 25f;

		private const float RecentTimeThreshold = 2.5f;

		private const string AxisName = "Mouse ScrollWheel";

		private bool _wasEnabled;

		private readonly ReferenceHub _hub;

		private readonly FirstPersonMovementModule _fpmm;

		private readonly AdminFlagsStat _stats;

		private readonly Stopwatch _lastNcSw;

		private static readonly HashSet<uint> PermittedPlayers = new HashSet<uint>();

		private static KeyCode _keyFwd;

		private static KeyCode _keyBwd;

		private static KeyCode _keyLft;

		private static KeyCode _keyRgt;

		private static KeyCode _keyUpw;

		private static KeyCode _keyDnw;

		private static KeyCode _keyToggle;

		private static KeyCode _keyFog;

		public bool IsActive
		{
			get
			{
				return _stats.HasFlag(AdminFlags.Noclip);
			}
			set
			{
				_stats.SetFlag(AdminFlags.Noclip, value);
			}
		}

		public bool RecentlyActive
		{
			get
			{
				if (_lastNcSw.IsRunning)
				{
					return _lastNcSw.Elapsed.TotalSeconds < 2.5;
				}
				return false;
			}
		}

		public FpcNoclip(ReferenceHub hub, FirstPersonMovementModule fpmm)
		{
			_hub = hub;
			_fpmm = fpmm;
			_stats = hub.playerStats.GetModule<AdminFlagsStat>();
			_lastNcSw = new Stopwatch();
			if (_hub.isLocalPlayer)
			{
				ReloadInputConfigs();
			}
		}

		public void UpdateNoclip()
		{
			if (_hub.isLocalPlayer && Input.GetKeyDown(_keyToggle))
			{
				NetworkClient.Send<FpcNoclipToggleMessage>(default);
			}
			if (!_stats.HasFlag(AdminFlags.Noclip))
			{
				if (_wasEnabled)
				{
					DisableNoclipClientside();
				}
				_wasEnabled = false;
				return;
			}
			_wasEnabled = true;
			_lastNcSw.Restart();
			if (_hub.isLocalPlayer && Input.GetKeyDown(_keyFog) && !Cursor.visible)
			{
				SetFogDisabled(!FogDisabled);
			}
			if (NetworkServer.active)
			{
				_fpmm.Motor.ResetFallDamageCooldown();
			}
			if (_hub.isLocalPlayer)
			{
				UpdateLocalMovement();
			}
			else
			{
				Vector3 position = _fpmm.Motor.ReceivedPosition.Position;
				float t = (((position - _fpmm.Position).sqrMagnitude > 25f) ? 1f : (16f * Time.deltaTime));
				_fpmm.Position = Vector3.Lerp(_fpmm.Position, position, t);
			}
		}

		public void ShutdownModule()
		{
			if (NetworkServer.active)
			{
				IsActive = false;
			}
			DisableNoclipClientside();
		}

		private void UpdateLocalMovement()
		{
			if (Cursor.visible)
			{
				return;
			}
			float axis = Input.GetAxis(AxisName);
			if (axis != 0f)
			{
				CurSpeed = Mathf.Clamp(CurSpeed * ((axis > 0f) ? 1.25f : 0.8f), MinNoclipSpeed, MaxNoclipSpeed);
			}
			Transform playerCameraReference = _hub.PlayerCameraReference;
			Vector3 zero = Vector3.zero;
			if (Input.GetKey(_keyFwd))
			{
				zero += playerCameraReference.forward;
			}
			if (Input.GetKey(_keyBwd))
			{
				zero -= playerCameraReference.forward;
			}
			if (Input.GetKey(_keyRgt))
			{
				zero += playerCameraReference.right;
			}
			if (Input.GetKey(_keyLft))
			{
				zero -= playerCameraReference.right;
			}
			if (Input.GetKey(_keyUpw))
			{
				zero += Vector3.up;
			}
			if (Input.GetKey(_keyDnw))
			{
				zero -= Vector3.up;
			}
			if (!(zero.sqrMagnitude < 0.0001f))
			{
				float num = CurSpeed * ((Input.GetKey(KeyCode.LeftShift) ? 2f : 1f));
				_fpmm.Position += zero.normalized * (num * Time.deltaTime);
			}
		}

		private void DisableNoclipClientside()
		{
			if (_hub.isLocalPlayer)
			{
				SetFogDisabled(state: false);
			}
			if (_hub.isLocalPlayer && _fpmm.CharController != null)
			{
				_fpmm.Motor.ResetFallDamageCooldown();
			}
		}

		public static bool FogDisabled { get; private set; }

		private static UnityEngine.Rendering.Volume _noFogVolume;

		// A top-priority global volume that switches HDRP fog off while it has weight.
		private static void SetFogDisabled(bool state)
		{
			FogDisabled = state;
			if (_noFogVolume == null)
			{
				if (!state)
				{
					return;
				}
				GameObject obj = new GameObject("Noclip Fog Override");
				UnityEngine.Object.DontDestroyOnLoad(obj);
				_noFogVolume = obj.AddComponent<UnityEngine.Rendering.Volume>();
				_noFogVolume.isGlobal = true;
				_noFogVolume.priority = 10000f;
				UnityEngine.Rendering.VolumeProfile volumeProfile = ScriptableObject.CreateInstance<UnityEngine.Rendering.VolumeProfile>();
				UnityEngine.Rendering.HighDefinition.Fog fog = volumeProfile.Add<UnityEngine.Rendering.HighDefinition.Fog>(overrides: true);
				fog.enabled.Override(x: false);
				_noFogVolume.sharedProfile = volumeProfile;
			}
			_noFogVolume.weight = (state ? 1f : 0f);
		}

		public static bool IsPermitted(ReferenceHub ply)
		{
			if (ply != null)
			{
				return PermittedPlayers.Contains(ply.netId);
			}
			return false;
		}

		public static void PermitPlayer(ReferenceHub ply)
		{
			if (!(ply == null))
			{
				PermittedPlayers.Add(ply.netId);
				ply.gameConsoleTransmission.SendToClient("Noclip is now permitted.", "green");
			}
		}

		public static void UnpermitPlayer(ReferenceHub ply)
		{
			if (!(ply == null))
			{
				PermittedPlayers.Remove(ply.netId);
				ply.playerStats.GetModule<AdminFlagsStat>().SetFlag(AdminFlags.Noclip, status: false);
				ply.gameConsoleTransmission.SendToClient("Noclip permission revoked.", "yellow");
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnServerStarted += PermittedPlayers.Clear;
			NewInput.OnAnyModified += ReloadInputConfigs;
		}

		private static void ReloadInputConfigs()
		{
			// Client-only body stripped from the server build (restored after the SL 12 CE client).
			_keyFwd = NewInput.GetKey(ActionName.MoveForward);
			_keyBwd = NewInput.GetKey(ActionName.MoveBackward);
			_keyLft = NewInput.GetKey(ActionName.MoveLeft);
			_keyRgt = NewInput.GetKey(ActionName.MoveRight);
			_keyUpw = NewInput.GetKey(ActionName.Jump);
			_keyDnw = NewInput.GetKey(ActionName.Sneak);
			_keyToggle = NewInput.GetKey(ActionName.Noclip);
			_keyFog = NewInput.GetKey(ActionName.NoClipFogToggle);
		}	}
}

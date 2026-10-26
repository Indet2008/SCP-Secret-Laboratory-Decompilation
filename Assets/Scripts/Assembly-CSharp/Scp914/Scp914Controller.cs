using System;
using System.Runtime.InteropServices;
using GameCore;
using Interactables;
using Interactables.Interobjects.DoorUtils;
using Interactables.Verification;
using LabApi.Events.Arguments.Scp914Events;
using LabApi.Events.Handlers;
using MapGeneration.StaticHelpers;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;
using Utils.ConfigHandler;

namespace Scp914
{
	public class Scp914Controller : NetworkBehaviour, IServerInteractable, IInteractable, IBlockStaticBatching
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private float _knobTurningSpeed;

		[global::UnityEngine.SerializeField]
		private float _knobNotchAngle;


		[SyncVar]
		[SerializeField]
		private Scp914KnobSetting _knobSetting;

		[SerializeField]
		private AudioSource _knobSoundSource;

		[SerializeField]
		private AudioSource _upgradingSoundSource;

		[SerializeField]
		private Transform _knobTransform;

		public float KnobChangeCooldown;

		public float TotalSequenceTime;

		public float DoorCloseTime;

		public float ItemUpgradeTime;

		public float DoorOpenTime;

		public DoorVariant[] Doors;

		public Vector3 ChamberSize;

		public bool IsUpgrading;

		public float RemainingCooldown;

		public ConfigEntry<Scp914Mode> ConfigMode;

		private bool _itemsAlreadyUpgraded;

		public static Scp914Controller Singleton { get; private set; }

		public static Vector3 MoveVector => Singleton.OutputChamber.position - Singleton.IntakeChamber.position;

		[field: SerializeField]
		public Transform IntakeChamber { get; private set; }

		[field: SerializeField]
		public Transform OutputChamber { get; private set; }

		private Vector3 IntakeChamberSize
		{
			get
			{
				Vector3 vector = IntakeChamber.rotation * ChamberSize / 2f;
				return new Vector3(Mathf.Abs(vector.z), Mathf.Abs(vector.y), Mathf.Abs(vector.x));
			}
		}

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public Scp914KnobSetting KnobSetting => _knobSetting;

		public Scp914KnobSetting Network_knobSetting
		{
			get
			{
				return _knobSetting;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _knobSetting, 1uL, null);
			}
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (RemainingCooldown > 0f)
			{
				return;
			}
			switch ((Scp914InteractCode)colliderId)
			{
			case Scp914InteractCode.ChangeMode:
			{
				Scp914KnobSetting scp914KnobSetting = _knobSetting + 1;
				if (!Enum.IsDefined(typeof(Scp914KnobSetting), scp914KnobSetting))
				{
					scp914KnobSetting = Scp914KnobSetting.Rough;
				}
				Scp914KnobSetting knobSetting = _knobSetting;
				Scp914KnobChangingEventArgs e2 = new Scp914KnobChangingEventArgs(knobSetting, scp914KnobSetting, ply);
				Scp914Events.OnKnobChanging(e2);
				if (e2.IsAllowed)
				{
					scp914KnobSetting = e2.KnobSetting;
					RemainingCooldown = KnobChangeCooldown;
					Network_knobSetting = scp914KnobSetting;
					RpcPlaySound(0);
					Scp914Events.OnKnobChanged(new Scp914KnobChangedEventArgs(knobSetting, scp914KnobSetting, ply));
				}
				break;
			}
			case Scp914InteractCode.Activate:
			{
				Scp914ActivatingEventArgs e = new Scp914ActivatingEventArgs(_knobSetting, ply);
				Scp914Events.OnActivating(e);
				if (e.IsAllowed)
				{
					Network_knobSetting = e.KnobSetting;
					Upgrade();
					Scp914Events.OnActivated(new Scp914ActivatedEventArgs(_knobSetting, ply));
				}
				break;
			}
			}
		}

		[Server]
		public void Upgrade()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Scp914.Scp914Controller::Upgrade()' called when server was not active");
				return;
			}
			RemainingCooldown = TotalSequenceTime;
			IsUpgrading = true;
			_itemsAlreadyUpgraded = false;
			RpcPlaySound(1);
		}

		private void Start()
		{
			Singleton = this;
			if (Scp914Upgrader.SolidObjectMask == 0)
			{
				Scp914Upgrader.SolidObjectMask = LayerMask.GetMask("Default", "Door");
			}
			if (NetworkServer.active)
			{
				ConfigMode = new ConfigEntry<Scp914Mode>("914_mode", Scp914Mode.DroppedAndHeld, "SCP-914 Mode", "The behavior SCP-914 should use when upgrading items.");
				ConfigFile.ServerConfig.RegisterConfig(ConfigMode);
			}
		}

		private void OnDestroy()
		{
			if (NetworkServer.active)
			{
				ConfigFile.ServerConfig.UnRegisterConfig(ConfigMode);
			}
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				UpdateServerside();
			}
		}

		[Server]
		private void UpdateServerside()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Scp914.Scp914Controller::UpdateServerside()' called when server was not active");
				return;
			}
			if (IsUpgrading)
			{
				float num = TotalSequenceTime - RemainingCooldown;
				if (num >= DoorCloseTime && num < DoorOpenTime && Doors[0].TargetState)
				{
					DoorVariant[] doors = Doors;
					for (int i = 0; i < doors.Length; i++)
					{
						doors[i].NetworkTargetState = false;
					}
				}
				else if (num >= ItemUpgradeTime && !_itemsAlreadyUpgraded)
				{
					Scp914Upgrader.Upgrade(Physics.OverlapBox(IntakeChamber.position, IntakeChamberSize), ConfigMode.Value, _knobSetting);
					_itemsAlreadyUpgraded = true;
				}
				else if (num >= DoorOpenTime && !Doors[0].TargetState)
				{
					DoorVariant[] doors = Doors;
					for (int i = 0; i < doors.Length; i++)
					{
						doors[i].NetworkTargetState = true;
					}
				}
			}
			if (RemainingCooldown >= 0f)
			{
				RemainingCooldown -= Time.deltaTime;
				if (RemainingCooldown < 0f)
				{
					IsUpgrading = false;
				}
			}
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.green;
			Gizmos.DrawCube(IntakeChamber.position, IntakeChamberSize * 2f);
			Gizmos.DrawCube(OutputChamber.position, IntakeChamberSize * 2f);
		}

		[ClientRpc]
		public void RpcPlaySound(byte soundId)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			NetworkWriterExtensions.WriteByte(writer, soundId);
			SendRPCInternal("System.Void Scp914.Scp914Controller::RpcPlaySound(System.Byte)", 1143347406, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlaySound__Byte(byte soundId)
		{
			switch ((Scp914Sound)soundId)
			{
			case Scp914Sound.KnobChange:
				_knobSoundSource.Stop();
				_knobSoundSource.Play();
				break;
			case Scp914Sound.Upgrading:
				_upgradingSoundSource.Stop();
				_upgradingSoundSource.Play();
				break;
			}
		}

		protected static void InvokeUserCode_RpcPlaySound__Byte(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlaySound called on server.");
			}
			else
			{
				((Scp914Controller)obj).UserCode_RpcPlaySound__Byte(NetworkReaderExtensions.ReadByte(reader));
			}
		}

		static Scp914Controller()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(Scp914Controller), "System.Void Scp914.Scp914Controller::RpcPlaySound(System.Byte)", InvokeUserCode_RpcPlaySound__Byte);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				GeneratedNetworkCode._Write_Scp914_002EScp914KnobSetting(writer, _knobSetting);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				GeneratedNetworkCode._Write_Scp914_002EScp914KnobSetting(writer, _knobSetting);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _knobSetting, null, GeneratedNetworkCode._Read_Scp914_002EScp914KnobSetting(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _knobSetting, null, GeneratedNetworkCode._Read_Scp914_002EScp914KnobSetting(reader));
			}
		}
	}
}

using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using Interactables;
using Interactables.Verification;
using Mirror;
using PlayerRoles;
using UnityEngine;
using UnityEngine.Serialization;

namespace InventorySystem.Items.Firearms.Attachments
{
	public class WorkstationController : NetworkBehaviour, IClientInteractable, IInteractable, IServerInteractable
	{
		public enum WorkstationStatus : byte
		{
			Offline = 0,
			PoweringUp = 1,
			PoweringDown = 2,
			Online = 3
		}

		public static readonly HashSet<WorkstationController> AllWorkstations = new HashSet<WorkstationController>();

		[SerializeField]
		private WorkstationAttachmentSelector _selector;

		[SerializeField]
		private GameObject _idleScreen;

		[SerializeField]
		private GameObject _powerupScreen;

		[SerializeField]
		private GameObject _powerdownScreen;

		[SerializeField]
		private GameObject _selectorScreen;

		[FormerlySerializedAs("_activateCollder")]
		public InteractableCollider ActivateCollider;

		[SyncVar]
		public byte Status;

		public ReferenceHub KnownUser;

		public readonly Stopwatch ServerStopwatch = new Stopwatch();

		private const float StandbyDistance = 2.4f;

		private const float UpkeepTime = 30f;

		private const float CheckTime = 5f;

		private const float PowerupTime = 1f;

		private const float PowerdownTime = 2.5f;

		private byte _prevStatus;

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public byte NetworkStatus
		{
			get
			{
				return Status;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Status, 1uL, null);
			}
		}

		public void ClientInteract(InteractableCollider collider)
		{
			if (collider is WorkstationSelectorCollider workstationSelectorCollider)
			{
				_selector.ProcessCollider(workstationSelectorCollider.ColliderId);
			}
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (colliderId == ActivateCollider.ColliderId && Status == 0)
			{
				NetworkStatus = 1;
				ServerStopwatch.Restart();
			}
		}

		private void Start()
		{
			AllWorkstations.Add(this);
		}

		private void OnDestroy()
		{
			AllWorkstations.Remove(this);
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				if (Status == 0)
				{
					return;
				}
				switch ((WorkstationStatus)Status)
				{
				case WorkstationStatus.PoweringUp:
					if (ServerStopwatch.Elapsed.TotalSeconds > 1.0)
					{
						NetworkStatus = 3;
						ServerStopwatch.Restart();
					}
					break;
				case WorkstationStatus.PoweringDown:
					if (ServerStopwatch.Elapsed.TotalSeconds > 2.5)
					{
						NetworkStatus = 0;
						ServerStopwatch.Stop();
					}
					break;
				case WorkstationStatus.Online:
					if (ServerStopwatch.Elapsed.TotalSeconds < 30.0)
					{
						if (!(ServerStopwatch.Elapsed.TotalSeconds > 5.0))
						{
							break;
						}
						if (IsInRange(KnownUser))
						{
							ServerStopwatch.Restart();
							break;
						}
						foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
						{
							if (IsInRange(allHub))
							{
								KnownUser = allHub;
								ServerStopwatch.Restart();
								break;
							}
						}
					}
					else
					{
						NetworkStatus = 2;
						ServerStopwatch.Restart();
					}
					break;
				}
			}
			if (_prevStatus != Status)
			{
				WorkstationStatus status = (WorkstationStatus)Status;
				_selector.enabled = status == WorkstationStatus.Online;
				_selectorScreen.SetActive(status == WorkstationStatus.Online);
				_idleScreen.SetActive(status == WorkstationStatus.Offline);
				_powerupScreen.SetActive(status == WorkstationStatus.PoweringUp);
				_powerdownScreen.SetActive(status == WorkstationStatus.PoweringDown);
				_prevStatus = Status;
			}
		}

		public bool IsInRange(ReferenceHub hub)
		{
			if (hub != null && hub.IsAlive() && Mathf.Abs(hub.transform.position.y - base.transform.position.y) < 2.4f && Mathf.Abs(hub.transform.position.x - base.transform.position.x) < 2.4f)
			{
				return Mathf.Abs(hub.transform.position.z - base.transform.position.z) < 2.4f;
			}
			return false;
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
				NetworkWriterExtensions.WriteByte(writer, Status);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, Status);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref Status, null, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Status, null, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}

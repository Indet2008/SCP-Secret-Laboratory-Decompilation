using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Interactables;
using Interactables.Verification;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration.StaticHelpers;
using Mirror;
using Mirror.RemoteCalls;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.UI;

namespace AdminToys
{
	public class ShootingTarget : AdminToyBase, IDestructible, IBlockStaticBatching, IClientInteractable, IInteractable, IServerInteractable
	{
		private enum TargetButton
		{
			IncreaseHP = 0,
			DecreaseHP = 1,
			IncreaseResetTime = 2,
			DecreaseResetTime = 3,
			ManualReset = 4,
			Remove = 5,
			GlobalResults = 6
		}

		private float _hp = 10f;

		private int _maxHp = 10;

		private int _autoDestroyTime;

		private float _avg;

		private GameObject _prevHit;

		[SyncVar]
		private bool _syncMode;

		[SerializeField]
		private float _stepSize = 0.12f;

		[SerializeField]
		private string _targetName;

		[SerializeField]
		private AudioSource _source;

		[SerializeField]
		private AudioClip _hitSound;

		[SerializeField]
		private AudioClip _killSound;

		[SerializeField]
		private AudioClip[] _score;

		[SerializeField]
		private GameObject _hitIndicator;

		[SerializeField]
		private Transform _bullsEye;

		[SerializeField]
		private float _bullsEyeRadius;

		[SerializeField]
		private Vector3[] _bullsEyeBounds;

		[SerializeField]
		private Material _prevHitMat;

		[SerializeField]
		private Text _lastHitInfo;

		[SerializeField]
		private Text _syncText;

		[SerializeField]
		private Text _settingsWindow;

		private readonly List<GameObject> _hits = new List<GameObject>();

		public uint NetworkId => base.netId;

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public Vector3 CenterOfMass => _bullsEye.position;

		public override string CommandName => "Target" + _targetName;

		public bool Network_syncMode
		{
			get
			{
				return _syncMode;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncMode, 32uL, null);
			}
		}

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			if (Physics.Raycast(admin.transform.position - admin.transform.forward, Vector3.down, out var hitInfo, 2f))
			{
				base.transform.position = hitInfo.point;
				base.transform.rotation = Quaternion.Euler(Vector3.up * (Mathf.Round((admin.transform.rotation.eulerAngles.y + 90f) / 10f) * 10f));
			}
			base.OnSpawned(admin, arguments);
		}

		private void Update()
		{
			_settingsWindow.text = string.Format("HP: {0}/{1}\nReset time: {2}", _hp, _maxHp, (_autoDestroyTime == 0) ? "n/a" : (_autoDestroyTime + " s"));
			_syncText.text = (_syncMode ? "Sync Mode" : "Local Mode");
		}

		public bool Damage(float damage, DamageHandlerBase handler, Vector3 exactHit)
		{
			if (!(handler is AttackerDamageHandler attackerDamageHandler))
			{
				return false;
			}
			ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
			if (hub == null)
			{
				return false;
			}
			PlayerDamagingShootingTargetEventArgs e = new PlayerDamagingShootingTargetEventArgs(hub, this, handler);
			PlayerEvents.OnDamagingShootingTarget(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			float distance = Vector3.Distance(hub.transform.position, _bullsEye.position);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (_syncMode || allHub == hub)
				{
					TargetRpcReceiveData(allHub.characterClassManager.connectionToClient, damage, distance, exactHit, handler);
				}
			}
			PlayerEvents.OnDamagedShootingTarget(new PlayerDamagedShootingTargetEventArgs(hub, this, handler));
			return true;
		}

		public void ClientInteract(InteractableCollider collider)
		{
			UseButton((TargetButton)collider.ColliderId);
		}

		private void UseButton(TargetButton tb)
		{
			switch (tb)
			{
			case TargetButton.ManualReset:
				ClearTarget();
				break;
			case TargetButton.IncreaseHP:
				_maxHp = Mathf.Clamp(_maxHp * 2, 1, 256);
				break;
			case TargetButton.DecreaseHP:
				_maxHp /= 2;
				break;
			case TargetButton.IncreaseResetTime:
				_autoDestroyTime = Mathf.Min(_autoDestroyTime + 1, 10);
				break;
			case TargetButton.DecreaseResetTime:
				_autoDestroyTime = Mathf.Max(_autoDestroyTime - 1, 0);
				break;
			}
		}

		private void ClearTarget()
		{
			foreach (GameObject hit in _hits)
			{
				UnityEngine.Object.Destroy(hit);
			}
			_hits.Clear();
			_avg = 0f;
			_hp = _maxHp;
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!PermissionsHandler.IsPermitted(ply.serverRoles.Permissions, PlayerPermissions.FacilityManagement))
			{
				return;
			}
			PlayerInteractingShootingTargetEventArgs e = new PlayerInteractingShootingTargetEventArgs(ply, this);
			PlayerEvents.OnInteractingShootingTarget(e);
			if (!e.IsAllowed)
			{
				return;
			}
			switch ((TargetButton)colliderId)
			{
			case TargetButton.Remove:
				NetworkServer.Destroy(base.gameObject);
				break;
			case TargetButton.GlobalResults:
				Network_syncMode = !_syncMode;
				break;
			default:
				if (_syncMode && !ply.isLocalPlayer)
				{
					UseButton((TargetButton)colliderId);
					RpcSendInfo(_maxHp, _autoDestroyTime);
				}
				break;
			}
			PlayerEvents.OnInteractedShootingTarget(new PlayerInteractedShootingTargetEventArgs(ply, this));
		}

		[TargetRpc]
		private void TargetRpcReceiveData(NetworkConnection conn, float damage, float distance, Vector3 pos, DamageHandlerBase handler)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteFloat(damage);
			writer.WriteFloat(distance);
			writer.WriteVector3(pos);
			writer.WriteDamageHandler(handler);
			SendTargetRPCInternal(conn, "System.Void AdminToys.ShootingTarget::TargetRpcReceiveData(Mirror.NetworkConnection,System.Single,System.Single,UnityEngine.Vector3,PlayerStatsSystem.DamageHandlerBase)", -668080035, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[ClientRpc]
		private void RpcSendInfo(int maxHp, int autoReset)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteInt(maxHp);
			writer.WriteInt(autoReset);
			SendRPCInternal("System.Void AdminToys.ShootingTarget::RpcSendInfo(System.Int32,System.Int32)", -479456756, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.red;
			Gizmos.DrawWireSphere(_bullsEye.position, _bullsEyeRadius);
			Gizmos.DrawWireSphere(_bullsEye.position, _stepSize);
			Vector3[] bullsEyeBounds = _bullsEyeBounds;
			for (int i = 0; i < bullsEyeBounds.Length; i++)
			{
				Vector3 vector = bullsEyeBounds[i];
				Gizmos.DrawWireCube(_bullsEye.TransformPoint(new Vector3(0f, vector.y, vector.x)), new Vector3(0.04f, 1f, 1f) * vector.z);
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_TargetRpcReceiveData__NetworkConnection__Single__Single__Vector3__DamageHandlerBase(NetworkConnection conn, float damage, float distance, Vector3 pos, DamageHandlerBase handler)
		{
			float num;
			if (_bullsEyeBounds.Length == 0)
			{
				num = Vector3.Distance(_bullsEye.position, pos);
			}
			else
			{
				num = float.PositiveInfinity;
				Vector3[] bullsEyeBounds = _bullsEyeBounds;
				for (int i = 0; i < bullsEyeBounds.Length; i++)
				{
					Vector3 vector = bullsEyeBounds[i];
					float num2 = Vector3.Distance(new Bounds(_bullsEye.TransformPoint(new Vector3(0f, vector.y, vector.x)), Vector3.one * vector.z).ClosestPoint(pos), pos);
					if (num2 < num)
					{
						num = num2;
					}
				}
			}
			num = Mathf.Max(0f, num - _bullsEyeRadius);
			int num3 = Mathf.Min(Mathf.CeilToInt(num / _stepSize), _score.Length - 1);
			float num4 = 1f - (float)num3 / ((float)_score.Length - 1f);
			_avg += num4;
			GameObject gameObject = GameObject.CreatePrimitive(PrimitiveType.Sphere);
			gameObject.GetComponent<Collider>().enabled = false;
			gameObject.GetComponent<MeshRenderer>().sharedMaterial = _hitIndicator.GetComponent<MeshRenderer>().sharedMaterial;
			gameObject.transform.localScale = _hitIndicator.transform.localScale;
			gameObject.transform.parent = _hitIndicator.transform.parent;
			gameObject.transform.position = pos;
			_hp -= damage;
			_source.Stop();
			_source.PlayOneShot(_score[num3]);
			_source.PlayOneShot((_hp < 0f) ? _killSound : _hitSound);
			if (_prevHit != null && _prevHit.TryGetComponent<MeshRenderer>(out var component))
			{
				component.sharedMaterial = _prevHitMat;
			}
			_prevHit = gameObject;
			if (_autoDestroyTime > 0)
			{
				UnityEngine.Object.Destroy(gameObject, _autoDestroyTime);
			}
			else
			{
				_hits.Add(gameObject);
			}
		}

		protected static void InvokeUserCode_TargetRpcReceiveData__NetworkConnection__Single__Single__Vector3__DamageHandlerBase(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("TargetRPC TargetRpcReceiveData called on server.");
			}
			else
			{
				((ShootingTarget)obj).UserCode_TargetRpcReceiveData__NetworkConnection__Single__Single__Vector3__DamageHandlerBase(null, reader.ReadFloat(), reader.ReadFloat(), reader.ReadVector3(), reader.ReadDamageHandler());
			}
		}

		protected void UserCode_RpcSendInfo__Int32__Int32(int maxHp, int autoReset)
		{
			_maxHp = maxHp;
			_autoDestroyTime = autoReset;
			ClearTarget();
		}

		protected static void InvokeUserCode_RpcSendInfo__Int32__Int32(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcSendInfo called on server.");
			}
			else
			{
				((ShootingTarget)obj).UserCode_RpcSendInfo__Int32__Int32(reader.ReadInt(), reader.ReadInt());
			}
		}

		static ShootingTarget()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(ShootingTarget), "System.Void AdminToys.ShootingTarget::RpcSendInfo(System.Int32,System.Int32)", InvokeUserCode_RpcSendInfo__Int32__Int32);
			RemoteProcedureCalls.RegisterRpc(typeof(ShootingTarget), "System.Void AdminToys.ShootingTarget::TargetRpcReceiveData(Mirror.NetworkConnection,System.Single,System.Single,UnityEngine.Vector3,PlayerStatsSystem.DamageHandlerBase)", InvokeUserCode_TargetRpcReceiveData__NetworkConnection__Single__Single__Vector3__DamageHandlerBase);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteBool(_syncMode);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				writer.WriteBool(_syncMode);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _syncMode, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncMode, null, reader.ReadBool());
			}
		}
	}
}

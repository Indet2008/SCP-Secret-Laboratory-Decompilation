using System.Runtime.InteropServices;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Ragdolls;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507Ragdoll : DynamicRagdoll
	{
		public const float RevivalMaxTime = 12f;

		private const float ReviveDistanceSqr = 15f;

		private const float ReviveProgressAddition = 1f / 12f;

		private const float ReviveAlphaBoost = 2f;

		private const int FreezeFixedFrames = 3;

		[SyncVar]
		private float _revivalProgress;

		[SyncVar]
		private bool _hasAlreadyRevived;

		[SyncVar]
		private double _lastResetTime;

		[SerializeField]
		private GameObject[] _alphaVariants;

		[SerializeField]
		private GameObject[] _regularVariants;

		[SerializeField]
		private GameObject[] _zombieVariants;

		[SerializeField]
		private GameObject[] _ciVariants;

		[SerializeField]
		private GameObject[] _ntfVariants;

		private int _unfreezeDelay;

		public float RevivalProgress => _revivalProgress;

		public float Network_revivalProgress
		{
			get
			{
				return _revivalProgress;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _revivalProgress, 2uL, null);
			}
		}

		public bool Network_hasAlreadyRevived
		{
			get
			{
				return _hasAlreadyRevived;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _hasAlreadyRevived, 4uL, null);
			}
		}

		public double Network_lastResetTime
		{
			get
			{
				return _lastResetTime;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _lastResetTime, 8uL, null);
			}
		}

		public bool ValidateRevive(ReferenceHub vocalizer)
		{
			if (_hasAlreadyRevived || Info.RoleType.GetTeam() != vocalizer.GetTeam())
			{
				return false;
			}
			if (NetworkTime.time - _lastResetTime > 12.0)
			{
				return false;
			}
			ReferenceHub ownerHub = Info.OwnerHub;
			if (ownerHub == null || !(ownerHub.roleManager.CurrentRole is SpectatorRole { ReadyToRespawn: not false }))
			{
				return false;
			}
			return true;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			Scp1507VocalizeAbility.OnServerVocalize -= OnVocalize;
		}

		protected override void Start()
		{
			SpawnVariant(Info.RoleType);
			Network_lastResetTime = NetworkTime.time;
			base.Start();
			Scp1507VocalizeAbility.OnServerVocalize += OnVocalize;
		}

		private void FixedUpdate()
		{
			if (_unfreezeDelay <= 0)
			{
				return;
			}
			_unfreezeDelay--;
			if (_unfreezeDelay > 0)
			{
				return;
			}
			Rigidbody[] linkedRigidbodies = LinkedRigidbodies;
			foreach (Rigidbody rigidbody in linkedRigidbodies)
			{
				if (!(rigidbody == null))
				{
					rigidbody.isKinematic = false;
				}
			}
		}

		private void SpawnVariant(RoleTypeId role)
		{
			GameObject[] array;
			switch (role)
			{
			default:
				return;
			case RoleTypeId.AlphaFlamingo:
				array = _alphaVariants;
				break;
			case RoleTypeId.ZombieFlamingo:
				array = _zombieVariants;
				break;
			case RoleTypeId.Flamingo:
				array = _regularVariants;
				break;
			case RoleTypeId.NtfFlamingo:
				array = _ntfVariants;
				break;
			case RoleTypeId.ChaosFlamingo:
				array = _ciVariants;
				break;
			}
			GameObject gameObject = array.RandomItem();
			GameObject gameObject2 = Object.Instantiate(gameObject, base.transform);
			gameObject2.transform.SetLocalPositionAndRotation(gameObject.transform.localPosition, gameObject.transform.localRotation);
			LinkedRigidbodies = gameObject2.GetComponentsInChildren<Rigidbody>();
			LinkedRigidbodiesTransforms = new Transform[LinkedRigidbodies.Length];
			for (int i = 0; i < LinkedRigidbodies.Length; i++)
			{
				Rigidbody rigidbody = LinkedRigidbodies[i];
				rigidbody.isKinematic = true;
				LinkedRigidbodiesTransforms[i] = rigidbody.transform;
			}
			_unfreezeDelay = 3;
		}

		private void OnVocalize(ReferenceHub hub)
		{
			if (!NetworkServer.active || !ValidateRevive(hub))
			{
				return;
			}
			Scp1507Role scp1507Role = hub.roleManager.CurrentRole as Scp1507Role;
			bool flag = false;
			for (int i = 0; i < LinkedRigidbodiesTransforms.Length; i++)
			{
				if (!(scp1507Role.SqrDistanceTo(LinkedRigidbodiesTransforms[i].position) > 15f))
				{
					flag = true;
					break;
				}
			}
			if (flag || !(scp1507Role.SqrDistanceTo(Info.StartRelativePosition.Position) > 15f))
			{
				float num = 1f / 12f;
				if (scp1507Role.RoleTypeId == RoleTypeId.AlphaFlamingo)
				{
					num *= 2f;
				}
				Network_lastResetTime = NetworkTime.time;
				Network_revivalProgress = _revivalProgress + num;
				if (!(_revivalProgress < 1f))
				{
					Info.OwnerHub.roleManager.ServerSetRole(Info.RoleType, RoleChangeReason.Revived);
				}
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			RagdollManager.ServerOnRagdollCreated += ServerOnRagdollCreated;
		}

		private static void ServerOnRagdollCreated(ReferenceHub owner, BasicRagdoll basicRagdoll)
		{
			if (!(owner == null) && owner.roleManager.CurrentRole is Scp1507Role scp1507Role && basicRagdoll is Scp1507Ragdoll scp1507Ragdoll)
			{
				scp1507Ragdoll.Network_hasAlreadyRevived = scp1507Role.AlreadyRevived;
			}
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
				writer.WriteFloat(_revivalProgress);
				writer.WriteBool(_hasAlreadyRevived);
				writer.WriteDouble(_lastResetTime);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteFloat(_revivalProgress);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				writer.WriteBool(_hasAlreadyRevived);
			}
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteDouble(_lastResetTime);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _revivalProgress, null, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref _hasAlreadyRevived, null, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref _lastResetTime, null, reader.ReadDouble());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _revivalProgress, null, reader.ReadFloat());
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _hasAlreadyRevived, null, reader.ReadBool());
			}
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _lastResetTime, null, reader.ReadDouble());
			}
		}
	}
}

using Mirror;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieRole : FpcStandardScp, ISubroutinedRole, IHumeShieldedRole, IHudScp, IAdvancedCameraController, ICameraController
	{
		[SerializeField]
		private GameObject _confirmBoxPrefab;

		[Tooltip("The maximum amount of health the special zombie will have.")]
		[SerializeField]
		private ushort _specialMaxHp = 600;

		[Tooltip("Modifier applied based on how many times the zombie was revived for.")]
		[SerializeField]
		private float _revivesModifier = 0.9f;

		private ushort _syncMaxHealth;

		private bool _showConfirmationBox;

		private ZombieConsumeAbility _consumeAbility;

		public override float MaxHealth => (int)_syncMaxHealth;

		public override Vector3 CameraPosition => _consumeAbility.ProcessCamPos(base.CameraPosition);

		public override float HorizontalRotation => _consumeAbility.ProcessRotation().y;

		public override float VerticalRotation => _consumeAbility.ProcessRotation().x;

		public float RollRotation => _consumeAbility.ProcessRotation().z;

		[field: SerializeField]
		public HumeShieldModuleBase HumeShieldModule { get; private set; }

		[field: SerializeField]
		public SubroutineManagerModule SubroutineModule { get; private set; }

		[field: SerializeField]
		public ScpHudBase HudPrefab { get; private set; }

		private void Awake()
		{
			SubroutineModule.TryGetSubroutine<ZombieConsumeAbility>(out _consumeAbility);
		}

		public override void WritePublicSpawnData(NetworkWriter writer)
		{
			writer.WriteUShort(_syncMaxHealth);
			writer.WriteBool(_showConfirmationBox);
			base.WritePublicSpawnData(writer);
		}

		public override void ReadSpawnData(NetworkReader reader)
		{
			_syncMaxHealth = reader.ReadUShort();
			_showConfirmationBox = reader.ReadBool();
			base.ReadSpawnData(reader);
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			if (TryGetOwner(out var owner) && NetworkServer.active)
			{
				bool num = ReferenceHub.AllHubs.Any((ReferenceHub x) => x.roleManager.CurrentRole is Scp049Role scp049Role && scp049Role.SubroutineModule.TryGetSubroutine<Scp049SenseAbility>(out var subroutine) && subroutine.SpecialZombies.Contains(owner));
				int resurrectionsNumber = Scp049ResurrectAbility.GetResurrectionsNumber(owner);
				float num2 = (num ? ((float)(int)_specialMaxHp) : base.MaxHealth);
				for (int num3 = 0; num3 < resurrectionsNumber; num3++)
				{
					num2 *= _revivesModifier;
				}
				_syncMaxHealth = (ushort)(Mathf.RoundToInt(num2 / 10f) * 10);
				Scp049ResurrectAbility.RegisterPlayerResurrection(owner);
				_showConfirmationBox = resurrectionsNumber < 1;
			}
		}

		public override void DisableRole(RoleTypeId newRole)
		{
			bool isLocalPlayer = base.IsLocalPlayer;
			base.DisableRole(newRole);
			_syncMaxHealth = 0;
			if (_showConfirmationBox && isLocalPlayer && newRole == RoleTypeId.Spectator && ReferenceHub.AllHubs.Any((ReferenceHub x) => x.roleManager.CurrentRole is Scp049Role))
			{
				Object.Instantiate(_confirmBoxPrefab);
			}
		}
	}
}

using System.Diagnostics;
using AudioPooling;
using CursorManagement;
using GameObjectPools;
using LabApi.Events.Arguments.Scp106Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106SinkholeController : SubroutineBase, ICursorOverride, IPoolResettable, IPoolSpawnable
	{
		public delegate void SubmergeStateChanged(Scp106Role scp106, bool newTargetSubmerged);

		private const float AudioFadeIntensity = 8f;

		private const float AudioFadeAbs = 0.07f;

		private const float EmergeCooldownDuration = 5f;

		private const float NearEmergenceAlertVolume = 0.7f;

		private const float SinkholeStingerCooldown = 1.2f;

		private float _toggleTime;

		private int _vigorAbilitiesCount;

		private int _lastActiveVigorAbility;

		private Scp106VigorAbilityBase[] _vigorAbilities;

		private readonly InconsistentAbilityCooldown _submergeCooldown = new InconsistentAbilityCooldown();

		private static readonly Stopwatch LastPlayedStingerSw = new Stopwatch();

		[SerializeField]
		private AudioClip _emergeSound;

		[SerializeField]
		private AudioClip _submergeSound;

		[SerializeField]
		private AudioClip _nearEmergenceAlertSound;

		[SerializeField]
		private AudioSource _toggleAudioSource;

		private float CurTime => Time.timeSinceLevelLoad;

		public CursorOverrideMode CursorOverride => CursorOverrideMode.NoOverride;

		public bool LockMovement => IsDuringAnimation;

		public float ElapsedToggle => CurTime - _toggleTime;

		public bool IsDuringAnimation => ElapsedToggle < TargetTransitionDuration;

		public IAbilityCooldown ReadonlyCooldown => _submergeCooldown;

		public bool IsHidden
		{
			get
			{
				if (TargetSubmerged)
				{
					return !IsDuringAnimation;
				}
				return false;
			}
		}

		public bool TargetSubmerged { get; private set; }

		public float TargetTransitionDuration { get; private set; }

		public float SubmergeProgress
		{
			get
			{
				float num = ElapsedToggle / TargetTransitionDuration;
				if (!TargetSubmerged)
				{
					num = 1f - num;
				}
				return Mathf.Clamp01(num);
			}
		}

		public static event SubmergeStateChanged OnSubmergeStateChange;

		public static bool TryTriggerCooldown()
		{
			if (LastPlayedStingerSw.IsRunning && LastPlayedStingerSw.Elapsed.TotalSeconds < 1.2000000476837158)
			{
				return false;
			}
			LastPlayedStingerSw.Restart();
			return true;
		}

		public void ModifyCooldown(double modifyAmount)
		{
			_submergeCooldown.NextUse += modifyAmount;
			ServerSendRpc(toAll: true);
		}

		public void PlayEmergenceAlert(Vector3 ownerPosition, float range)
		{
			if (!NetworkClient.active || !ReferenceHub.TryGetLocalHub(out var hub))
			{
				return;
			}
			bool num = hub.roleManager.CurrentRole.Team == Team.SCPs;
			SpectatableModuleBase currentTarget = SpectatorTargetTracker.CurrentTarget;
			int num2;
			if ((object)currentTarget != null)
			{
				PlayerRoleBase mainRole = currentTarget.MainRole;
				if ((object)mainRole != null)
				{
					num2 = ((mainRole.Team == Team.SCPs) ? 1 : 0);
					goto IL_0046;
				}
			}
			num2 = 0;
			goto IL_0046;
			IL_0046:
			bool flag = (byte)num2 != 0;
			if (!(num | flag))
			{
				Transform transform = MainCameraController.CurrentCamera.transform;
				if ((ownerPosition - transform.position).MagnitudeIgnoreY() <= range && TryTriggerCooldown())
				{
					AudioSourcePoolManager.Play2D(_nearEmergenceAlertSound, 0.7f);
					LastPlayedStingerSw.Restart();
				}
			}
		}

		public void SpawnObject()
		{
			if (base.Role.TryGetOwner(out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				fpcRole.FpcModule.Motor.RegisterMovementLock(this);
			}
		}

		public void ResetObject()
		{
			if (base.Role.TryGetOwner(out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				fpcRole.FpcModule.Motor.UnregisterMovementLock(this);
			}
			_submergeCooldown.Clear();
			TargetSubmerged = false;
			_toggleTime = 0f;
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBool(TargetSubmerged);
			writer.WriteFloat(TargetTransitionDuration);
			_submergeCooldown.WriteCooldown(writer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			bool targetSubmerged = TargetSubmerged;
			TargetSubmerged = reader.ReadBool();
			TargetTransitionDuration = reader.ReadFloat();
			_submergeCooldown.ReadCooldown(reader);
			if (targetSubmerged != TargetSubmerged)
			{
				_toggleTime = CurTime;
				_toggleAudioSource.PlayOneShot(TargetSubmerged ? _submergeSound : _emergeSound);
				OnSubmergeStateChange?.Invoke(base.Role as Scp106Role, TargetSubmerged);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			SubroutineBase[] allSubroutines = (base.Role as Scp106Role).SubroutineModule.AllSubroutines;
			_vigorAbilities = new Scp106VigorAbilityBase[allSubroutines.Length];
			_vigorAbilitiesCount = 0;
			for (int i = 0; i < allSubroutines.Length; i++)
			{
				if (allSubroutines[i] is Scp106VigorAbilityBase scp106VigorAbilityBase)
				{
					_vigorAbilities[_vigorAbilitiesCount++] = scp106VigorAbilityBase;
				}
			}
		}

		private void ServerSetSubmerged(bool targetSubmerged, float animTime)
		{
			if (!NetworkServer.active || TargetSubmerged == targetSubmerged)
			{
				return;
			}
			bool flag = base.Role.TryGetOwner(out var hub);
			if (flag)
			{
				Scp106ChangingSubmersionStatusEventArgs e = new Scp106ChangingSubmersionStatusEventArgs(hub, targetSubmerged);
				Scp106Events.OnChangingSubmersionStatus(e);
				if (!e.IsAllowed)
				{
					return;
				}
			}
			if (!targetSubmerged)
			{
				_submergeCooldown.Trigger(5.0);
			}
			TargetSubmerged = targetSubmerged;
			TargetTransitionDuration = animTime;
			_toggleTime = CurTime;
			OnSubmergeStateChange?.Invoke(base.Role as Scp106Role, targetSubmerged);
			// On a host the RPC sees no state change, so play the toggle sound here.
			if (NetworkClient.active && _toggleAudioSource != null)
			{
				_toggleAudioSource.PlayOneShot(targetSubmerged ? _submergeSound : _emergeSound);
			}
			ServerSendRpc(toAll: true);
			if (flag)
			{
				Scp106Events.OnChangedSubmersionStatus(new Scp106ChangedSubmersionStatusEventArgs(hub, targetSubmerged));
			}
		}

		private void Update()
		{
			_toggleAudioSource.volume = 8f * (1f - SubmergeProgress) - 0.07f;
			if (!NetworkServer.active)
			{
				return;
			}
			for (int i = 0; i < _vigorAbilitiesCount; i++)
			{
				Scp106VigorAbilityBase scp106VigorAbilityBase = _vigorAbilities[i];
				if (scp106VigorAbilityBase.ServerWantsSubmerged)
				{
					_lastActiveVigorAbility = i;
					ServerSetSubmerged(targetSubmerged: true, scp106VigorAbilityBase.SubmergeTime);
					return;
				}
			}
			ServerSetSubmerged(targetSubmerged: false, _vigorAbilities[_lastActiveVigorAbility].EmergeTime);
		}
	}
}

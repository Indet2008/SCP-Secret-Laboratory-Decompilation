using System;
using System.Collections.Generic;
using System.Diagnostics;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.Scp939Events;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939AmnesticCloudAbility : KeySubroutine<Scp939Role>
	{
		private static readonly Dictionary<RoomName, float[]> WhitelistedFloors = new Dictionary<RoomName, float[]>
		{
			[RoomName.EzOfficeSmall] = new float[1] { -0.527f },
			[RoomName.EzOfficeStoried] = new float[1] { 3.767f },
			[RoomName.Hcz106] = new float[1] { 1.19f },
			[RoomName.Hcz079] = new float[1] { -4.334f },
			[RoomName.HczWarhead] = new float[3] { -75.33f, -72.33f, -70.26f }
		};

		private const float FloorTolerance = 0.2f;

		private bool _targetState;

		private float _sendDuration;

		private Scp939FocusAbility _focusAbility;

		private readonly Stopwatch _beginHeldSw = Stopwatch.StartNew();

		[SerializeField]
		private Scp939AmnesticCloudInstance _instancePrefab;

		[SerializeField]
		private float _failedCooldown;

		[SerializeField]
		private float _placedCooldown;

		public readonly AbilityCooldown Duration = new AbilityCooldown();

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		public readonly AbilityCooldown HudIndicatorMin = new AbilityCooldown();

		public readonly AbilityCooldown HudIndicatorMax = new AbilityCooldown();

		protected override ActionName TargetKey => ActionName.ToggleFlashlight;

		protected override bool KeyPressable
		{
			get
			{
				if (base.KeyPressable)
				{
					return _focusAbility.State == 0f;
				}
				return false;
			}
		}

		public float HoldDuration => (float)_beginHeldSw.Elapsed.TotalSeconds;

		public bool TargetState
		{
			get
			{
				return _targetState;
			}
			set
			{
				if (_targetState != value)
				{
					_targetState = value;
					if (value)
					{
						OnStateEnabled();
					}
					else
					{
						OnStateDisabled();
					}
				}
			}
		}

		public event Action<Scp939HudTranslation> OnDeployFailed;

		private void OnStateEnabled()
		{
			Scp939CreatingAmnesticCloudEventArgs e = new Scp939CreatingAmnesticCloudEventArgs(base.Owner);
			Scp939Events.OnCreatingAmnesticCloud(e);
			if (e.IsAllowed)
			{
				_beginHeldSw.Restart();
				HudIndicatorMax.Clear();
				HudIndicatorMin.Trigger(_instancePrefab.MinMaxTime.y);
				if (NetworkServer.active)
				{
					Scp939AmnesticCloudInstance scp939AmnesticCloudInstance = UnityEngine.Object.Instantiate(_instancePrefab);
					scp939AmnesticCloudInstance.ServerSetup(base.Owner);
					Scp939Events.OnCreatedAmnesticCloud(new Scp939CreatedAmnesticCloudEventArgs(base.Owner, scp939AmnesticCloudInstance));
				}
			}
		}

		private void OnStateDisabled()
		{
			_beginHeldSw.Reset();
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp939FocusAbility>(out _focusAbility);
		}

		protected override void Update()
		{
			base.Update();
			if ((base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated()) && TargetState && HudIndicatorMax.IsReady)
			{
				Vector2 minMaxTime = _instancePrefab.MinMaxTime;
				if (!(HoldDuration < minMaxTime.x))
				{
					HudIndicatorMax.NextUse = HudIndicatorMin.NextUse;
					HudIndicatorMax.InitialTime = HudIndicatorMin.InitialTime;
				}
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Cooldown.IsReady)
			{
				if (!ValidateFloor())
				{
					ClientCancel(Scp939HudTranslation.CloudFailedPositionInvalid);
					return;
				}
				TargetState = true;
				ClientSendCmd();
			}
		}

		protected override void OnKeyUp()
		{
			base.OnKeyUp();
			if (TargetState)
			{
				ClientCancel(Scp939HudTranslation.PressKeyToLunge);
			}
		}

		public bool ValidateFloor()
		{
			Vector3 pos = base.CastRole.FpcModule.Position;
			if (!pos.TryGetRoom(out var room))
			{
				return false;
			}
			if (WhitelistedFloors.TryGetValue(room.Name, out var value))
			{
				float num = room.transform.position.y - pos.y;
				float[] array = value;
				foreach (float num2 in array)
				{
					if (!(Mathf.Abs(num + num2) > 0.2f))
					{
						return true;
					}
				}
			}
			if (!DoorVariant.DoorsByRoom.TryGetValue(room, out var value2))
			{
				return false;
			}
			float halfHeight = base.CastRole.FpcModule.CharController.height / 2f;
			return value2.Any((DoorVariant x) => Mathf.Abs(x.transform.position.y - pos.y + halfHeight) < 0.2f);
		}

		public void ClientCancel(Scp939HudTranslation reason)
		{
			if ((uint)(reason - 12) <= 1u)
			{
				OnDeployFailed?.Invoke(reason);
			}
			TargetState = false;
			ClientSendCmd();
		}

		public void ServerConfirmPlacement(float duration)
		{
			_sendDuration = duration;
			Cooldown.Trigger(_placedCooldown);
			ServerSendRpc(toAll: true);
		}

		public void ServerFailPlacement()
		{
			_sendDuration = -128f;
			Cooldown.Trigger(_failedCooldown);
			ServerSendRpc(toAll: true);
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteBool(TargetState);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Cooldown.Clear();
			Duration.Clear();
			HudIndicatorMin.Clear();
			HudIndicatorMax.Clear();
			TargetState = false;
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			bool flag = reader.ReadBool();
			bool toAll = flag != TargetState;
			if (flag)
			{
				if (Cooldown.IsReady)
				{
					TargetState = flag;
					Cooldown.Trigger(_failedCooldown);
				}
			}
			else
			{
				TargetState = false;
			}
			ServerSendRpc(toAll);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBool(TargetState);
			if (!TargetState)
			{
				Cooldown.WriteCooldown(writer);
				writer.WriteFloat(_sendDuration);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			TargetState = reader.ReadBool();
			if (!TargetState)
			{
				Cooldown.ReadCooldown(reader);
				float num = reader.ReadFloat();
				if (num <= 0f)
				{
					Duration.Clear();
					return;
				}
				Duration.Trigger(num);
				Cooldown.InitialTime += num;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientStarted += () =>
			{
				if (!RoleTypeId.Scp939.TryGetRoleTemplate<Scp939Role>(out var result))
				{
					throw new InvalidOperationException("Cannot register amnestic cloud. SCP-939 role template not found.");
				}
				if (!result.SubroutineModule.TryGetSubroutine<Scp939AmnesticCloudAbility>(out var subroutine))
				{
					throw new InvalidOperationException("Cannot register amnestic cloud. Ability not found.");
				}
				NetworkClient.RegisterPrefab(subroutine._instancePrefab.gameObject);
			};
		}
	}
}

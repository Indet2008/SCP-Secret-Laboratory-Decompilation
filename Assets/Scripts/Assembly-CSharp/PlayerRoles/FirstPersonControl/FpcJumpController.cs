using System;
using CustomPlayerEffects;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using NetworkManagerUtils.Dummies;
using PlayerRoles.FirstPersonControl.NetworkMessages;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcJumpController : IDummyActionProvider
	{
		private const float StickToGroundForce = 10f;

		private static KeyCode _keyJump;

		private bool _requestedJump;

		public FpcMotor Motor { get; private set; }

		public ReferenceHub Hub => Motor.Hub;

		public bool IsJumping { get; private set; }

		public bool WantsToJump
		{
			get
			{
				if (!_requestedJump)
				{
					if (Hub.isLocalPlayer && Input.GetKeyDown(_keyJump))
					{
						return !Motor.InputLocked;
					}
					return false;
				}
				return true;
			}
			set
			{
				_requestedJump = value;
			}
		}

		public float JumpMultiplier
		{
			get
			{
				float num = 1f;
				StatusEffectBase[] allEffects = Hub.playerEffectsController.AllEffects;
				foreach (StatusEffectBase statusEffectBase in allEffects)
				{
					if (statusEffectBase.IsEnabled && statusEffectBase is IJumpModifierEffect jumpModifierEffect)
					{
						num *= jumpModifierEffect.JumpStrengthMultplier;
					}
				}
				return num;
			}
		}

		public FpcJumpController(FpcMotor motor)
		{
			Motor = motor;
		}

		public static void ReloadInputConfigs()
		{
			// Client-only body stripped from the server build (restored after the SL 12 CE client).
			_keyJump = NewInput.GetKey(ActionName.Jump);
		}
		[RuntimeInitializeOnLoadMethod]
		private static void Initialize()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler((FpcJumpMessages.FpcForceJumpMessage msg) =>
				{
					if (!(msg.TargetHub == null) && msg.TargetHub.roleManager.CurrentRole is IFpcRole fpcRole)
					{
						fpcRole.FpcModule.Motor.JumpController.ForceJump(msg.Force);
					}
				});
			};
		}

		public bool ProcessJump(ref bool sendJump, float jumpSpeed, out float yVelocity)
		{
			float jumpMultiplier = JumpMultiplier;
			bool result = false;
			yVelocity = 0f;
			if (jumpMultiplier > 0f && WantsToJump)
			{
				if (jumpSpeed > 0f)
				{
					yVelocity = jumpSpeed * jumpMultiplier;
					result = true;
					PlayerEvents.OnJumped(new PlayerJumpedEventArgs(Hub, yVelocity));
				}
				_requestedJump = false;
				IsJumping = true;
				sendJump = true;
			}
			else
			{
				yVelocity = -10f;
				IsJumping = false;
			}
			return result;
		}

		public void ForceJump(float jumpSpeed)
		{
			float jumpMultiplier = JumpMultiplier;
			if (!(jumpMultiplier <= 0f))
			{
				IsJumping = true;
				Vector3 moveDirection = Motor.MoveDirection;
				moveDirection.y = jumpSpeed * jumpMultiplier;
				Motor.MoveDirection = moveDirection;
				Motor.UpdateFloating();
				if (NetworkServer.active)
				{
					Hub.connectionToClient.Send(new FpcJumpMessages.FpcForceJumpMessage(Hub, jumpSpeed));
				}
				PlayerEvents.OnJumped(new PlayerJumpedEventArgs(Hub, jumpSpeed));
			}
		}

		public void PopulateDummyActions(Action<DummyAction> actionAdder)
		{
			actionAdder(new DummyAction("Jump", () =>
			{
				ForceJump(Motor.MainModule.JumpSpeed);
			}));
		}
	}
}

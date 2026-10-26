using System;
using System.Collections.Generic;
using AudioPooling;
using CustomPlayerEffects;
using Footprinting;
using Interactables.Verification;
using InventorySystem.Items;
using InventorySystem.Items.Usables.Scp330;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class Scp330Interobject : NetworkBehaviour, IServerInteractable, IInteractable
	{
		[NonSerialized]
		public readonly List<Footprint> PreviousUses = new List<Footprint>();

		[SerializeField]
		private AudioClip _takeSound;

		public static int MaxAmountPerLife { get; set; }

		public static float TakeCooldown { get; set; }

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!ply.IsHuman() || ply.HasBlock(BlockedInteraction.GrabItems))
			{
				return;
			}
			float num = TakeCooldown;
			int num2 = 0;
			bool playSound = true;
			bool allowPunishment = !IsTargetGodmode(ply);
			foreach (Footprint previousUse in PreviousUses)
			{
				if (previousUse.LifeIdentifier == ply.roleManager.CurrentRole.UniqueLifeIdentifier)
				{
					double totalSeconds = previousUse.Stopwatch.Elapsed.TotalSeconds;
					num = Mathf.Min(num, (float)totalSeconds);
					num2++;
				}
			}
			if (num < TakeCooldown || !Scp330Bag.CanAddCandy(ply))
			{
				return;
			}
			CandyKindID random = Scp330Candies.GetRandom();
			PlayerInteractingScp330EventArgs e = new PlayerInteractingScp330EventArgs(ply, num2, playSound, allowPunishment, random);
			PlayerEvents.OnInteractingScp330(e);
			if (!e.IsAllowed)
			{
				return;
			}
			playSound = e.PlaySound;
			allowPunishment = e.AllowPunishment;
			num2 = e.Uses;
			random = e.CandyType;
			if (random != CandyKindID.None && Scp330Bag.TryAddCandy(ply, random))
			{
				if (playSound)
				{
					RpcMakeSound();
				}
				if (allowPunishment && num2 >= MaxAmountPerLife)
				{
					ply.playerEffectsController.EnableEffect<SeveredHands>();
					ClearUsesForRole(ply.roleManager.CurrentRole);
				}
				else
				{
					PreviousUses.Add(new Footprint(ply));
				}
				PlayerEvents.OnInteractedScp330(new PlayerInteractedScp330EventArgs(ply, num2, playSound, allowPunishment, random));
			}
		}

		public void ClearUsesForRole(PlayerRoleBase prb)
		{
			for (int num = PreviousUses.Count - 1; num >= 0; num--)
			{
				if (PreviousUses[num].LifeIdentifier == prb.UniqueLifeIdentifier)
				{
					PreviousUses.RemoveAt(num);
				}
			}
		}

		[ClientRpc]
		public void RpcMakeSound()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Interactables.Interobjects.Scp330Interobject::RpcMakeSound()", 1231574529, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private bool IsTargetGodmode(ReferenceHub ply)
		{
			if (!ply.playerStats.TryGetModule<AdminFlagsStat>(out var module))
			{
				return false;
			}
			return module.HasFlag(AdminFlags.GodMode);
		}

		static Scp330Interobject()
		{
			MaxAmountPerLife = 2;
			TakeCooldown = 0.1f;
			RemoteProcedureCalls.RegisterRpc(typeof(Scp330Interobject), "System.Void Interactables.Interobjects.Scp330Interobject::RpcMakeSound()", InvokeUserCode_RpcMakeSound);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcMakeSound()
		{
			AudioSourcePoolManager.PlayOnTransform(_takeSound, base.transform);
		}

		protected static void InvokeUserCode_RpcMakeSound(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcMakeSound called on server.");
			}
			else
			{
				((Scp330Interobject)obj).UserCode_RpcMakeSound();
			}
		}
	}
}

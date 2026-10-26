using System;
using AudioPooling;
using CustomPlayerEffects;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.PlayableScps.Scp1507;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class FootstepRippleTrigger : RippleTriggerBase
	{
		private ReferenceHub _syncPlayer;

		private RelativePosition _syncPos;

		private byte _syncDistance;

		public override void SpawnObject()
		{
			base.SpawnObject();
			AnimatedCharacterModel.OnFootstepPlayed = (Action<AnimatedCharacterModel, float>)Delegate.Combine(AnimatedCharacterModel.OnFootstepPlayed, new Action<AnimatedCharacterModel, float>(OnFootstepPlayed));
			Scp1507Model.OnFootstepPlayed += OnFlamingoStep;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			AnimatedCharacterModel.OnFootstepPlayed = (Action<AnimatedCharacterModel, float>)Delegate.Remove(AnimatedCharacterModel.OnFootstepPlayed, new Action<AnimatedCharacterModel, float>(OnFootstepPlayed));
			Scp1507Model.OnFootstepPlayed -= OnFlamingoStep;
		}

		private void OnFlamingoStep(Scp1507Model flamingoModel)
		{
			OnFootstepPlayed(flamingoModel, 30f);
		}

		private void OnFootstepPlayed(CharacterModel model, float dis)
		{
			if (model.OwnerHub.isLocalPlayer)
			{
				RippleTriggerBase.SelfReport(dis);
			}
			if (NetworkServer.active && HitboxIdentity.IsEnemy(base.Owner, model.OwnerHub) && model.OwnerHub.roleManager.CurrentRole is IFpcRole fpcRole && (!model.OwnerHub.playerEffectsController.TryGetEffect<Invisible>(out var playerEffect) || !playerEffect.IsEnabled))
			{
				Vector3 position = base.CastRole.FpcModule.Position;
				Vector3 position2 = fpcRole.FpcModule.Position;
				if (!((position - position2).sqrMagnitude > dis * dis))
				{
					_syncPlayer = model.OwnerHub;
					_syncPos = new RelativePosition(position2);
					_syncDistance = (byte)Mathf.Min(dis, 255f);
					ServerSendRpcToObservers();
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteReferenceHub(_syncPlayer);
			writer.WriteRelativePosition(_syncPos);
			writer.WriteByte(_syncDistance);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (reader.TryReadReferenceHub(out _syncPlayer) && HitboxIdentity.IsEnemy(base.Owner, _syncPlayer) && _syncPlayer.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase)
			{
				_syncPos = reader.ReadRelativePosition();
				_syncDistance = reader.ReadByte();
				base.Player.Play(_syncPos.Position, fpcStandardRoleBase.RoleColor);
				OnPlayedRipple(_syncPlayer);
				if (fpcStandardRoleBase.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel)
				{
					AudioSourcePoolManager.PlayAtPosition(animatedCharacterModel.RandomFootstep, _syncPos.Position, (int)_syncDistance);
				}
			}
		}
	}
}

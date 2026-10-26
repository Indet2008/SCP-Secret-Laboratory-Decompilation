using System.Collections.Generic;
using System.Diagnostics;
using CustomPlayerEffects;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106StalkVisibilityController : StandardSubroutine<Scp106Role>
	{
		private const float AbsoluteDistance = 4f;

		private const float HealthToDistance = 0.3f;

		private const float InvisibleHeight = 8000f;

		private const float TransitionSpeed = 11.5f;

		private const float ServerTolerance = 5f;

		private const float SendCooldown = 0.08f;

		private const float SubmergeTolerance = 0.8f;

		private Scp106StalkAbility _stalk;

		private bool _anyFaded;

		private readonly Stopwatch _sendStopwatch = Stopwatch.StartNew();

		private readonly HashSet<CharacterModel> _affectedModels = new HashSet<CharacterModel>();

		public readonly Dictionary<int, byte> SyncDamage = new Dictionary<int, byte>();

		private void UpdateAll()
		{
			if (base.Owner.isLocalPlayer)
			{
				UpdateClient();
			}
			else if (base.Owner.IsLocallySpectated())
			{
				UpdateSpectator();
			}
			else if (_anyFaded)
			{
				CleanupFade();
			}
			if (NetworkServer.active)
			{
				UpdateServer();
			}
		}

		private void UpdateClient()
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!HitboxIdentity.IsEnemy(base.Owner, allHub) || base.Owner == allHub || !(allHub.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase))
				{
					continue;
				}
				float num = (GetVisibilityForPlayer(allHub, fpcStandardRoleBase) ? 11.5f : (-11.5f));
				FirstPersonMovementModule fpcModule = fpcStandardRoleBase.FpcModule;
				CharacterModel characterModelInstance = fpcModule.CharacterModelInstance;
				bool flag = characterModelInstance.Fade == 0f;
				characterModelInstance.Fade += num * Time.deltaTime;
				if (characterModelInstance.Fade < 1f)
				{
					_affectedModels.Add(characterModelInstance);
				}
				else
				{
					_affectedModels.Remove(characterModelInstance);
				}
				_anyFaded = true;
				if (!NetworkServer.active)
				{
					if (characterModelInstance.Fade == 0f)
					{
						fpcModule.Position = Vector3.up * 8000f;
					}
					else if (flag || fpcModule.Motor.IsInvisible)
					{
						fpcModule.Position = fpcModule.Motor.ReceivedPosition.Position;
					}
				}
			}
		}

		private void UpdateSpectator()
		{
			RefreshDamageDictionary();
			UpdateClient();
		}

		private void CleanupFade()
		{
			_affectedModels.ForEach((CharacterModel x) =>
			{
				x.Fade = 1f;
			});
			_affectedModels.Clear();
			_anyFaded = false;
		}

		private void UpdateServer()
		{
			if (_stalk.StalkActive)
			{
				RefreshDamageDictionary();
				if (!(_sendStopwatch.Elapsed.TotalSeconds < 0.07999999821186066))
				{
					_sendStopwatch.Restart();
					ServerSendRpc(toAll: false);
				}
			}
		}

		private void RefreshDamageDictionary()
		{
			SyncDamage.Clear();
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!HitboxIdentity.IsEnemy(base.Owner, allHub) || !(allHub.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					continue;
				}
				if (allHub.playerEffectsController.GetEffect<Traumatized>().IsEnabled)
				{
					SyncDamage[allHub.PlayerId] = 0;
					continue;
				}
				HealthStat module = allHub.playerStats.GetModule<HealthStat>();
				int num = Mathf.FloorToInt(module.MaxValue - module.CurValue);
				if (num != 0 && !(Vector3.Distance(fpcRole.FpcModule.Position, base.CastRole.FpcModule.Position) - 5f > (float)num * 0.3f + 4f))
				{
					SyncDamage[allHub.PlayerId] = (byte)Mathf.Clamp(num, 0, 255);
				}
			}
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp106StalkAbility>(out _stalk);
		}

		public bool GetVisibilityForPlayer(ReferenceHub hub, IFpcRole role)
		{
			FpcMotor motor = role.FpcModule.Motor;
			if (!NetworkServer.active && motor.IsInvisible)
			{
				return false;
			}
			if (!_stalk.StalkActive || base.CastRole.Sinkhole.SubmergeProgress < 0.8f)
			{
				return true;
			}
			if (hub.playerEffectsController.GetEffect<Invigorated>().IsEnabled)
			{
				return false;
			}
			if (hub.playerEffectsController.GetEffect<Traumatized>().IsEnabled)
			{
				return true;
			}
			if (!SyncDamage.TryGetValue(hub.PlayerId, out var value))
			{
				value = 0;
			}
			return Vector3.Distance(base.CastRole.FpcModule.Position, motor.ReceivedPosition.Position) < (float)(int)value * 0.3f + 4f;
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)SyncDamage.Count);
			foreach (KeyValuePair<int, byte> item in SyncDamage)
			{
				writer.WriteRecyclablePlayerId(new RecyclablePlayerId(item.Key));
				writer.WriteByte(item.Value);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			SyncDamage.Clear();
			byte b = reader.ReadByte();
			for (int i = 0; i < b; i++)
			{
				int value = reader.ReadRecyclablePlayerId().Value;
				SyncDamage[value] = reader.ReadByte();
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			FirstPersonMovementModule.OnPositionUpdated += UpdateAll;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			CleanupFade();
			FirstPersonMovementModule.OnPositionUpdated -= UpdateAll;
		}
	}
}

using CustomPlayerEffects;
using Mirror;
using PlayerRoles.FirstPersonControl.Thirdperson;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public readonly struct FpcFallDamageMessage : NetworkMessage
	{
		private const float SoundDistance = 14f;

		private const float SoundVolume = 1f;

		private readonly ReferenceHub _hub;

		private readonly Vector3 _prevPos;

		private readonly RoleTypeId _role;

		public FpcFallDamageMessage(ReferenceHub hub, Vector3 prevPos, RoleTypeId role)
		{
			_hub = hub;
			_prevPos = prevPos;
			_role = role;
		}

		public FpcFallDamageMessage(NetworkReader reader)
		{
			int value = reader.ReadRecyclablePlayerId().Value;
			if (value == 0)
			{
				_hub = null;
				_prevPos = reader.ReadRelativePosition().Position;
				_role = reader.ReadRoleType();
			}
			else
			{
				_hub = ReferenceHub.GetHub(value);
				_prevPos = Vector3.zero;
				_role = ((_hub != null) ? _hub.GetRoleId() : RoleTypeId.None);
			}
		}

		public void Write(NetworkWriter writer)
		{
			if (_hub == null || !_hub.IsAlive())
			{
				writer.WriteReferenceHub(null);
				writer.WriteRelativePosition(new RelativePosition(_prevPos));
				writer.WriteRoleType(_role);
			}
			else
			{
				writer.WriteReferenceHub(_hub);
			}
		}

		public void ProcessMessage()
		{
		}

		private bool TryGetFallSound(out AudioClip clip, out float volume)
		{
			clip = null;
			volume = 1f;
			if (_role == RoleTypeId.None)
			{
				return false;
			}
			if (TryGetCustomFallSound(out clip, out volume))
			{
				return true;
			}
			if (!_role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				return false;
			}
			if (!(result is IFpcRole fpcRole))
			{
				return false;
			}
			if (!fpcRole.FpcModule.CharacterModelTemplate.TryGetComponent<AnimatedCharacterModel>(out var component))
			{
				return false;
			}
			clip = component.SharedSettings.FallDamageSound;
			return true;
		}

		private bool TryGetCustomFallSound(out AudioClip clip, out float volume)
		{
			clip = null;
			volume = 1f;
			if (_hub == null)
			{
				return false;
			}
			for (int i = 0; i < _hub.playerEffectsController.EffectsLength; i++)
			{
				StatusEffectBase statusEffectBase = _hub.playerEffectsController.AllEffects[i];
				if (statusEffectBase.IsEnabled && statusEffectBase is ICustomFallSfxEffect customFallSfxEffect)
				{
					clip = customFallSfxEffect.FallSfxClip;
					volume = customFallSfxEffect.FallSfxVolume;
					return true;
				}
			}
			return false;
		}
	}
}

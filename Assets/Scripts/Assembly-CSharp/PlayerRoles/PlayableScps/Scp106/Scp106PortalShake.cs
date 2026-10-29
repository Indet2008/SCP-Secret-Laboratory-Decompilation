using CameraShaking;
using Mirror;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	// Client-only in the original: while SCP-106 submerges/emerges the camera moves over to the model's
	// StalkCameraTarget (so the sinking body is seen from behind) and sinks with it.
	public class Scp106PortalShake : IShakeEffect
	{
		private const float StalkHeight = -0.75f;

		private const float LookLerp = 300f;

		private readonly Scp106Model _model;

		private readonly Scp106Role _role;

		private static Scp106PortalShake _latestEffect;

		public Scp106PortalShake(Scp106Role role, Scp106Model model)
		{
			_role = role;
			_model = model;
			_latestEffect = this;
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			if (_model == null || _model.Pooled || !(_model.OwnerHub.isLocalPlayer || _model.OwnerHub.IsLocallySpectated()) || _latestEffect != this || _role.Pooled || !_role.TryGetOwner(out var hub))
			{
				shakeValues = ShakeEffectValues.None;
				return false;
			}
			Transform playerCameraReference = hub.PlayerCameraReference;
			Transform stalkCameraTarget = _model.StalkCameraTarget;
			float verticalLook = 0f;
			if (_role.Sinkhole.LockMovement)
			{
				verticalLook = Time.deltaTime * (playerCameraReference.localRotation.x - stalkCameraTarget.localRotation.x) * LookLerp;
			}
			Vector3 position = playerCameraReference.position;
			Vector3 position2 = stalkCameraTarget.position;
			Vector3 value = new Vector3(position2.x - position.x, _role.Sinkhole.SubmergeProgress * StalkHeight, position2.z - position.z);
			shakeValues = new ShakeEffectValues(null, null, value, 1f, verticalLook);
			return true;
		}

		public static void Register(Scp106Role role, Scp106Model model)
		{
			CameraShakeController.AddEffect(new Scp106PortalShake(role, model));
		}
	}
}

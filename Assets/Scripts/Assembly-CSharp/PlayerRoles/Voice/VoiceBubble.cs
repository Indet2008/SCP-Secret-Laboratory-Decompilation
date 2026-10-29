using System.Collections.Generic;
using System.Diagnostics;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using UnityEngine;
using VoiceChat;

namespace PlayerRoles.Voice
{
	public class VoiceBubble : MonoBehaviour
	{
		[global::System.Serializable]
		private struct Bubble
		{
			public global::UnityEngine.Sprite Icon;

			public float MaxDistance;

			public global::VoiceChat.VoiceChatChannel Channel;
		}

		[SerializeField]
		private Bubble[] _serializedOverrides;

		[SerializeField]
		private VoiceModuleBase _voiceModule;

		[SerializeField]
		private FirstPersonMovementModule _fpc;

		[SerializeField]
		private SpriteRenderer _rend;

		[SerializeField]
		private Gradient _colorOverNormalizedDistance;

		private const float SustainTime = 0.15f;

		private readonly Dictionary<VoiceChatChannel, Bubble> _overrides = new Dictionary<VoiceChatChannel, Bubble>();

		private readonly Stopwatch _sustainSw = new Stopwatch();

		private Transform _t;

		private bool _isCulled;

		private bool IsHidden
		{
			get
			{
				if (!_voiceModule.Role.TryGetOwner(out var owner) || owner == null)
				{
					return true;
				}
				if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase)
				{
					if (!fpcStandardRoleBase.VisibilityController.ValidateVisibility(owner))
					{
						return true;
					}
					if (fpcStandardRoleBase.FpcModule.CharacterModelInstance.Fade <= 0f)
					{
						return true;
					}
				}
				if (_sustainSw.Elapsed.TotalSeconds > 0.15000000596046448)
				{
					return true;
				}
				if (owner.isLocalPlayer)
				{
					return true;
				}
				return owner.IsLocallySpectated();
			}
		}

		private void OnEnable()
		{
			_isCulled = false;
		}

		private void OnDisable()
		{
			_isCulled = true;
		}

		private void Awake()
		{
			_t = base.transform;
			_serializedOverrides.ForEach(delegate(Bubble x)
			{
				_overrides[x.Channel] = x;
			});
			base.gameObject.SetActive(HideHUDController.IsHUDVisible);
			HideHUDController.ToggleHUD += base.gameObject.SetActive;
			MainCameraController.OnUpdated += UpdateIcon;
		}

		private void OnDestroy()
		{
			HideHUDController.ToggleHUD -= base.gameObject.SetActive;
			MainCameraController.OnUpdated -= UpdateIcon;
		}

		private void UpdateIcon()
		{
			if (_isCulled)
			{
				return;
			}
			if (_voiceModule.IsSpeaking)
			{
				_sustainSw.Restart();
			}
			if (!_overrides.TryGetValue(_voiceModule.CurrentChannel, out var value) || IsHidden)
			{
				_rend.enabled = false;
				return;
			}
			Transform currentCamera = MainCameraController.CurrentCamera;
			float time = 0f;
			if (value.MaxDistance > 0f)
			{
				time = Vector3.Distance(_fpc.Position, currentCamera.position) / value.MaxDistance;
			}
			_rend.enabled = true;
			_rend.sprite = value.Icon;
			_rend.color = _colorOverNormalizedDistance.Evaluate(time);
			_t.forward = currentCamera.forward;
		}
	}
}

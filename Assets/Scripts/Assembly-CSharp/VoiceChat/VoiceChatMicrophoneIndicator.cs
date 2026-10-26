using PlayerRoles;
using UnityEngine;
using UnityEngine.UI;

namespace VoiceChat
{
	public class VoiceChatMicrophoneIndicator : MonoBehaviour
	{
		[SerializeField]
		private Image _outline;

		[SerializeField]
		private Image _loudnessIndicator;

		[SerializeField]
		private float _minValue;

		[SerializeField]
		private float _maxValue;

		[SerializeField]
		private float _dropSpeed;

		[SerializeField]
		private float _curvePower;

		[SerializeField]
		private GameObject _root;

		private float FillAmount
		{
			get
			{
				return _loudnessIndicator.fillAmount;
			}
			set
			{
				_loudnessIndicator.fillAmount = Mathf.Clamp01(value);
			}
		}

		private void Awake()
		{
			_root.SetActive(value: false);
			PlayerRoleManager.OnRoleChanged += UpdateColor;
		}

		private void OnDestroy()
		{
			PlayerRoleManager.OnRoleChanged -= UpdateColor;
		}

		private void Update()
		{
			FillAmount -= Time.deltaTime * _dropSpeed;
			_root.SetActive(VoiceChatMicCapture.IsSpeaking);
			float num = Mathf.Pow(Mathf.InverseLerp(_minValue, _maxValue, VoiceChatMicCapture.Loudness), _curvePower);
			FillAmount = (VoiceChatMicCapture.IsSpeaking ? Mathf.Max(FillAmount, num) : num);
		}

		private void UpdateColor(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (userHub.isLocalPlayer)
			{
				Color roleColor = newRole.RoleColor;
				UpdateColor(_outline, roleColor);
				UpdateColor(_loudnessIndicator, roleColor);
			}
		}

		private static void UpdateColor(Image target, Color c)
		{
			target.color = new Color(c.r, c.g, c.b, target.color.a);
		}
	}
}

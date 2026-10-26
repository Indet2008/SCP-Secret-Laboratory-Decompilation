using PlayerRoles;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using VoiceChat.Playbacks;

namespace VoiceChat
{
	public class GlobalChatIndicator : MonoBehaviour
	{
		[SerializeField]
		private TextMeshProUGUI _nickname;

		[SerializeField]
		private RawImage _icon;

		[SerializeField]
		private Graphic[] _backgrounds;

		[SerializeField]
		private Outline[] _outlines;

		[SerializeField]
		private GameObject _iconRoot;

		[SerializeField]
		private Texture _radioIcon;

		[SerializeField]
		private Texture _intercomIcon;

		private IGlobalPlayback _playback;

		private ReferenceHub _owner;

		private bool _wasSpeaking;

		private float _noSpeakTime;

		private Color _lastColor;

		private Transform _t;

		private const float SustainTime = 0.3f;

		public void Setup(IGlobalPlayback igp, ReferenceHub owner)
		{
			_playback = igp;
			_owner = owner;
			_t = base.transform;
			_noSpeakTime = 0f;
		}

		public void Refresh()
		{
			if (!_playback.GlobalChatActive)
			{
				if (_wasSpeaking)
				{
					_noSpeakTime += Time.deltaTime;
					SetColors(0f);
					if (!(_noSpeakTime < 0.3f))
					{
						base.gameObject.SetActive(value: false);
						_wasSpeaking = false;
					}
				}
				return;
			}
			if (!_wasSpeaking)
			{
				base.gameObject.SetActive(value: true);
				_t.SetAsLastSibling();
				_wasSpeaking = true;
			}
			_lastColor = _playback.GlobalChatColor;
			SetColors(_playback.GlobalChatLoudness);
			if (TryGetIcon(_playback.GlobalChatIcon, _owner, out var result))
			{
				_icon.texture = result;
				_iconRoot.SetActive(value: true);
			}
			else
			{
				_iconRoot.SetActive(value: false);
			}
			_nickname.text = _playback.GlobalChatName;
		}

		private void SetColors(float loudness)
		{
			Graphic[] backgrounds = _backgrounds;
			for (int i = 0; i < backgrounds.Length; i++)
			{
				backgrounds[i].color = Color.Lerp(Color.black, _lastColor, loudness);
			}
			Outline[] outlines = _outlines;
			for (int i = 0; i < outlines.Length; i++)
			{
				outlines[i].effectColor = Color.Lerp(_lastColor, Color.white, loudness);
			}
		}

		private bool TryGetIcon(GlobalChatIconType icon, ReferenceHub owner, out Texture result)
		{
			result = null;
			switch (icon)
			{
			case GlobalChatIconType.None:
				return false;
			case GlobalChatIconType.Radio:
				result = _radioIcon;
				return true;
			case GlobalChatIconType.Intercom:
				result = _intercomIcon;
				return true;
			case GlobalChatIconType.Avatar:
				if (owner == null || !(owner.roleManager.CurrentRole is IAvatarRole avatarRole))
				{
					return false;
				}
				result = avatarRole.RoleAvatar;
				return true;
			default:
				return false;
			}
		}
	}
}

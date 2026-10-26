using UnityEngine;

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

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.Voice.VoiceBubble.Bubble[] _serializedOverrides;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.Voice.VoiceModuleBase _voiceModule;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.FirstPersonControl.FirstPersonMovementModule _fpc;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.SpriteRenderer _rend;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Gradient _colorOverNormalizedDistance;


	}
}

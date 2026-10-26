using UnityEngine;

namespace VoiceChat.Playbacks
{
	public interface IGlobalPlayback
	{
		bool GlobalChatActive { get; }

		Color GlobalChatColor { get; }

		string GlobalChatName { get; }

		float GlobalChatLoudness { get; }

		GlobalChatIconType GlobalChatIcon { get; }
	}
}

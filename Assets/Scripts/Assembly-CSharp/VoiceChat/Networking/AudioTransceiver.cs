using Mirror;
using UnityEngine;
using VoiceChat.Playbacks;

namespace VoiceChat.Networking
{
	public static class AudioTransceiver
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<AudioMessage>(ClientReceiveMessage);
			};
		}

		private static void ClientReceiveMessage(AudioMessage message)
		{
			foreach (SpeakerToyPlaybackBase allInstance in SpeakerToyPlaybackBase.AllInstances)
			{
				if (allInstance.ControllerId == message.ControllerId && !allInstance.Culled)
				{
					float maxDistance = allInstance.Source.maxDistance;
					if (!((allInstance.LastPosition - MainCameraController.CurrentCamera.position).sqrMagnitude > maxDistance * maxDistance))
					{
						allInstance.DecodeSamples(message);
					}
				}
			}
		}
	}
}

using Mirror;
using UnityEngine;

namespace Subtitles
{
	public static class SubtitleMessageExtensions
	{
		public static void WriteSubtitleMessage(this NetworkWriter writer, SubtitleMessage value)
		{
			SubtitlePart[] subtitleParts = value.SubtitleParts;
			if (subtitleParts == null || subtitleParts.Length == 0)
			{
				writer.WriteByte(0);
				return;
			}
			writer.WriteByte((byte)subtitleParts.Length);
			for (int i = 0; i < subtitleParts.Length; i++)
			{
				SubtitlePart subtitlePart = subtitleParts[i];
				writer.WriteByte((byte)((subtitlePart.OptionalData != null) ? ((byte)subtitlePart.OptionalData.Length) : 0));
				if (subtitlePart.OptionalData != null && subtitlePart.OptionalData.Length != 0)
				{
					for (int j = 0; j < subtitlePart.OptionalData.Length; j++)
					{
						writer.WriteString(subtitlePart.OptionalData[j]);
					}
				}
				writer.WriteByte((byte)subtitlePart.Subtitle);
			}
		}

		public static SubtitleMessage ReadSubtitleMessage(this NetworkReader reader)
		{
			int num = reader.ReadByte();
			SubtitlePart[] array = new SubtitlePart[num];
			for (int i = 0; i < num; i++)
			{
				int num2 = reader.ReadByte();
				string[] array2 = new string[num2];
				for (int j = 0; j < num2; j++)
				{
					array2[j] = reader.ReadString();
				}
				array[i] = new SubtitlePart((SubtitleType)reader.ReadByte(), (num2 == 0) ? null : array2);
			}
			return new SubtitleMessage
			{
				SubtitleParts = array
			};
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandlers;
		}

		private static void RegisterHandlers()
		{
			NetworkClient.ReplaceHandler<SubtitleMessage>(ClientMessageReceived);
		}

		private static void ClientMessageReceived(SubtitleMessage msg)
		{
			if (SubtitleController.Singleton != null && msg.SubtitleParts != null && msg.SubtitleParts.Length != 0)
			{
				SubtitleController.Singleton.SetupSubtitle(msg.SubtitleParts);
			}
		}
	}
}

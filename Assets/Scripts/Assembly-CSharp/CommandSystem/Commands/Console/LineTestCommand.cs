using System;
using DrawableLine;
using RemoteAdmin;
using UnityEngine;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(LineCommand))]
	public class LineTestCommand : ICommand
	{
		private const float MinDistanceBetweenPoints = 0.85f;

		private const float MaxDistanceBetweenPoints = 2f;

		private const float DefaultDuration = 6.5f;

		private const int MaxSegments = 7;

		public string Command { get; } = "test";

		public string[] Aliases { get; } = new string[1] { "t" };

		public string Description { get; } = "Creates a new line directly in front of the player.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			ReferenceHub hub;
			if (sender is PlayerCommandSender playerCommandSender)
			{
				hub = playerCommandSender.ReferenceHub;
			}
			else if (!ReferenceHub.TryGetLocalHub(out hub))
			{
				response = "You must be a player in order to execute this command.";
				return false;
			}
			int num = UnityEngine.Random.Range(3, 7);
			Transform playerCameraReference = hub.PlayerCameraReference;
			Vector3[] array = new Vector3[num];
			Vector3 position = playerCameraReference.position;
			for (int i = 0; i < num; i++)
			{
				switch (i)
				{
				case 1:
					position += playerCameraReference.forward * GetRandomDistance(allowNegativeValues: false);
					break;
				default:
				{
					Vector3 vector = playerCameraReference.forward * GetRandomDistance(allowNegativeValues: false);
					Vector3 vector2 = playerCameraReference.up * GetRandomDistance();
					Vector3 vector3 = playerCameraReference.right * GetRandomDistance();
					position += vector + vector2 + vector3;
					break;
				}
				case 0:
					break;
				}
				array[i] = position;
			}
			DrawableLines.GenerateLine(6.5f, array);
			response = $"Drawn a line between {array[0]} and {array[^1]}, with {num - 1} segments.";
			return true;
		}

		private static float GetRandomDistance(bool allowNegativeValues = true)
		{
			bool num = allowNegativeValues && UnityEngine.Random.Range(0, 2) == 0;
			float num2 = UnityEngine.Random.Range(0.85f, 2f);
			if (!num)
			{
				return num2;
			}
			return 0f - num2;
		}
	}
}

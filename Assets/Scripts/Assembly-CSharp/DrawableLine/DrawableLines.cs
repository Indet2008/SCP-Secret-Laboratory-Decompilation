using System;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace DrawableLine
{
	public static class DrawableLines
	{
		private const int RecommendedSegments = 8;

		public static float ClientDefaultDuration { get; set; } = 0.25f;

		public static Color ClientDefaultColor { get; set; } = Color.green;

		public static bool IsDebugModeEnabled { get; set; } = false;

		public static float? DurationOverride { get; set; }

		public static float DefaultDuration
		{
			get
			{
				if (!NetworkServer.active)
				{
					return ClientDefaultDuration;
				}
				return ServerDefaultDuration;
			}
		}

		public static Color DefaultColor
		{
			get
			{
				if (!NetworkServer.active)
				{
					return ClientDefaultColor;
				}
				return ServerDefaultColor;
			}
		}

		public static float ServerDefaultDuration { get; set; } = 0.3f;

		public static Color ServerDefaultColor { get; set; } = Color.red;

		public static void ClientGenerateLine(params Vector3[] positions)
		{
			ClientGenerateLine(ClientDefaultDuration, ClientDefaultColor, positions);
		}

		public static void ClientGenerateLine(float? duration, params Vector3[] positions)
		{
			ClientGenerateLine(duration, ClientDefaultColor, positions);
		}

		public static void ClientGenerateLine(Color? color, params Vector3[] positions)
		{
			ClientGenerateLine(ClientDefaultDuration, color, positions);
		}

		public static void ClientGenerateLine(float? duration, Color? color, params Vector3[] positions)
		{
			if (!color.HasValue)
			{
				color = ClientDefaultColor;
			}
			if (DurationOverride.HasValue)
			{
				duration = DurationOverride.Value;
			}
			else if (!duration.HasValue)
			{
				duration = ClientDefaultDuration;
			}
			for (int i = 0; i < positions.Length - 1; i++)
			{
				Vector3 start = positions[i];
				Vector3 end = positions[i + 1];
				DrawableLinesManager.DrawLine(start, end, color.Value, duration.Value);
			}
		}

		public static void GenerateLine(params Vector3[] positions)
		{
			GenerateLine(DefaultDuration, DefaultColor, positions);
		}

		public static void GenerateLine(Color? color, params Vector3[] positions)
		{
			GenerateLine(DefaultDuration, color, positions);
		}

		public static void GenerateLine(float? duration, params Vector3[] positions)
		{
			GenerateLine(duration, DefaultColor, positions);
		}

		public static void GenerateLine(float? duration, Color? color, params Vector3[] positions)
		{
			if (IsDebugModeEnabled)
			{
				if (NetworkServer.active)
				{
					ServerGenerateLine(duration, color, positions);
				}
				else
				{
					ClientGenerateLine(duration, color, positions);
				}
			}
		}

		public static void GenerateSphere(Vector3 origin, float radius, int segments = 8)
		{
			GenerateSphere(origin, radius, DefaultDuration, segments);
		}

		public static void GenerateSphere(Vector3 origin, float radius, float? duration, int segments = 8)
		{
			GenerateSphere(origin, radius, duration, DefaultColor, segments);
		}

		public static void GenerateSphere(Vector3 origin, float radius, Color? color, int segments = 8)
		{
			GenerateSphere(origin, radius, DefaultDuration, color, segments);
		}

		public static void GenerateSphere(Vector3 origin, float radius, float? duration, Color? color, int segments = 8)
		{
			GenerateLine(duration, color, GetCircle(origin, radius, horizontalAxis: true, segments));
			GenerateLine(duration, color, GetCircle(origin, radius, horizontalAxis: false, segments));
		}

		public static void GenerateBounds(Bounds bounds, float? duration)
		{
			GenerateBounds(bounds, duration, DefaultColor);
		}

		public static void GenerateBounds(Bounds bounds, Color? color)
		{
			GenerateBounds(bounds, DefaultDuration, color);
		}

		public static void GenerateBounds(Bounds bounds)
		{
			GenerateBounds(bounds, DefaultDuration, DefaultColor);
		}

		public static void GenerateBounds(Bounds bounds, float? duration, Color? color)
		{
			Vector3 center = bounds.center;
			Vector3 extents = bounds.extents;
			Vector3[] array = new Vector3[5];
			Vector3[] array2 = new Vector3[5];
			array[0] = center + new Vector3(0f - extents.x, 0f - extents.y, 0f - extents.z);
			array[1] = center + new Vector3(extents.x, 0f - extents.y, 0f - extents.z);
			array[2] = center + new Vector3(extents.x, 0f - extents.y, extents.z);
			array[3] = center + new Vector3(0f - extents.x, 0f - extents.y, extents.z);
			array[4] = array[0];
			array2[0] = center + new Vector3(0f - extents.x, extents.y, 0f - extents.z);
			array2[1] = center + new Vector3(extents.x, extents.y, 0f - extents.z);
			array2[2] = center + new Vector3(extents.x, extents.y, extents.z);
			array2[3] = center + new Vector3(0f - extents.x, extents.y, extents.z);
			array2[4] = array2[0];
			GenerateLine(duration, color, array);
			GenerateLine(duration, color, array2);
			for (int i = 0; i < 4; i++)
			{
				GenerateLine(duration, color, array[i], array2[i]);
			}
		}

		public static Vector3[] GetCircle(Vector3 origin, float radius, bool horizontalAxis = true, int segments = 8)
		{
			if (segments <= 0)
			{
				segments = 8;
			}
			if (segments % 2 != 0)
			{
				segments++;
			}
			Vector3[] array = new Vector3[segments + 1];
			float num = MathF.PI * 2f / (float)segments;
			for (int i = 0; i < segments; i++)
			{
				float f = (float)i * num;
				float num2 = Mathf.Cos(f) * radius;
				float num3 = Mathf.Sin(f) * radius;
				array[i] = (horizontalAxis ? new Vector3(origin.x + num2, origin.y + num3, origin.z) : new Vector3(origin.x + num2, origin.y, origin.z + num3));
			}
			array[^1] = array[0];
			return array;
		}

		public static void ServerGenerateLine(params Vector3[] positions)
		{
			ServerGenerateLine(ServerDefaultDuration, ServerDefaultColor, positions);
		}

		public static void ServerGenerateLine(float? duration, params Vector3[] positions)
		{
			ServerGenerateLine(duration, ServerDefaultColor, positions);
		}

		public static void ServerGenerateLine(Color? color, params Vector3[] positions)
		{
			ServerGenerateLine(ServerDefaultDuration, color, positions);
		}

		public static void ServerGenerateLine(float? duration, Color? color, params Vector3[] positions)
		{
			if (NetworkServer.active && IsDebugModeEnabled)
			{
				ServerGenerateMessage(duration, color, positions).SendToAuthenticated();
			}
		}

		public static void ServerGenerateLine(ReferenceHub hub, params Vector3[] positions)
		{
			ServerGenerateLine(hub, ServerDefaultDuration, ServerDefaultColor, positions);
		}

		public static void ServerGenerateLine(ReferenceHub hub, float? duration, params Vector3[] positions)
		{
			ServerGenerateLine(hub, duration, ServerDefaultColor, positions);
		}

		public static void ServerGenerateLine(ReferenceHub hub, Color? color, params Vector3[] positions)
		{
			ServerGenerateLine(hub, ServerDefaultDuration, color, positions);
		}

		public static void ServerGenerateLine(ReferenceHub hub, float? duration, Color? color, params Vector3[] positions)
		{
			if (NetworkServer.active && IsDebugModeEnabled)
			{
				hub.connectionToServer.Send(ServerGenerateMessage(duration, color, positions));
			}
		}

		private static DrawableLineMessage ServerGenerateMessage(float? duration, Color? color, Vector3[] positions)
		{
			if (DurationOverride.HasValue)
			{
				duration = DurationOverride.Value;
			}
			else if (!duration.HasValue)
			{
				duration = ServerDefaultDuration;
			}
			if (!color.HasValue)
			{
				color = ServerDefaultColor;
			}
			return new DrawableLineMessage(duration, color, positions);
		}
	}
}

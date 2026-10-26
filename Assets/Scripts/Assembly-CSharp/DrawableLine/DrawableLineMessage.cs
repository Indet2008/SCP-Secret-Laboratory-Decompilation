using Mirror;
using UnityEngine;

namespace DrawableLine
{
	public readonly struct DrawableLineMessage : NetworkMessage
	{
		private readonly float? _duration;

		private readonly Color? _color;

		private readonly Vector3[] _positions;

		public DrawableLineMessage(float? duration, Color? color, Vector3[] positions)
		{
			_duration = duration;
			_color = color;
			_positions = positions;
		}

		public DrawableLineMessage(NetworkReader reader)
		{
			_duration = reader.ReadFloatNullable();
			_color = reader.ReadColorNullable();
			_positions = reader.ReadArray<Vector3>();
		}

		public void WriteMessage(NetworkWriter writer)
		{
			writer.WriteFloatNullable(_duration);
			writer.WriteColorNullable(_color);
			writer.WriteArray(_positions);
		}

		public void GenerateLine()
		{
			DrawableLines.ClientGenerateLine(_duration, _color, _positions);
		}
	}
}

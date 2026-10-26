using System;
using UnityEngine;

namespace MapGeneration
{
	[Serializable]
	public struct GlyphShapePair
	{
		public Color32 GlyphColor;

		public Vector2Int GlyphCenterOffset;

		public RoomShape RoomShape;

		public RoomName[] SpecificRooms;

		public float[] RoomRotations;
	}
}

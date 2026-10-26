using System;
using UnityEngine;

namespace MapGeneration
{
	[Serializable]
	public struct AtlasInterpretation
	{
		public RoomShape RoomShape;

		public RoomName[] SpecificRooms;

		public float RotationY;

		public Vector2Int Coords;

		public AtlasInterpretation(GlyphShapePair scannedPair, System.Random rng, int pixelX, int pixelY)
		{
			Coords = new Vector2Int(pixelX / 3, pixelY / 3);
			RoomShape = scannedPair.RoomShape;
			SpecificRooms = scannedPair.SpecificRooms;
			float[] roomRotations = scannedPair.RoomRotations;
			RotationY = roomRotations[rng.Next(roomRotations.Length)];
		}

		public override string ToString()
		{
			return $"{GetType().Name} (Shape={RoomShape} Spcf={SpecificRooms.Length} Rot={RotationY} Coords={Coords.x}x{Coords.y})";
		}
	}
}

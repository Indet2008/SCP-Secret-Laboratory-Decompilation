namespace Mirror
{
	public static class NetworkReaderExtensions
	{
		public static byte ReadByte(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<byte>();
		}

		public static byte? ReadByteNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<byte>();
		}

		public static sbyte ReadSByte(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<sbyte>();
		}

		public static sbyte? ReadSByteNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<sbyte>();
		}

		public static char ReadChar(this global::Mirror.NetworkReader reader)
		{
			return (char)reader.ReadBlittable<ushort>();
		}

		public static char? ReadCharNullable(this global::Mirror.NetworkReader reader)
		{
			return (char?)reader.ReadBlittableNullable<ushort>();
		}

		public static bool ReadBool(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<byte>() != 0;
		}

		public static bool? ReadBoolNullable(this global::Mirror.NetworkReader reader)
		{
			byte? b = reader.ReadBlittableNullable<byte>();
			if (!b.HasValue)
			{
				return null;
			}
			return b.Value != 0;
		}

		public static short ReadShort(this global::Mirror.NetworkReader reader)
		{
			return (short)reader.ReadUShort();
		}

		public static short? ReadShortNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<short>();
		}

		public static ushort ReadUShort(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<ushort>();
		}

		public static ushort? ReadUShortNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<ushort>();
		}

		public static int ReadInt(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<int>();
		}

		public static int? ReadIntNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<int>();
		}

		public static uint ReadUInt(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<uint>();
		}

		public static uint? ReadUIntNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<uint>();
		}

		public static long ReadLong(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<long>();
		}

		public static long? ReadLongNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<long>();
		}

		public static ulong ReadULong(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<ulong>();
		}

		public static ulong? ReadULongNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<ulong>();
		}

		public static float ReadFloat(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<float>();
		}

		public static float? ReadFloatNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<float>();
		}

		public static double ReadDouble(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<double>();
		}

		public static double? ReadDoubleNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<double>();
		}

		public static decimal ReadDecimal(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<decimal>();
		}

		public static decimal? ReadDecimalNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<decimal>();
		}

		public static string ReadString(this global::Mirror.NetworkReader reader)
		{
			ushort num = reader.ReadUShort();
			if (num == 0)
			{
				return null;
			}
			ushort num2 = (ushort)(num - 1);
			if (num2 > 65534)
			{
				throw new global::System.IO.EndOfStreamException($"NetworkReader.ReadString - Value too long: {num2} bytes. Limit is: {(ushort)65534} bytes");
			}
			global::System.ArraySegment<byte> arraySegment = reader.ReadBytesSegment(num2);
			return reader.encoding.GetString(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
		}

		public static byte[] ReadBytes(this global::Mirror.NetworkReader reader, int count)
		{
			if (count > 16777216)
			{
				throw new global::System.IO.EndOfStreamException($"NetworkReader attempted to allocate {count} bytes, which is larger than the allowed limit of {16777216} bytes.");
			}
			byte[] array = new byte[count];
			reader.ReadBytes(array, count);
			return array;
		}

		public static byte[] ReadBytesAndSize(this global::Mirror.NetworkReader reader)
		{
			uint num = reader.ReadUInt();
			if (num != 0)
			{
				return ReadBytes(reader, checked((int)(num - 1)));
			}
			return null;
		}

		[global::System.Obsolete("ReadBytesAndSizeSegment was renamed to ReadArraySegmentAndSize for clarity.")]
		public static global::System.ArraySegment<byte> ReadBytesAndSizeSegment(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadArraySegmentAndSize();
		}

		public static global::System.ArraySegment<byte> ReadArraySegmentAndSize(this global::Mirror.NetworkReader reader)
		{
			uint num = reader.ReadUInt();
			if (num != 0)
			{
				return reader.ReadBytesSegment(checked((int)(num - 1)));
			}
			return default;
		}

		public static global::UnityEngine.Vector2 ReadVector2(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Vector2>();
		}

		public static global::UnityEngine.Vector2? ReadVector2Nullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Vector2>();
		}

		public static global::UnityEngine.Vector3 ReadVector3(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Vector3>();
		}

		public static global::UnityEngine.Vector3? ReadVector3Nullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Vector3>();
		}

		public static global::UnityEngine.Vector4 ReadVector4(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Vector4>();
		}

		public static global::UnityEngine.Vector4? ReadVector4Nullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Vector4>();
		}

		public static global::UnityEngine.Vector2Int ReadVector2Int(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Vector2Int>();
		}

		public static global::UnityEngine.Vector2Int? ReadVector2IntNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Vector2Int>();
		}

		public static global::UnityEngine.Vector3Int ReadVector3Int(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Vector3Int>();
		}

		public static global::UnityEngine.Vector3Int? ReadVector3IntNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Vector3Int>();
		}

		public static global::UnityEngine.Color ReadColor(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Color>();
		}

		public static global::UnityEngine.Color? ReadColorNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Color>();
		}

		public static global::UnityEngine.Color32 ReadColor32(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Color32>();
		}

		public static global::UnityEngine.Color32? ReadColor32Nullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Color32>();
		}

		public static global::UnityEngine.Quaternion ReadQuaternion(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Quaternion>();
		}

		public static global::UnityEngine.Quaternion? ReadQuaternionNullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Quaternion>();
		}

		public static global::UnityEngine.Rect ReadRect(this global::Mirror.NetworkReader reader)
		{
			return new global::UnityEngine.Rect(reader.ReadVector2(), reader.ReadVector2());
		}

		public static global::UnityEngine.Rect? ReadRectNullable(this global::Mirror.NetworkReader reader)
		{
			if (!reader.ReadBool())
			{
				return null;
			}
			return reader.ReadRect();
		}

		public static global::UnityEngine.Plane ReadPlane(this global::Mirror.NetworkReader reader)
		{
			return new global::UnityEngine.Plane(reader.ReadVector3(), reader.ReadFloat());
		}

		public static global::UnityEngine.Plane? ReadPlaneNullable(this global::Mirror.NetworkReader reader)
		{
			if (!reader.ReadBool())
			{
				return null;
			}
			return reader.ReadPlane();
		}

		public static global::UnityEngine.Ray ReadRay(this global::Mirror.NetworkReader reader)
		{
			return new global::UnityEngine.Ray(reader.ReadVector3(), reader.ReadVector3());
		}

		public static global::UnityEngine.Ray? ReadRayNullable(this global::Mirror.NetworkReader reader)
		{
			if (!reader.ReadBool())
			{
				return null;
			}
			return reader.ReadRay();
		}

		public static global::UnityEngine.Matrix4x4 ReadMatrix4x4(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittable<global::UnityEngine.Matrix4x4>();
		}

		public static global::UnityEngine.Matrix4x4? ReadMatrix4x4Nullable(this global::Mirror.NetworkReader reader)
		{
			return reader.ReadBlittableNullable<global::UnityEngine.Matrix4x4>();
		}

		public static global::System.Guid ReadGuid(this global::Mirror.NetworkReader reader)
		{
			if (reader.Remaining >= 16)
			{
				global::System.ReadOnlySpan<byte> b = new global::System.ReadOnlySpan<byte>(reader.buffer.Array, reader.buffer.Offset + reader.Position, 16);
				reader.Position += 16;
				return new global::System.Guid(b);
			}
			throw new global::System.IO.EndOfStreamException($"ReadGuid out of range: {reader}");
		}

		public static global::System.Guid? ReadGuidNullable(this global::Mirror.NetworkReader reader)
		{
			if (!reader.ReadBool())
			{
				return null;
			}
			return reader.ReadGuid();
		}

		public static global::Mirror.NetworkIdentity ReadNetworkIdentity(this global::Mirror.NetworkReader reader)
		{
			uint num = reader.ReadUInt();
			if (num == 0)
			{
				return null;
			}
			return global::Mirror.Utils.GetSpawnedInServerOrClient(num);
		}

		public static global::Mirror.NetworkBehaviour ReadNetworkBehaviour(this global::Mirror.NetworkReader reader)
		{
			uint num = reader.ReadUInt();
			if (num == 0)
			{
				return null;
			}
			byte b = reader.ReadByte();
			global::Mirror.NetworkIdentity spawnedInServerOrClient = global::Mirror.Utils.GetSpawnedInServerOrClient(num);
			if (!(spawnedInServerOrClient != null))
			{
				return null;
			}
			return spawnedInServerOrClient.NetworkBehaviours[b];
		}

		public static T ReadNetworkBehaviour<T>(this global::Mirror.NetworkReader reader) where T : global::Mirror.NetworkBehaviour
		{
			return reader.ReadNetworkBehaviour() as T;
		}

		public static global::Mirror.NetworkBehaviourSyncVar ReadNetworkBehaviourSyncVar(this global::Mirror.NetworkReader reader)
		{
			uint num = reader.ReadUInt();
			byte componentIndex = 0;
			if (num != 0)
			{
				componentIndex = reader.ReadByte();
			}
			return new global::Mirror.NetworkBehaviourSyncVar(num, componentIndex);
		}

		public static global::UnityEngine.Transform ReadTransform(this global::Mirror.NetworkReader reader)
		{
			global::Mirror.NetworkIdentity networkIdentity = reader.ReadNetworkIdentity();
			if (!(networkIdentity != null))
			{
				return null;
			}
			return networkIdentity.transform;
		}

		public static global::UnityEngine.GameObject ReadGameObject(this global::Mirror.NetworkReader reader)
		{
			global::Mirror.NetworkIdentity networkIdentity = reader.ReadNetworkIdentity();
			if (!(networkIdentity != null))
			{
				return null;
			}
			return networkIdentity.gameObject;
		}

		public static global::System.Collections.Generic.List<T> ReadList<T>(this global::Mirror.NetworkReader reader)
		{
			int num = reader.ReadInt();
			if (num < 0)
			{
				return null;
			}
			if (num > 16777216)
			{
				throw new global::System.IO.EndOfStreamException($"NetworkReader attempted to allocate a List<{typeof(T)}> {num} elements, which is larger than the allowed limit of {16777216}.");
			}
			global::System.Collections.Generic.List<T> list = new global::System.Collections.Generic.List<T>(num);
			for (int i = 0; i < num; i++)
			{
				list.Add(reader.Read<T>());
			}
			return list;
		}

		public static T[] ReadArray<T>(this global::Mirror.NetworkReader reader)
		{
			int num = reader.ReadInt();
			if (num < 0)
			{
				return null;
			}
			if (num > 16777216)
			{
				throw new global::System.IO.EndOfStreamException($"NetworkReader attempted to allocate an Array<{typeof(T)}> with {num} elements, which is larger than the allowed limit of {16777216}.");
			}
			T[] array = new T[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = reader.Read<T>();
			}
			return array;
		}

		public static global::System.Uri ReadUri(this global::Mirror.NetworkReader reader)
		{
			string text = reader.ReadString();
			if (!string.IsNullOrWhiteSpace(text))
			{
				return new global::System.Uri(text);
			}
			return null;
		}

		public static global::UnityEngine.Texture2D ReadTexture2D(this global::Mirror.NetworkReader reader)
		{
			short num = reader.ReadShort();
			if (num == -1)
			{
				return null;
			}
			short num2 = reader.ReadShort();
			int num3 = num * num2;
			if (num3 > 16777216)
			{
				global::UnityEngine.Debug.LogWarning($"NetworkReader attempted to allocate a Texture2D with total size (width * height) of {num3}, which is larger than the allowed limit of {16777216}.");
				return null;
			}
			global::UnityEngine.Texture2D texture2D = new global::UnityEngine.Texture2D(num, num2);
			global::UnityEngine.Color32[] pixels = reader.ReadArray<global::UnityEngine.Color32>();
			texture2D.SetPixels32(pixels);
			texture2D.Apply();
			return texture2D;
		}

		public static global::UnityEngine.Sprite ReadSprite(this global::Mirror.NetworkReader reader)
		{
			global::UnityEngine.Texture2D texture2D = reader.ReadTexture2D();
			if (texture2D == null)
			{
				return null;
			}
			return global::UnityEngine.Sprite.Create(texture2D, reader.ReadRect(), reader.ReadVector2());
		}

		public static global::System.DateTime ReadDateTime(this global::Mirror.NetworkReader reader)
		{
			return global::System.DateTime.FromOADate(reader.ReadDouble());
		}

		public static global::System.DateTime? ReadDateTimeNullable(this global::Mirror.NetworkReader reader)
		{
			if (!reader.ReadBool())
			{
				return null;
			}
			return reader.ReadDateTime();
		}
	}
}

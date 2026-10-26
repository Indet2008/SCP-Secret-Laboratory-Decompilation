namespace Mirror
{
	public static class NetworkWriterExtensions
	{
		public static void WriteByte(this global::Mirror.NetworkWriter writer, byte value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteByteNullable(this global::Mirror.NetworkWriter writer, byte? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteSByte(this global::Mirror.NetworkWriter writer, sbyte value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteSByteNullable(this global::Mirror.NetworkWriter writer, sbyte? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteChar(this global::Mirror.NetworkWriter writer, char value)
		{
			writer.WriteBlittable((ushort)value);
		}

		public static void WriteCharNullable(this global::Mirror.NetworkWriter writer, char? value)
		{
			writer.WriteBlittableNullable((ushort?)value);
		}

		public static void WriteBool(this global::Mirror.NetworkWriter writer, bool value)
		{
			writer.WriteBlittable((byte)(value ? 1u : 0u));
		}

		public static void WriteBoolNullable(this global::Mirror.NetworkWriter writer, bool? value)
		{
			writer.WriteBlittableNullable(value.HasValue ? new byte?((byte)(value.Value ? 1u : 0u)) : ((byte?)null));
		}

		public static void WriteShort(this global::Mirror.NetworkWriter writer, short value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteShortNullable(this global::Mirror.NetworkWriter writer, short? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteUShort(this global::Mirror.NetworkWriter writer, ushort value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteUShortNullable(this global::Mirror.NetworkWriter writer, ushort? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteInt(this global::Mirror.NetworkWriter writer, int value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteIntNullable(this global::Mirror.NetworkWriter writer, int? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteUInt(this global::Mirror.NetworkWriter writer, uint value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteUIntNullable(this global::Mirror.NetworkWriter writer, uint? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteLong(this global::Mirror.NetworkWriter writer, long value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteLongNullable(this global::Mirror.NetworkWriter writer, long? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteULong(this global::Mirror.NetworkWriter writer, ulong value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteULongNullable(this global::Mirror.NetworkWriter writer, ulong? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteFloat(this global::Mirror.NetworkWriter writer, float value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteFloatNullable(this global::Mirror.NetworkWriter writer, float? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteDouble(this global::Mirror.NetworkWriter writer, double value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteDoubleNullable(this global::Mirror.NetworkWriter writer, double? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteDecimal(this global::Mirror.NetworkWriter writer, decimal value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteDecimalNullable(this global::Mirror.NetworkWriter writer, decimal? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteString(this global::Mirror.NetworkWriter writer, string value)
		{
			if (value == null)
			{
				writer.WriteUShort(0);
				return;
			}
			int maxByteCount = writer.encoding.GetMaxByteCount(value.Length);
			writer.EnsureCapacity(writer.Position + 2 + maxByteCount);
			int bytes = writer.encoding.GetBytes(value, 0, value.Length, writer.buffer, writer.Position + 2);
			if (bytes > 65534)
			{
				throw new global::System.IndexOutOfRangeException($"NetworkWriter.WriteString - Value too long: {bytes} bytes. Limit: {(ushort)65534} bytes");
			}
			writer.WriteUShort(checked((ushort)(bytes + 1)));
			writer.Position += bytes;
		}

		public static void WriteBytesAndSize(this global::Mirror.NetworkWriter writer, byte[] buffer)
		{
			writer.WriteBytesAndSize(buffer, 0, (buffer != null) ? buffer.Length : 0);
		}

		public static void WriteBytesAndSize(this global::Mirror.NetworkWriter writer, byte[] buffer, int offset, int count)
		{
			if (buffer == null)
			{
				writer.WriteUInt(0u);
				return;
			}
			writer.WriteUInt(checked((uint)count) + 1);
			writer.WriteBytes(buffer, offset, count);
		}

		[global::System.Obsolete("WriteBytesAndSizeSegment was renamed to WriteArraySegmentAndSize for clarity.")]
		public static void WriteBytesAndSizeSegment(this global::Mirror.NetworkWriter writer, global::System.ArraySegment<byte> segment)
		{
			writer.WriteArraySegmentAndSize(segment);
		}

		public static void WriteArraySegmentAndSize(this global::Mirror.NetworkWriter writer, global::System.ArraySegment<byte> segment)
		{
			writer.WriteBytesAndSize(segment.Array, segment.Offset, segment.Count);
		}

		public static void WriteArraySegment<T>(this global::Mirror.NetworkWriter writer, global::System.ArraySegment<T> segment)
		{
			int count = segment.Count;
			writer.WriteInt(count);
			for (int i = 0; i < count; i++)
			{
				writer.Write(segment.Array[segment.Offset + i]);
			}
		}

		public static void WriteVector2(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector2 value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteVector2Nullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector2? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteVector3(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector3 value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteVector3Nullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector3? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteVector4(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector4 value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteVector4Nullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector4? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteVector2Int(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector2Int value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteVector2IntNullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector2Int? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteVector3Int(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector3Int value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteVector3IntNullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Vector3Int? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteColor(this global::Mirror.NetworkWriter writer, global::UnityEngine.Color value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteColorNullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Color? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteColor32(this global::Mirror.NetworkWriter writer, global::UnityEngine.Color32 value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteColor32Nullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Color32? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteQuaternion(this global::Mirror.NetworkWriter writer, global::UnityEngine.Quaternion value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteQuaternionNullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Quaternion? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteRect(this global::Mirror.NetworkWriter writer, global::UnityEngine.Rect value)
		{
			writer.WriteVector2(value.position);
			writer.WriteVector2(value.size);
		}

		public static void WriteRectNullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Rect? value)
		{
			writer.WriteBool(value.HasValue);
			if (value.HasValue)
			{
				writer.WriteRect(value.Value);
			}
		}

		public static void WritePlane(this global::Mirror.NetworkWriter writer, global::UnityEngine.Plane value)
		{
			writer.WriteVector3(value.normal);
			writer.WriteFloat(value.distance);
		}

		public static void WritePlaneNullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Plane? value)
		{
			writer.WriteBool(value.HasValue);
			if (value.HasValue)
			{
				writer.WritePlane(value.Value);
			}
		}

		public static void WriteRay(this global::Mirror.NetworkWriter writer, global::UnityEngine.Ray value)
		{
			writer.WriteVector3(value.origin);
			writer.WriteVector3(value.direction);
		}

		public static void WriteRayNullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Ray? value)
		{
			writer.WriteBool(value.HasValue);
			if (value.HasValue)
			{
				writer.WriteRay(value.Value);
			}
		}

		public static void WriteMatrix4x4(this global::Mirror.NetworkWriter writer, global::UnityEngine.Matrix4x4 value)
		{
			writer.WriteBlittable(value);
		}

		public static void WriteMatrix4x4Nullable(this global::Mirror.NetworkWriter writer, global::UnityEngine.Matrix4x4? value)
		{
			writer.WriteBlittableNullable(value);
		}

		public static void WriteGuid(this global::Mirror.NetworkWriter writer, global::System.Guid value)
		{
			writer.EnsureCapacity(writer.Position + 16);
			value.TryWriteBytes(new global::System.Span<byte>(writer.buffer, writer.Position, 16));
			writer.Position += 16;
		}

		public static void WriteGuidNullable(this global::Mirror.NetworkWriter writer, global::System.Guid? value)
		{
			writer.WriteBool(value.HasValue);
			if (value.HasValue)
			{
				writer.WriteGuid(value.Value);
			}
		}

		public static void WriteNetworkIdentity(this global::Mirror.NetworkWriter writer, global::Mirror.NetworkIdentity value)
		{
			if (value == null)
			{
				writer.WriteUInt(0u);
				return;
			}
			if (value.netId == 0)
			{
				global::UnityEngine.Debug.LogWarning("Attempted to serialize unspawned GameObject: " + value.name + ". Prefabs and unspawned GameObjects would always be null on the other side. Please spawn it before using it in [SyncVar]s/Rpcs/Cmds/NetworkMessages etc.");
			}
			writer.WriteUInt(value.netId);
		}

		public static void WriteNetworkBehaviour(this global::Mirror.NetworkWriter writer, global::Mirror.NetworkBehaviour value)
		{
			if (value == null)
			{
				writer.WriteUInt(0u);
			}
			else if (value.netId == 0)
			{
				global::UnityEngine.Debug.LogWarning($"Attempted to serialize unspawned NetworkBehaviour: of type {value.GetType()} on GameObject {value.name}. Prefabs and unspawned GameObjects would always be null on the other side. Please spawn it before using it in [SyncVar]s/Rpcs/Cmds/NetworkMessages etc.");
				writer.WriteUInt(0u);
			}
			else
			{
				writer.WriteUInt(value.netId);
				writer.WriteByte(value.ComponentIndex);
			}
		}

		public static void WriteTransform(this global::Mirror.NetworkWriter writer, global::UnityEngine.Transform value)
		{
			if (value == null)
			{
				writer.WriteUInt(0u);
				return;
			}
			if (value.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				writer.WriteUInt(component.netId);
				return;
			}
			global::UnityEngine.Debug.LogWarning($"Attempted to sync a Transform ({value}) which isn't networked. Transforms without a NetworkIdentity component can't be synced.");
			writer.WriteUInt(0u);
		}

		public static void WriteGameObject(this global::Mirror.NetworkWriter writer, global::UnityEngine.GameObject value)
		{
			if (value == null)
			{
				writer.WriteUInt(0u);
				return;
			}
			if (!value.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogWarning($"Attempted to sync a GameObject ({value}) which isn't networked. GameObject without a NetworkIdentity component can't be synced.");
			}
			writer.WriteNetworkIdentity(component);
		}

		public static void WriteList<T>(this global::Mirror.NetworkWriter writer, global::System.Collections.Generic.List<T> list)
		{
			if (list == null)
			{
				writer.WriteInt(-1);
				return;
			}
			if (list.Count > 16777216)
			{
				throw new global::System.IndexOutOfRangeException($"NetworkWriter.WriteList - List<{typeof(T)}> too big: {list.Count} elements. Limit: {16777216}");
			}
			writer.WriteInt(list.Count);
			for (int i = 0; i < list.Count; i++)
			{
				writer.Write(list[i]);
			}
		}

		public static void WriteArray<T>(this global::Mirror.NetworkWriter writer, T[] array)
		{
			if (array == null)
			{
				writer.WriteInt(-1);
				return;
			}
			if (array.Length > 16777216)
			{
				throw new global::System.IndexOutOfRangeException($"NetworkWriter.WriteArray - Array<{typeof(T)}> too big: {array.Length} elements. Limit: {16777216}");
			}
			writer.WriteInt(array.Length);
			for (int i = 0; i < array.Length; i++)
			{
				writer.Write(array[i]);
			}
		}

		public static void WriteUri(this global::Mirror.NetworkWriter writer, global::System.Uri uri)
		{
			writer.WriteString(uri?.ToString());
		}

		public static void WriteTexture2D(this global::Mirror.NetworkWriter writer, global::UnityEngine.Texture2D texture2D)
		{
			if (texture2D == null)
			{
				writer.WriteShort(-1);
				return;
			}
			int num = texture2D.width * texture2D.height;
			if (num > 16777216)
			{
				throw new global::System.IndexOutOfRangeException($"NetworkWriter.WriteTexture2D - Texture2D total size (width*height) too big: {num}. Limit: {16777216}");
			}
			writer.WriteShort((short)texture2D.width);
			writer.WriteShort((short)texture2D.height);
			writer.WriteArray(texture2D.GetPixels32());
		}

		public static void WriteSprite(this global::Mirror.NetworkWriter writer, global::UnityEngine.Sprite sprite)
		{
			if (sprite == null)
			{
				writer.WriteTexture2D(null);
				return;
			}
			writer.WriteTexture2D(sprite.texture);
			writer.WriteRect(sprite.rect);
			writer.WriteVector2(sprite.pivot);
		}

		public static void WriteDateTime(this global::Mirror.NetworkWriter writer, global::System.DateTime dateTime)
		{
			writer.WriteDouble(dateTime.ToOADate());
		}

		public static void WriteDateTimeNullable(this global::Mirror.NetworkWriter writer, global::System.DateTime? dateTime)
		{
			writer.WriteBool(dateTime.HasValue);
			if (dateTime.HasValue)
			{
				writer.WriteDouble(dateTime.Value.ToOADate());
			}
		}
	}
}

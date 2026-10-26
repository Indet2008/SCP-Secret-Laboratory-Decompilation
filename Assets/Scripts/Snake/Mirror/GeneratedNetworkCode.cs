namespace Mirror
{
	[global::System.Runtime.InteropServices.StructLayout(global::System.Runtime.InteropServices.LayoutKind.Auto, CharSet = global::System.Runtime.InteropServices.CharSet.Auto)]
	public static class GeneratedNetworkCode
	{
		public static global::Mirror.TimeSnapshotMessage _Read_Mirror_002ETimeSnapshotMessage(global::Mirror.NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002ETimeSnapshotMessage(global::Mirror.NetworkWriter writer, global::Mirror.TimeSnapshotMessage value)
		{
		}

		public static global::Mirror.ReadyMessage _Read_Mirror_002EReadyMessage(global::Mirror.NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EReadyMessage(global::Mirror.NetworkWriter writer, global::Mirror.ReadyMessage value)
		{
		}

		public static global::Mirror.NotReadyMessage _Read_Mirror_002ENotReadyMessage(global::Mirror.NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002ENotReadyMessage(global::Mirror.NetworkWriter writer, global::Mirror.NotReadyMessage value)
		{
		}

		public static global::Mirror.AddPlayerMessage _Read_Mirror_002EAddPlayerMessage(global::Mirror.NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EAddPlayerMessage(global::Mirror.NetworkWriter writer, global::Mirror.AddPlayerMessage value)
		{
		}

		public static global::Mirror.SceneMessage _Read_Mirror_002ESceneMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.SceneMessage
			{
				sceneName = reader.ReadString(),
				sceneOperation = _Read_Mirror_002ESceneOperation(reader),
				customHandling = reader.ReadBool()
			};
		}

		public static global::Mirror.SceneOperation _Read_Mirror_002ESceneOperation(global::Mirror.NetworkReader reader)
		{
			return (global::Mirror.SceneOperation)global::Mirror.NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_Mirror_002ESceneMessage(global::Mirror.NetworkWriter writer, global::Mirror.SceneMessage value)
		{
			writer.WriteString(value.sceneName);
			_Write_Mirror_002ESceneOperation(writer, value.sceneOperation);
			writer.WriteBool(value.customHandling);
		}

		public static void _Write_Mirror_002ESceneOperation(global::Mirror.NetworkWriter writer, global::Mirror.SceneOperation value)
		{
			global::Mirror.NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static global::Mirror.CommandMessage _Read_Mirror_002ECommandMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.CommandMessage
			{
				netId = reader.ReadUInt(),
				componentIndex = global::Mirror.NetworkReaderExtensions.ReadByte(reader),
				functionHash = reader.ReadUShort(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002ECommandMessage(global::Mirror.NetworkWriter writer, global::Mirror.CommandMessage value)
		{
			writer.WriteUInt(value.netId);
			global::Mirror.NetworkWriterExtensions.WriteByte(writer, value.componentIndex);
			writer.WriteUShort(value.functionHash);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static global::Mirror.RpcMessage _Read_Mirror_002ERpcMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.RpcMessage
			{
				netId = reader.ReadUInt(),
				componentIndex = global::Mirror.NetworkReaderExtensions.ReadByte(reader),
				functionHash = reader.ReadUShort(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002ERpcMessage(global::Mirror.NetworkWriter writer, global::Mirror.RpcMessage value)
		{
			writer.WriteUInt(value.netId);
			global::Mirror.NetworkWriterExtensions.WriteByte(writer, value.componentIndex);
			writer.WriteUShort(value.functionHash);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static global::Mirror.SpawnMessage _Read_Mirror_002ESpawnMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.SpawnMessage
			{
				netId = reader.ReadUInt(),
				isLocalPlayer = reader.ReadBool(),
				isOwner = reader.ReadBool(),
				sceneId = reader.ReadULong(),
				assetId = reader.ReadUInt(),
				position = reader.ReadVector3(),
				rotation = reader.ReadQuaternion(),
				scale = reader.ReadVector3(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002ESpawnMessage(global::Mirror.NetworkWriter writer, global::Mirror.SpawnMessage value)
		{
			writer.WriteUInt(value.netId);
			writer.WriteBool(value.isLocalPlayer);
			writer.WriteBool(value.isOwner);
			writer.WriteULong(value.sceneId);
			writer.WriteUInt(value.assetId);
			writer.WriteVector3(value.position);
			writer.WriteQuaternion(value.rotation);
			writer.WriteVector3(value.scale);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static global::Mirror.ChangeOwnerMessage _Read_Mirror_002EChangeOwnerMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.ChangeOwnerMessage
			{
				netId = reader.ReadUInt(),
				isOwner = reader.ReadBool(),
				isLocalPlayer = reader.ReadBool()
			};
		}

		public static void _Write_Mirror_002EChangeOwnerMessage(global::Mirror.NetworkWriter writer, global::Mirror.ChangeOwnerMessage value)
		{
			writer.WriteUInt(value.netId);
			writer.WriteBool(value.isOwner);
			writer.WriteBool(value.isLocalPlayer);
		}

		public static global::Mirror.ObjectSpawnStartedMessage _Read_Mirror_002EObjectSpawnStartedMessage(global::Mirror.NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EObjectSpawnStartedMessage(global::Mirror.NetworkWriter writer, global::Mirror.ObjectSpawnStartedMessage value)
		{
		}

		public static global::Mirror.ObjectSpawnFinishedMessage _Read_Mirror_002EObjectSpawnFinishedMessage(global::Mirror.NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EObjectSpawnFinishedMessage(global::Mirror.NetworkWriter writer, global::Mirror.ObjectSpawnFinishedMessage value)
		{
		}

		public static global::Mirror.ObjectDestroyMessage _Read_Mirror_002EObjectDestroyMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.ObjectDestroyMessage
			{
				netId = reader.ReadUInt()
			};
		}

		public static void _Write_Mirror_002EObjectDestroyMessage(global::Mirror.NetworkWriter writer, global::Mirror.ObjectDestroyMessage value)
		{
			writer.WriteUInt(value.netId);
		}

		public static global::Mirror.ObjectHideMessage _Read_Mirror_002EObjectHideMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.ObjectHideMessage
			{
				netId = reader.ReadUInt()
			};
		}

		public static void _Write_Mirror_002EObjectHideMessage(global::Mirror.NetworkWriter writer, global::Mirror.ObjectHideMessage value)
		{
			writer.WriteUInt(value.netId);
		}

		public static global::Mirror.EntityStateMessage _Read_Mirror_002EEntityStateMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.EntityStateMessage
			{
				netId = reader.ReadUInt(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002EEntityStateMessage(global::Mirror.NetworkWriter writer, global::Mirror.EntityStateMessage value)
		{
			writer.WriteUInt(value.netId);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static global::Mirror.NetworkPingMessage _Read_Mirror_002ENetworkPingMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.NetworkPingMessage
			{
				localTime = reader.ReadDouble()
			};
		}

		public static void _Write_Mirror_002ENetworkPingMessage(global::Mirror.NetworkWriter writer, global::Mirror.NetworkPingMessage value)
		{
			writer.WriteDouble(value.localTime);
		}

		public static global::Mirror.NetworkPongMessage _Read_Mirror_002ENetworkPongMessage(global::Mirror.NetworkReader reader)
		{
			return new global::Mirror.NetworkPongMessage
			{
				localTime = reader.ReadDouble()
			};
		}

		public static void _Write_Mirror_002ENetworkPongMessage(global::Mirror.NetworkWriter writer, global::Mirror.NetworkPongMessage value)
		{
			writer.WriteDouble(value.localTime);
		}

		public static global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage _Read_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage(global::Mirror.NetworkReader reader)
		{
			return new global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage
			{
				Flags = _Read_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage_002FSyncFlags(reader),
				NextFoodPosition = reader.ReadVector2IntNullable(),
				MoveOffset = reader.ReadVector2Int(),
				Segments = _Read_System_002ECollections_002EGeneric_002EList_00601_003CUnityEngine_002EVector2Int_003E(reader)
			};
		}

		public static global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags _Read_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage_002FSyncFlags(global::Mirror.NetworkReader reader)
		{
			return (global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags)global::Mirror.NetworkReaderExtensions.ReadByte(reader);
		}

		public static global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> _Read_System_002ECollections_002EGeneric_002EList_00601_003CUnityEngine_002EVector2Int_003E(global::Mirror.NetworkReader reader)
		{
			return reader.ReadList<global::UnityEngine.Vector2Int>();
		}

		public static void _Write_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage(global::Mirror.NetworkWriter writer, global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage value)
		{
			_Write_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage_002FSyncFlags(writer, value.Flags);
			writer.WriteVector2IntNullable(value.NextFoodPosition);
			writer.WriteVector2Int(value.MoveOffset);
			_Write_System_002ECollections_002EGeneric_002EList_00601_003CUnityEngine_002EVector2Int_003E(writer, value.Segments);
		}

		public static void _Write_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage_002FSyncFlags(global::Mirror.NetworkWriter writer, global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags value)
		{
			global::Mirror.NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static void _Write_System_002ECollections_002EGeneric_002EList_00601_003CUnityEngine_002EVector2Int_003E(global::Mirror.NetworkWriter writer, global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> value)
		{
			writer.WriteList(value);
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		public static void InitReadWriters()
		{
			global::Mirror.Writer<byte>.write = global::Mirror.NetworkWriterExtensions.WriteByte;
			global::Mirror.Writer<byte?>.write = global::Mirror.NetworkWriterExtensions.WriteByteNullable;
			global::Mirror.Writer<sbyte>.write = global::Mirror.NetworkWriterExtensions.WriteSByte;
			global::Mirror.Writer<sbyte?>.write = global::Mirror.NetworkWriterExtensions.WriteSByteNullable;
			global::Mirror.Writer<char>.write = global::Mirror.NetworkWriterExtensions.WriteChar;
			global::Mirror.Writer<char?>.write = global::Mirror.NetworkWriterExtensions.WriteCharNullable;
			global::Mirror.Writer<bool>.write = global::Mirror.NetworkWriterExtensions.WriteBool;
			global::Mirror.Writer<bool?>.write = global::Mirror.NetworkWriterExtensions.WriteBoolNullable;
			global::Mirror.Writer<short>.write = global::Mirror.NetworkWriterExtensions.WriteShort;
			global::Mirror.Writer<short?>.write = global::Mirror.NetworkWriterExtensions.WriteShortNullable;
			global::Mirror.Writer<ushort>.write = global::Mirror.NetworkWriterExtensions.WriteUShort;
			global::Mirror.Writer<ushort?>.write = global::Mirror.NetworkWriterExtensions.WriteUShortNullable;
			global::Mirror.Writer<int>.write = global::Mirror.NetworkWriterExtensions.WriteInt;
			global::Mirror.Writer<int?>.write = global::Mirror.NetworkWriterExtensions.WriteIntNullable;
			global::Mirror.Writer<uint>.write = global::Mirror.NetworkWriterExtensions.WriteUInt;
			global::Mirror.Writer<uint?>.write = global::Mirror.NetworkWriterExtensions.WriteUIntNullable;
			global::Mirror.Writer<long>.write = global::Mirror.NetworkWriterExtensions.WriteLong;
			global::Mirror.Writer<long?>.write = global::Mirror.NetworkWriterExtensions.WriteLongNullable;
			global::Mirror.Writer<ulong>.write = global::Mirror.NetworkWriterExtensions.WriteULong;
			global::Mirror.Writer<ulong?>.write = global::Mirror.NetworkWriterExtensions.WriteULongNullable;
			global::Mirror.Writer<float>.write = global::Mirror.NetworkWriterExtensions.WriteFloat;
			global::Mirror.Writer<float?>.write = global::Mirror.NetworkWriterExtensions.WriteFloatNullable;
			global::Mirror.Writer<double>.write = global::Mirror.NetworkWriterExtensions.WriteDouble;
			global::Mirror.Writer<double?>.write = global::Mirror.NetworkWriterExtensions.WriteDoubleNullable;
			global::Mirror.Writer<decimal>.write = global::Mirror.NetworkWriterExtensions.WriteDecimal;
			global::Mirror.Writer<decimal?>.write = global::Mirror.NetworkWriterExtensions.WriteDecimalNullable;
			global::Mirror.Writer<string>.write = global::Mirror.NetworkWriterExtensions.WriteString;
			global::Mirror.Writer<byte[]>.write = global::Mirror.NetworkWriterExtensions.WriteBytesAndSize;
			global::Mirror.Writer<global::System.ArraySegment<byte>>.write = global::Mirror.NetworkWriterExtensions.WriteArraySegmentAndSize;
			global::Mirror.Writer<global::UnityEngine.Vector2>.write = global::Mirror.NetworkWriterExtensions.WriteVector2;
			global::Mirror.Writer<global::UnityEngine.Vector2?>.write = global::Mirror.NetworkWriterExtensions.WriteVector2Nullable;
			global::Mirror.Writer<global::UnityEngine.Vector3>.write = global::Mirror.NetworkWriterExtensions.WriteVector3;
			global::Mirror.Writer<global::UnityEngine.Vector3?>.write = global::Mirror.NetworkWriterExtensions.WriteVector3Nullable;
			global::Mirror.Writer<global::UnityEngine.Vector4>.write = global::Mirror.NetworkWriterExtensions.WriteVector4;
			global::Mirror.Writer<global::UnityEngine.Vector4?>.write = global::Mirror.NetworkWriterExtensions.WriteVector4Nullable;
			global::Mirror.Writer<global::UnityEngine.Vector2Int>.write = global::Mirror.NetworkWriterExtensions.WriteVector2Int;
			global::Mirror.Writer<global::UnityEngine.Vector2Int?>.write = global::Mirror.NetworkWriterExtensions.WriteVector2IntNullable;
			global::Mirror.Writer<global::UnityEngine.Vector3Int>.write = global::Mirror.NetworkWriterExtensions.WriteVector3Int;
			global::Mirror.Writer<global::UnityEngine.Vector3Int?>.write = global::Mirror.NetworkWriterExtensions.WriteVector3IntNullable;
			global::Mirror.Writer<global::UnityEngine.Color>.write = global::Mirror.NetworkWriterExtensions.WriteColor;
			global::Mirror.Writer<global::UnityEngine.Color?>.write = global::Mirror.NetworkWriterExtensions.WriteColorNullable;
			global::Mirror.Writer<global::UnityEngine.Color32>.write = global::Mirror.NetworkWriterExtensions.WriteColor32;
			global::Mirror.Writer<global::UnityEngine.Color32?>.write = global::Mirror.NetworkWriterExtensions.WriteColor32Nullable;
			global::Mirror.Writer<global::UnityEngine.Quaternion>.write = global::Mirror.NetworkWriterExtensions.WriteQuaternion;
			global::Mirror.Writer<global::UnityEngine.Quaternion?>.write = global::Mirror.NetworkWriterExtensions.WriteQuaternionNullable;
			global::Mirror.Writer<global::UnityEngine.Rect>.write = global::Mirror.NetworkWriterExtensions.WriteRect;
			global::Mirror.Writer<global::UnityEngine.Rect?>.write = global::Mirror.NetworkWriterExtensions.WriteRectNullable;
			global::Mirror.Writer<global::UnityEngine.Plane>.write = global::Mirror.NetworkWriterExtensions.WritePlane;
			global::Mirror.Writer<global::UnityEngine.Plane?>.write = global::Mirror.NetworkWriterExtensions.WritePlaneNullable;
			global::Mirror.Writer<global::UnityEngine.Ray>.write = global::Mirror.NetworkWriterExtensions.WriteRay;
			global::Mirror.Writer<global::UnityEngine.Ray?>.write = global::Mirror.NetworkWriterExtensions.WriteRayNullable;
			global::Mirror.Writer<global::UnityEngine.Matrix4x4>.write = global::Mirror.NetworkWriterExtensions.WriteMatrix4x4;
			global::Mirror.Writer<global::UnityEngine.Matrix4x4?>.write = global::Mirror.NetworkWriterExtensions.WriteMatrix4x4Nullable;
			global::Mirror.Writer<global::System.Guid>.write = global::Mirror.NetworkWriterExtensions.WriteGuid;
			global::Mirror.Writer<global::System.Guid?>.write = global::Mirror.NetworkWriterExtensions.WriteGuidNullable;
			global::Mirror.Writer<global::Mirror.NetworkIdentity>.write = global::Mirror.NetworkWriterExtensions.WriteNetworkIdentity;
			global::Mirror.Writer<global::Mirror.NetworkBehaviour>.write = global::Mirror.NetworkWriterExtensions.WriteNetworkBehaviour;
			global::Mirror.Writer<global::UnityEngine.Transform>.write = global::Mirror.NetworkWriterExtensions.WriteTransform;
			global::Mirror.Writer<global::UnityEngine.GameObject>.write = global::Mirror.NetworkWriterExtensions.WriteGameObject;
			global::Mirror.Writer<global::System.Uri>.write = global::Mirror.NetworkWriterExtensions.WriteUri;
			global::Mirror.Writer<global::UnityEngine.Texture2D>.write = global::Mirror.NetworkWriterExtensions.WriteTexture2D;
			global::Mirror.Writer<global::UnityEngine.Sprite>.write = global::Mirror.NetworkWriterExtensions.WriteSprite;
			global::Mirror.Writer<global::System.DateTime>.write = global::Mirror.NetworkWriterExtensions.WriteDateTime;
			global::Mirror.Writer<global::System.DateTime?>.write = global::Mirror.NetworkWriterExtensions.WriteDateTimeNullable;
			global::Mirror.Writer<global::Mirror.TimeSnapshotMessage>.write = _Write_Mirror_002ETimeSnapshotMessage;
			global::Mirror.Writer<global::Mirror.ReadyMessage>.write = _Write_Mirror_002EReadyMessage;
			global::Mirror.Writer<global::Mirror.NotReadyMessage>.write = _Write_Mirror_002ENotReadyMessage;
			global::Mirror.Writer<global::Mirror.AddPlayerMessage>.write = _Write_Mirror_002EAddPlayerMessage;
			global::Mirror.Writer<global::Mirror.SceneMessage>.write = _Write_Mirror_002ESceneMessage;
			global::Mirror.Writer<global::Mirror.SceneOperation>.write = _Write_Mirror_002ESceneOperation;
			global::Mirror.Writer<global::Mirror.CommandMessage>.write = _Write_Mirror_002ECommandMessage;
			global::Mirror.Writer<global::Mirror.RpcMessage>.write = _Write_Mirror_002ERpcMessage;
			global::Mirror.Writer<global::Mirror.SpawnMessage>.write = _Write_Mirror_002ESpawnMessage;
			global::Mirror.Writer<global::Mirror.ChangeOwnerMessage>.write = _Write_Mirror_002EChangeOwnerMessage;
			global::Mirror.Writer<global::Mirror.ObjectSpawnStartedMessage>.write = _Write_Mirror_002EObjectSpawnStartedMessage;
			global::Mirror.Writer<global::Mirror.ObjectSpawnFinishedMessage>.write = _Write_Mirror_002EObjectSpawnFinishedMessage;
			global::Mirror.Writer<global::Mirror.ObjectDestroyMessage>.write = _Write_Mirror_002EObjectDestroyMessage;
			global::Mirror.Writer<global::Mirror.ObjectHideMessage>.write = _Write_Mirror_002EObjectHideMessage;
			global::Mirror.Writer<global::Mirror.EntityStateMessage>.write = _Write_Mirror_002EEntityStateMessage;
			global::Mirror.Writer<global::Mirror.NetworkPingMessage>.write = _Write_Mirror_002ENetworkPingMessage;
			global::Mirror.Writer<global::Mirror.NetworkPongMessage>.write = _Write_Mirror_002ENetworkPongMessage;
			global::Mirror.Writer<global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage>.write = _Write_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage;
			global::Mirror.Writer<global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags>.write = _Write_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage_002FSyncFlags;
			global::Mirror.Writer<global::System.Collections.Generic.List<global::UnityEngine.Vector2Int>>.write = _Write_System_002ECollections_002EGeneric_002EList_00601_003CUnityEngine_002EVector2Int_003E;
			global::Mirror.Reader<byte>.read = global::Mirror.NetworkReaderExtensions.ReadByte;
			global::Mirror.Reader<byte?>.read = global::Mirror.NetworkReaderExtensions.ReadByteNullable;
			global::Mirror.Reader<sbyte>.read = global::Mirror.NetworkReaderExtensions.ReadSByte;
			global::Mirror.Reader<sbyte?>.read = global::Mirror.NetworkReaderExtensions.ReadSByteNullable;
			global::Mirror.Reader<char>.read = global::Mirror.NetworkReaderExtensions.ReadChar;
			global::Mirror.Reader<char?>.read = global::Mirror.NetworkReaderExtensions.ReadCharNullable;
			global::Mirror.Reader<bool>.read = global::Mirror.NetworkReaderExtensions.ReadBool;
			global::Mirror.Reader<bool?>.read = global::Mirror.NetworkReaderExtensions.ReadBoolNullable;
			global::Mirror.Reader<short>.read = global::Mirror.NetworkReaderExtensions.ReadShort;
			global::Mirror.Reader<short?>.read = global::Mirror.NetworkReaderExtensions.ReadShortNullable;
			global::Mirror.Reader<ushort>.read = global::Mirror.NetworkReaderExtensions.ReadUShort;
			global::Mirror.Reader<ushort?>.read = global::Mirror.NetworkReaderExtensions.ReadUShortNullable;
			global::Mirror.Reader<int>.read = global::Mirror.NetworkReaderExtensions.ReadInt;
			global::Mirror.Reader<int?>.read = global::Mirror.NetworkReaderExtensions.ReadIntNullable;
			global::Mirror.Reader<uint>.read = global::Mirror.NetworkReaderExtensions.ReadUInt;
			global::Mirror.Reader<uint?>.read = global::Mirror.NetworkReaderExtensions.ReadUIntNullable;
			global::Mirror.Reader<long>.read = global::Mirror.NetworkReaderExtensions.ReadLong;
			global::Mirror.Reader<long?>.read = global::Mirror.NetworkReaderExtensions.ReadLongNullable;
			global::Mirror.Reader<ulong>.read = global::Mirror.NetworkReaderExtensions.ReadULong;
			global::Mirror.Reader<ulong?>.read = global::Mirror.NetworkReaderExtensions.ReadULongNullable;
			global::Mirror.Reader<float>.read = global::Mirror.NetworkReaderExtensions.ReadFloat;
			global::Mirror.Reader<float?>.read = global::Mirror.NetworkReaderExtensions.ReadFloatNullable;
			global::Mirror.Reader<double>.read = global::Mirror.NetworkReaderExtensions.ReadDouble;
			global::Mirror.Reader<double?>.read = global::Mirror.NetworkReaderExtensions.ReadDoubleNullable;
			global::Mirror.Reader<decimal>.read = global::Mirror.NetworkReaderExtensions.ReadDecimal;
			global::Mirror.Reader<decimal?>.read = global::Mirror.NetworkReaderExtensions.ReadDecimalNullable;
			global::Mirror.Reader<string>.read = global::Mirror.NetworkReaderExtensions.ReadString;
			global::Mirror.Reader<byte[]>.read = global::Mirror.NetworkReaderExtensions.ReadBytesAndSize;
			global::Mirror.Reader<global::System.ArraySegment<byte>>.read = global::Mirror.NetworkReaderExtensions.ReadArraySegmentAndSize;
			global::Mirror.Reader<global::UnityEngine.Vector2>.read = global::Mirror.NetworkReaderExtensions.ReadVector2;
			global::Mirror.Reader<global::UnityEngine.Vector2?>.read = global::Mirror.NetworkReaderExtensions.ReadVector2Nullable;
			global::Mirror.Reader<global::UnityEngine.Vector3>.read = global::Mirror.NetworkReaderExtensions.ReadVector3;
			global::Mirror.Reader<global::UnityEngine.Vector3?>.read = global::Mirror.NetworkReaderExtensions.ReadVector3Nullable;
			global::Mirror.Reader<global::UnityEngine.Vector4>.read = global::Mirror.NetworkReaderExtensions.ReadVector4;
			global::Mirror.Reader<global::UnityEngine.Vector4?>.read = global::Mirror.NetworkReaderExtensions.ReadVector4Nullable;
			global::Mirror.Reader<global::UnityEngine.Vector2Int>.read = global::Mirror.NetworkReaderExtensions.ReadVector2Int;
			global::Mirror.Reader<global::UnityEngine.Vector2Int?>.read = global::Mirror.NetworkReaderExtensions.ReadVector2IntNullable;
			global::Mirror.Reader<global::UnityEngine.Vector3Int>.read = global::Mirror.NetworkReaderExtensions.ReadVector3Int;
			global::Mirror.Reader<global::UnityEngine.Vector3Int?>.read = global::Mirror.NetworkReaderExtensions.ReadVector3IntNullable;
			global::Mirror.Reader<global::UnityEngine.Color>.read = global::Mirror.NetworkReaderExtensions.ReadColor;
			global::Mirror.Reader<global::UnityEngine.Color?>.read = global::Mirror.NetworkReaderExtensions.ReadColorNullable;
			global::Mirror.Reader<global::UnityEngine.Color32>.read = global::Mirror.NetworkReaderExtensions.ReadColor32;
			global::Mirror.Reader<global::UnityEngine.Color32?>.read = global::Mirror.NetworkReaderExtensions.ReadColor32Nullable;
			global::Mirror.Reader<global::UnityEngine.Quaternion>.read = global::Mirror.NetworkReaderExtensions.ReadQuaternion;
			global::Mirror.Reader<global::UnityEngine.Quaternion?>.read = global::Mirror.NetworkReaderExtensions.ReadQuaternionNullable;
			global::Mirror.Reader<global::UnityEngine.Rect>.read = global::Mirror.NetworkReaderExtensions.ReadRect;
			global::Mirror.Reader<global::UnityEngine.Rect?>.read = global::Mirror.NetworkReaderExtensions.ReadRectNullable;
			global::Mirror.Reader<global::UnityEngine.Plane>.read = global::Mirror.NetworkReaderExtensions.ReadPlane;
			global::Mirror.Reader<global::UnityEngine.Plane?>.read = global::Mirror.NetworkReaderExtensions.ReadPlaneNullable;
			global::Mirror.Reader<global::UnityEngine.Ray>.read = global::Mirror.NetworkReaderExtensions.ReadRay;
			global::Mirror.Reader<global::UnityEngine.Ray?>.read = global::Mirror.NetworkReaderExtensions.ReadRayNullable;
			global::Mirror.Reader<global::UnityEngine.Matrix4x4>.read = global::Mirror.NetworkReaderExtensions.ReadMatrix4x4;
			global::Mirror.Reader<global::UnityEngine.Matrix4x4?>.read = global::Mirror.NetworkReaderExtensions.ReadMatrix4x4Nullable;
			global::Mirror.Reader<global::System.Guid>.read = global::Mirror.NetworkReaderExtensions.ReadGuid;
			global::Mirror.Reader<global::System.Guid?>.read = global::Mirror.NetworkReaderExtensions.ReadGuidNullable;
			global::Mirror.Reader<global::Mirror.NetworkIdentity>.read = global::Mirror.NetworkReaderExtensions.ReadNetworkIdentity;
			global::Mirror.Reader<global::Mirror.NetworkBehaviour>.read = global::Mirror.NetworkReaderExtensions.ReadNetworkBehaviour;
			global::Mirror.Reader<global::Mirror.NetworkBehaviourSyncVar>.read = global::Mirror.NetworkReaderExtensions.ReadNetworkBehaviourSyncVar;
			global::Mirror.Reader<global::UnityEngine.Transform>.read = global::Mirror.NetworkReaderExtensions.ReadTransform;
			global::Mirror.Reader<global::UnityEngine.GameObject>.read = global::Mirror.NetworkReaderExtensions.ReadGameObject;
			global::Mirror.Reader<global::System.Uri>.read = global::Mirror.NetworkReaderExtensions.ReadUri;
			global::Mirror.Reader<global::UnityEngine.Texture2D>.read = global::Mirror.NetworkReaderExtensions.ReadTexture2D;
			global::Mirror.Reader<global::UnityEngine.Sprite>.read = global::Mirror.NetworkReaderExtensions.ReadSprite;
			global::Mirror.Reader<global::System.DateTime>.read = global::Mirror.NetworkReaderExtensions.ReadDateTime;
			global::Mirror.Reader<global::System.DateTime?>.read = global::Mirror.NetworkReaderExtensions.ReadDateTimeNullable;
			global::Mirror.Reader<global::Mirror.TimeSnapshotMessage>.read = _Read_Mirror_002ETimeSnapshotMessage;
			global::Mirror.Reader<global::Mirror.ReadyMessage>.read = _Read_Mirror_002EReadyMessage;
			global::Mirror.Reader<global::Mirror.NotReadyMessage>.read = _Read_Mirror_002ENotReadyMessage;
			global::Mirror.Reader<global::Mirror.AddPlayerMessage>.read = _Read_Mirror_002EAddPlayerMessage;
			global::Mirror.Reader<global::Mirror.SceneMessage>.read = _Read_Mirror_002ESceneMessage;
			global::Mirror.Reader<global::Mirror.SceneOperation>.read = _Read_Mirror_002ESceneOperation;
			global::Mirror.Reader<global::Mirror.CommandMessage>.read = _Read_Mirror_002ECommandMessage;
			global::Mirror.Reader<global::Mirror.RpcMessage>.read = _Read_Mirror_002ERpcMessage;
			global::Mirror.Reader<global::Mirror.SpawnMessage>.read = _Read_Mirror_002ESpawnMessage;
			global::Mirror.Reader<global::Mirror.ChangeOwnerMessage>.read = _Read_Mirror_002EChangeOwnerMessage;
			global::Mirror.Reader<global::Mirror.ObjectSpawnStartedMessage>.read = _Read_Mirror_002EObjectSpawnStartedMessage;
			global::Mirror.Reader<global::Mirror.ObjectSpawnFinishedMessage>.read = _Read_Mirror_002EObjectSpawnFinishedMessage;
			global::Mirror.Reader<global::Mirror.ObjectDestroyMessage>.read = _Read_Mirror_002EObjectDestroyMessage;
			global::Mirror.Reader<global::Mirror.ObjectHideMessage>.read = _Read_Mirror_002EObjectHideMessage;
			global::Mirror.Reader<global::Mirror.EntityStateMessage>.read = _Read_Mirror_002EEntityStateMessage;
			global::Mirror.Reader<global::Mirror.NetworkPingMessage>.read = _Read_Mirror_002ENetworkPingMessage;
			global::Mirror.Reader<global::Mirror.NetworkPongMessage>.read = _Read_Mirror_002ENetworkPongMessage;
			global::Mirror.Reader<global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage>.read = _Read_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage;
			global::Mirror.Reader<global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags>.read = _Read_InventorySystem_002EItems_002EKeycards_002ESnake_002ESnakeNetworkMessage_002FSyncFlags;
			global::Mirror.Reader<global::System.Collections.Generic.List<global::UnityEngine.Vector2Int>>.read = _Read_System_002ECollections_002EGeneric_002EList_00601_003CUnityEngine_002EVector2Int_003E;
		}
	}
}

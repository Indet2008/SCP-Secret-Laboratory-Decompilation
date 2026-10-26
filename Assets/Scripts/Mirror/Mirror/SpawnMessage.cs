namespace Mirror
{
	public struct SpawnMessage : global::Mirror.NetworkMessage
	{
		public uint netId;

		public bool isLocalPlayer;

		public bool isOwner;

		public ulong sceneId;

		public uint assetId;

		public global::UnityEngine.Vector3 position;

		public global::UnityEngine.Quaternion rotation;

		public global::UnityEngine.Vector3 scale;

		public global::System.ArraySegment<byte> payload;
	}
}

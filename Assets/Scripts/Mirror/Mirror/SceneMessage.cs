namespace Mirror
{
	public struct SceneMessage : global::Mirror.NetworkMessage
	{
		public string sceneName;

		public global::Mirror.SceneOperation sceneOperation;

		public bool customHandling;
	}
}

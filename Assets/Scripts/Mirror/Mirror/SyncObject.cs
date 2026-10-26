namespace Mirror
{
	public abstract class SyncObject
	{
		public global::System.Action OnDirty;

		public global::System.Func<bool> IsRecording = () => true;

		public global::System.Func<bool> IsWritable = () => true;

		public abstract void ClearChanges();

		public abstract void OnSerializeAll(global::Mirror.NetworkWriter writer);

		public abstract void OnSerializeDelta(global::Mirror.NetworkWriter writer);

		public abstract void OnDeserializeAll(global::Mirror.NetworkReader reader);

		public abstract void OnDeserializeDelta(global::Mirror.NetworkReader reader);

		public abstract void Reset();
	}
}

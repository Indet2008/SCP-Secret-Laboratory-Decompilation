namespace Mirror
{
	public struct TransformSnapshot : global::Mirror.Snapshot
	{
		public global::UnityEngine.Vector3 position;

		public global::UnityEngine.Quaternion rotation;

		public global::UnityEngine.Vector3 scale;

		public double remoteTime { get; set; }

		public double localTime { get; set; }

		public TransformSnapshot(double remoteTime, double localTime, global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale)
		{
			this.remoteTime = remoteTime;
			this.localTime = localTime;
			this.position = position;
			this.rotation = rotation;
			this.scale = scale;
		}

		public static global::Mirror.TransformSnapshot Interpolate(global::Mirror.TransformSnapshot from, global::Mirror.TransformSnapshot to, double t)
		{
			return new global::Mirror.TransformSnapshot(0.0, 0.0, global::UnityEngine.Vector3.LerpUnclamped(from.position, to.position, (float)t), global::UnityEngine.Quaternion.SlerpUnclamped(from.rotation, to.rotation, (float)t), global::UnityEngine.Vector3.LerpUnclamped(from.scale, to.scale, (float)t));
		}
	}
}

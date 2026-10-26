namespace Mirror
{
	[global::System.Serializable]
	public class LagCompensationSettings
	{
		[global::UnityEngine.Header("Buffering")]
		[global::UnityEngine.Tooltip("Keep this many past snapshots in the buffer. The larger this is, the further we can rewind into the past.\nMaximum rewind time := historyAmount * captureInterval")]
		public int historyLimit = 6;

		[global::UnityEngine.Tooltip("Capture state every 'captureInterval' seconds. Larger values will space out the captures more, which gives a longer history but with possible gaps inbetween.\nSmaller values will have fewer gaps, with shorter history.")]
		public float captureInterval = 0.1f;
	}
}

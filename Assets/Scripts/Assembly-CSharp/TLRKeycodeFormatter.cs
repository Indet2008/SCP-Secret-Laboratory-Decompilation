public sealed class TLRKeycodeFormatter : UniversalTextModifier
{
	[global::System.Serializable]
	private struct Key
	{
		public ActionName Action;

		public int FormatIndex;

		public string AdditionalFormat;
	}

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private TLRKeycodeFormatter.Key[] _keys;

	[global::UnityEngine.SerializeField]
	private int _maxChars;

	[global::UnityEngine.SerializeField]
	private string _missingFormat;


}

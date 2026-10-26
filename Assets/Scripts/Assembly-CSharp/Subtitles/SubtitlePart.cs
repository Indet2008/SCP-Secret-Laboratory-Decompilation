namespace Subtitles
{
	public struct SubtitlePart
	{
		public SubtitleType Subtitle;

		public string[] OptionalData;

		public SubtitlePart(SubtitleType subtitle, params string[] optionalData)
		{
			Subtitle = subtitle;
			OptionalData = optionalData;
		}

		public readonly bool CheckEqualValues(SubtitlePart other)
		{
			if (Subtitle != other.Subtitle)
			{
				return false;
			}
			if (OptionalData == null || other.OptionalData == null)
			{
				return OptionalData == other.OptionalData;
			}
			for (int i = 0; i < OptionalData.Length; i++)
			{
				if (!(OptionalData[i] == other.OptionalData[i]))
				{
					return false;
				}
			}
			return true;
		}

		public static bool CheckEqualValues(SubtitlePart[] lhs, SubtitlePart[] rhs)
		{
			if (lhs == null || rhs == null)
			{
				return lhs == rhs;
			}
			if (lhs.Length != rhs.Length)
			{
				return false;
			}
			for (int i = 0; i < lhs.Length; i++)
			{
				if (!lhs[i].CheckEqualValues(rhs[i]))
				{
					return false;
				}
			}
			return true;
		}
	}
}

using Utf8Json.Internal;

namespace Utf8Json.Formatters.Internal
{
	internal static class CollectionFormatterHelper
	{
		internal static readonly byte[][] groupingName;

		internal static readonly AutomataDictionary groupingAutomata;

		static CollectionFormatterHelper()
		{
			groupingName = new byte[2][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("Key"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Elements")
			};
			groupingAutomata = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Key"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Elements"),
					1
				}
			};
		}
	}
}

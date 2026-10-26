namespace Utf8Json
{
	public enum JsonToken : byte
	{
		None = 0,
		BeginObject = 1,
		EndObject = 2,
		BeginArray = 3,
		EndArray = 4,
		Number = 5,
		String = 6,
		True = 7,
		False = 8,
		Null = 9,
		ValueSeparator = 10,
		NameSeparator = 11
	}
}

using System;

namespace Utf8Json
{
	[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Interface, AllowMultiple = false, Inherited = true)]
	public class JsonFormatterAttribute : Attribute
	{
		public Type FormatterType { get; private set; }

		public object[] Arguments { get; private set; }

		public JsonFormatterAttribute(Type formatterType)
		{
			FormatterType = formatterType;
		}

		public JsonFormatterAttribute(Type formatterType, params object[] arguments)
		{
			FormatterType = formatterType;
			Arguments = arguments;
		}
	}
}

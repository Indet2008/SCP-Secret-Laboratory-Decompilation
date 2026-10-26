using System;
using System.Text.RegularExpressions;

namespace Utf8Json.Formatters
{
	public sealed class TypeFormatter : IJsonFormatter<Type>, IJsonFormatter
	{
		public static readonly TypeFormatter Default = new TypeFormatter();

		private static readonly Regex SubtractFullNameRegex = new Regex(", Version=\\d+.\\d+.\\d+.\\d+, Culture=\\w+, PublicKeyToken=\\w+");

		private bool serializeAssemblyQualifiedName;

		private bool deserializeSubtractAssemblyQualifiedName;

		private bool throwOnError;

		public TypeFormatter()
			: this(serializeAssemblyQualifiedName: true, deserializeSubtractAssemblyQualifiedName: true, throwOnError: true)
		{
		}

		public TypeFormatter(bool serializeAssemblyQualifiedName, bool deserializeSubtractAssemblyQualifiedName, bool throwOnError)
		{
			this.serializeAssemblyQualifiedName = serializeAssemblyQualifiedName;
			this.deserializeSubtractAssemblyQualifiedName = deserializeSubtractAssemblyQualifiedName;
			this.throwOnError = throwOnError;
		}

		public void Serialize(ref JsonWriter writer, Type value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
			}
			else if (serializeAssemblyQualifiedName)
			{
				writer.WriteString(value.AssemblyQualifiedName);
			}
			else
			{
				writer.WriteString(value.FullName);
			}
		}

		public Type Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			string text = reader.ReadString();
			if (deserializeSubtractAssemblyQualifiedName)
			{
				text = SubtractFullNameRegex.Replace(text, "");
			}
			return Type.GetType(text, throwOnError);
		}
	}
}

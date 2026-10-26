using System;
using Utf8Json;

public readonly struct TranslationManifest : IEquatable<TranslationManifest>, IJsonSerializable
{
	public readonly string Name;

	public readonly string[] Authors;

	public readonly string[] InterfaceLocales;

	public readonly string[] SystemLocales;

	public readonly string[] ForcedFontOrder;

	[SerializationConstructor]
	public TranslationManifest(string name, string[] authors, string[] interfaceLocales, string[] systemLocales, string[] forcedFontOrder)
	{
		Name = name;
		Authors = authors;
		InterfaceLocales = interfaceLocales;
		SystemLocales = systemLocales;
		ForcedFontOrder = forcedFontOrder;
	}

	public bool Equals(TranslationManifest other)
	{
		if (string.Equals(Name, other.Name, StringComparison.OrdinalIgnoreCase) && Authors == other.Authors && InterfaceLocales == other.InterfaceLocales && SystemLocales == other.SystemLocales)
		{
			return ForcedFontOrder == other.ForcedFontOrder;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is TranslationManifest other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((((((((Name != null) ? StringComparer.OrdinalIgnoreCase.GetHashCode(Name) : 0) * 397) ^ ((Authors != null) ? Authors.GetHashCode() : 0)) * 397) ^ ((InterfaceLocales != null) ? InterfaceLocales.GetHashCode() : 0)) * 397) ^ ((SystemLocales != null) ? SystemLocales.GetHashCode() : 0)) * 397) ^ ((ForcedFontOrder != null) ? ForcedFontOrder.GetHashCode() : 0);
	}

	public static bool operator ==(TranslationManifest left, TranslationManifest right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(TranslationManifest left, TranslationManifest right)
	{
		return !left.Equals(right);
	}
}

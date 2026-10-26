using System;
using Utf8Json;

public readonly struct NewsRaw : IEquatable<NewsRaw>, IJsonSerializable
{
	public readonly NewsList appnews;

	[SerializationConstructor]
	public NewsRaw(NewsList appnews)
	{
		this.appnews = appnews;
	}

	public bool Equals(NewsRaw other)
	{
		return appnews == other.appnews;
	}

	public override bool Equals(object obj)
	{
		if (obj is NewsRaw other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return appnews.GetHashCode();
	}

	public static bool operator ==(NewsRaw left, NewsRaw right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(NewsRaw left, NewsRaw right)
	{
		return !left.Equals(right);
	}
}

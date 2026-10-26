using System;
using Utf8Json;

public readonly struct NewsList : IEquatable<NewsList>, IJsonSerializable
{
	public readonly int appid;

	public readonly NewsListItem[] newsitems;

	public readonly int count;

	[SerializationConstructor]
	public NewsList(int appid, NewsListItem[] newsitems, int count)
	{
		this.appid = appid;
		this.newsitems = newsitems;
		this.count = count;
	}

	public bool Equals(NewsList other)
	{
		return appid == other.appid;
	}

	public override bool Equals(object obj)
	{
		if (obj is NewsList other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		int num = appid;
		return num.GetHashCode();
	}

	public static bool operator ==(NewsList left, NewsList right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(NewsList left, NewsList right)
	{
		return !left.Equals(right);
	}
}

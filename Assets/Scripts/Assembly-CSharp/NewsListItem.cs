using System;
using Utf8Json;

public readonly struct NewsListItem : IEquatable<NewsListItem>, IJsonSerializable
{
	public readonly string gid;

	public readonly string title;

	public readonly string url;

	public readonly bool is_external_url;

	public readonly string author;

	public readonly string contents;

	public readonly string feedlabel;

	public readonly long date;

	public readonly string feedname;

	public readonly int feedtype;

	[SerializationConstructor]
	public NewsListItem(string gid, string title, string url, bool is_external_url, string author, string contents, string feedlabel, long date, string feedname, int feedtype)
	{
		this.gid = gid;
		this.title = title;
		this.url = url;
		this.is_external_url = is_external_url;
		this.author = author;
		this.contents = contents;
		this.feedlabel = feedlabel;
		this.date = date;
		this.feedname = feedname;
		this.feedtype = feedtype;
	}

	public bool Equals(NewsListItem other)
	{
		if (gid == other.gid && title == other.title && url == other.url && is_external_url == other.is_external_url && author == other.author && contents == other.contents && feedlabel == other.feedlabel && date == other.date && feedname == other.feedname)
		{
			return feedtype == other.feedtype;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is NewsListItem other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return gid.GetHashCode();
	}

	public static bool operator ==(NewsListItem left, NewsListItem right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(NewsListItem left, NewsListItem right)
	{
		return !left.Equals(right);
	}
}

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.UI;

// Client-only (bodies stripped from the server build); ported from the SL 12 CE client.
// Loads the game's Steam news feed into the News tab.
public class NewsLoader : MonoBehaviour
{
	private class Announcement
	{
		public string Title;

		public string Content;

		public string Date;

		public string Link;

		public NewsElement Thumbnail;

		public Announcement(string title, string content, string date, string link, NewsElement thumbnail)
		{
			Title = title;
			Content = content;
			Date = date;
			Link = link;
			Thumbnail = thumbnail;
		}
	}

	private const string NewsUrl = "https://api.steampowered.com/ISteamNews/GetNewsForApp/v2/?appid=700330&count=10&feeds=steam_community_announcements";

	private const string LinkFormat = "<color=#ffd38f><u><link=\"{0}\">{1}</link></u></color>";

	public TextMeshProUGUI ArticleText;

	public RectTransform ContentParent;

	public RectTransform Element;

	public Button OpenNewsUrlButton;

	private List<Announcement> _announcements;

	private string _curAnncUrl;

	private void Start()
	{
		_announcements = new List<Announcement>();
		if (OpenNewsUrlButton != null)
		{
			OpenNewsUrlButton.onClick.AddListener(OpenAnnouncementUrl);
		}
		StartCoroutine(Request());
	}

	private IEnumerator Request()
	{
		using UnityWebRequest www = UnityWebRequest.Get(NewsUrl);
		yield return www.SendWebRequest();
		if (www.result != UnityWebRequest.Result.Success)
		{
			Debug.LogWarning("[NewsLoader] Could not load news: " + www.error);
			if (ArticleText != null)
			{
				ArticleText.text = www.error;
			}
			yield break;
		}
		try
		{
			TextProcessor(www.downloadHandler.text);
		}
		catch (Exception ex)
		{
			Debug.LogException(ex);
		}
	}

	private void DetectCustomLinks(ref string content)
	{
		content = Regex.Replace(content, "\\[url=([^\\]]+)\\](.*?)\\[/url\\]", (Match m) => string.Format(LinkFormat, m.Groups[1].Value, m.Groups[2].Value), RegexOptions.Singleline);
	}

	private void DetectImages(ref string content)
	{
		content = Regex.Replace(content, "\\[img[^\\]]*\\].*?\\[/img\\]", string.Empty, RegexOptions.Singleline);
	}

	private void DetectYoutubePreview(ref string content)
	{
		content = Regex.Replace(content, "\\[previewyoutube=([^;\\]]+)[^\\]]*\\]\\s*\\[/previewyoutube\\]", (Match m) => string.Format(LinkFormat, "https://www.youtube.com/watch?v=" + m.Groups[1].Value, "YouTube"));
	}

	private static string ConvertBbCode(string content)
	{
		content = content.Replace("[b]", "<b>").Replace("[/b]", "</b>").Replace("[i]", "<i>").Replace("[/i]", "</i>")
			.Replace("[u]", "<u>").Replace("[/u]", "</u>").Replace("[strike]", "<s>").Replace("[/strike]", "</s>")
			.Replace("[h1]", "<size=130%><color=#ffd38f>").Replace("[/h1]", "</color></size>\n")
			.Replace("[h2]", "<size=120%><color=#ffd38f>").Replace("[/h2]", "</color></size>\n")
			.Replace("[h3]", "<size=110%><color=#ffd38f>").Replace("[/h3]", "</color></size>\n")
			.Replace("[*]", "\u2022 ").Replace("[/*]", "\n")
			.Replace("[p]", string.Empty).Replace("[/p]", "\n");
		// Remaining list/table/layout tags have no TMP equivalent.
		return Regex.Replace(content, "\\[/?(list|olist|table|tr|td|th|hr|quote|code|noparse|spoiler)[^\\]]*\\]", string.Empty);
	}

	private void TextProcessor(string text)
	{
		NewsRaw raw = JsonSerialize.FromJson<NewsRaw>(text);
		NewsListItem[] items = raw.appnews.newsitems;
		if (items == null || Element == null || ContentParent == null)
		{
			return;
		}
		foreach (NewsListItem item in items)
		{
			string content = item.contents ?? string.Empty;
			DetectYoutubePreview(ref content);
			DetectImages(ref content);
			DetectCustomLinks(ref content);
			content = ConvertBbCode(content).Trim();
			// Steam dates are UTC seconds; shown in the selected translation's long date format.
			string date = DateTimeOffset.FromUnixTimeSeconds(item.date).ToLocalTime().ToString("D", TranslationReader.TranslationCulture ?? System.Globalization.CultureInfo.CurrentCulture);
			RectTransform instance = Instantiate(Element, ContentParent);
			instance.gameObject.SetActive(true);
			NewsElement element = instance.GetComponent<NewsElement>();
			if (element != null)
			{
				element.Id = _announcements.Count;
				if (element.Title != null)
				{
					element.Title.text = item.title;
				}
				if (element.Date != null)
				{
					element.Date.text = date;
				}
				if (element.Content != null)
				{
					element.Content.text = content;
				}
			}
			_announcements.Add(new Announcement(item.title, content, date, item.url, element));
		}
		if (_announcements.Count > 0)
		{
			ShowAnnouncement(0);
		}
	}

	internal void OpenAnnouncementUrl()
	{
		if (!string.IsNullOrEmpty(_curAnncUrl))
		{
			Application.OpenURL(_curAnncUrl);
		}
	}

	internal void ShowAnnouncement(int id)
	{
		if (_announcements == null || id < 0 || id >= _announcements.Count)
		{
			return;
		}
		Announcement announcement = _announcements[id];
		_curAnncUrl = announcement.Link;
		if (ArticleText != null)
		{
			ArticleText.text = "<size=150%><b>" + announcement.Title.ToUpperInvariant() + "</b></size>\n<size=120%><i>" + announcement.Date + "</i></size>\n\n" + announcement.Content;
		}
		if (OpenNewsUrlButton != null)
		{
			OpenNewsUrlButton.interactable = !string.IsNullOrEmpty(_curAnncUrl);
		}
	}
}

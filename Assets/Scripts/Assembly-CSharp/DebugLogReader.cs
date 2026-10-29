using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using MEC;
using UnityEngine;
using UnityEngine.UI;

public class DebugLogReader : MonoBehaviour
{
	public GameObject Parent;

	public Text Prefab;

	private static readonly List<Text> Lines = new List<Text>();

	private static readonly List<string> Linesstring = new List<string>();

	public ScrollRect Scroll;

	private static int _lineLimit = 1000;

	private const int MaxCharsPerText = 4000;

	public static bool SuccesfullyInitialized()
	{
		Linesstring.Clear();
		try
		{
			string consoleLogPath = Application.consoleLogPath;
			if (string.IsNullOrEmpty(consoleLogPath) || !File.Exists(Path.GetFullPath(consoleLogPath)))
			{
				return false;
			}
			using FileStream stream = new FileStream(consoleLogPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
			using StreamReader streamReader = new StreamReader(stream, Encoding.UTF8);
			string text;
			while ((text = streamReader.ReadLine()) != null)
			{
				if (!string.IsNullOrWhiteSpace(text))
				{
					Linesstring.Add(text);
				}
			}
			if (Linesstring.Count > _lineLimit)
			{
				Linesstring.RemoveRange(0, Linesstring.Count - _lineLimit);
			}
			return true;
		}
		catch (Exception)
		{
			return false;
		}
	}

	public void OnEnable()
	{
		ClearLines();
		StringBuilder stringBuilder = new StringBuilder(MaxCharsPerText + 500);
		foreach (string item in Linesstring)
		{
			if (stringBuilder.Length + item.Length > MaxCharsPerText && stringBuilder.Length > 0)
			{
				SpawnText(stringBuilder.ToString().TrimEnd());
				stringBuilder.Length = 0;
			}
			stringBuilder.Append(item);
			stringBuilder.Append(Environment.NewLine);
		}
		if (stringBuilder.Length > 0)
		{
			SpawnText(stringBuilder.ToString().TrimEnd());
		}
		if (Scroll != null)
		{
			Timing.RunCoroutine(ScrollToDown(Scroll));
		}
	}

	public void OnDisable()
	{
		ClearLines();
		Linesstring.Clear();
	}

	private void SpawnText(string content)
	{
		Text text = UnityEngine.Object.Instantiate(Prefab, Parent.transform);
		text.text = content;
		text.gameObject.SetActive(value: true);
		Lines.Add(text);
	}

	private static void ClearLines()
	{
		foreach (Text line in Lines)
		{
			if (line != null)
			{
				UnityEngine.Object.Destroy(line.gameObject);
			}
		}
		Lines.Clear();
	}

	private static IEnumerator<float> ScrollToDown(ScrollRect scrollRect)
	{
		yield return Timing.WaitForOneFrame;
		if (scrollRect != null)
		{
			scrollRect.verticalNormalizedPosition = 0f;
		}
	}
}

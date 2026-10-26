using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using NorthwoodLib.Pools;
using UnityEngine;

namespace Utils
{
	public static class RAUtils
	{
		private const string PlayerNameRegex = "@\"(.*?)\".|@[^\\s.]+\\.";

		public static readonly Regex IsDigit = new Regex("^(\\d*\\.?\\d*)$", RegexOptions.None);

		public static string FormatArguments(ArraySegment<string> args, int index, int? maxLen = null)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			foreach (string item in maxLen.HasValue ? args.Segment(index, maxLen.Value) : args.Segment(index))
			{
				stringBuilder.Append(item);
				stringBuilder.Append(' ');
			}
			string result = stringBuilder.ToString();
			StringBuilderPool.Shared.Return(stringBuilder);
			return result;
		}

		public static List<ReferenceHub> ProcessPlayerIdOrNamesList(ArraySegment<string> args, int startindex, out string[] newargs, bool keepEmptyEntries = false)
		{
			try
			{
				string text = FormatArguments(args, startindex);
				List<ReferenceHub> list = ListPool<ReferenceHub>.Shared.Rent();
				if (text.StartsWith('@'))
				{
					foreach (Match item in new Regex("@\"(.*?)\".|@[^\\s.]+\\.").Matches(text))
					{
						text = ReplaceFirst(text, item.Value, "");
						string name = item.Value.Substring(1).Replace("\"", "").Replace(".", "");
						List<ReferenceHub> list2 = ReferenceHub.AllHubs.Where((ReferenceHub ply) => ply.nicknameSync.MyNick.Equals(name)).ToList();
						if (list2.Count == 1 && !list.Contains(list2[0]))
						{
							list.Add(list2[0]);
						}
					}
					newargs = text.Split(' ', (!keepEmptyEntries) ? StringSplitOptions.RemoveEmptyEntries : StringSplitOptions.None);
					return list;
				}
				if (args.At(startindex).Length > 0)
				{
					if (char.IsDigit(args.At(startindex)[0]))
					{
						string[] array = args.At(startindex).Split('.');
						for (int num = 0; num < array.Length; num++)
						{
							if (int.TryParse(array[num], out var result) && ReferenceHub.TryGetHub(result, out var hub) && !list.Contains(hub))
							{
								list.Add(hub);
							}
						}
					}
					else if (char.IsLetter(args.At(startindex)[0]))
					{
						string[] array = args.At(startindex).Split('.');
						foreach (string value in array)
						{
							foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
							{
								if (allHub.nicknameSync.MyNick.Equals(value) && !list.Contains(allHub))
								{
									list.Add(allHub);
								}
							}
						}
					}
				}
				newargs = ((args.Count > 1) ? FormatArguments(args, startindex + 1).Split(' ', (!keepEmptyEntries) ? StringSplitOptions.RemoveEmptyEntries : StringSplitOptions.None) : null);
				return list;
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				newargs = null;
				return null;
			}
		}

		private static string ReplaceFirst(string str, string search, string replace)
		{
			int num = str.IndexOf(search, StringComparison.Ordinal);
			if (num >= 0)
			{
				return str.Substring(0, num) + replace + str.Substring(num + search.Length);
			}
			return str;
		}
	}
}

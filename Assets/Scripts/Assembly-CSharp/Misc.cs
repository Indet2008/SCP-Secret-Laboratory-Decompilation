using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using CommandSystem;
using Footprinting;
using Mirror;
using NorthwoodLib;
using NorthwoodLib.Pools;
using UnityEngine;

public static class Misc
{
	public enum IPAddressType
	{
		Unknown = 0,
		IPV4 = 1,
		IPV6 = 2,
		Localhost = 3,
		Hostname = 4
	}

	public enum PlayerInfoColorTypes
	{
		Pink = 0,
		Red = 1,
		Brown = 2,
		Silver = 3,
		LightGreen = 4,
		Crimson = 5,
		Cyan = 6,
		Aqua = 7,
		DeepPink = 8,
		Tomato = 9,
		Yellow = 10,
		Magenta = 11,
		BlueGreen = 12,
		Orange = 13,
		Lime = 14,
		Green = 15,
		Emerald = 16,
		Carmine = 17,
		Nickel = 18,
		Mint = 19,
		ArmyGreen = 20,
		Pumpkin = 21,
		Black = 22,
		White = 23
	}

	public enum CommandOperationMode
	{
		Disable = 0,
		Enable = 1,
		Toggle = 2
	}

	private static readonly Regex TagRegex;

	private static readonly Color _raOrange;

	private static readonly Color _darkGreen;

	public static Encoding Utf8Encoding;

	private static readonly Dictionary<ConsoleColor, Color> ConsoleColors;

	private static readonly Regex _pbRgx;

	private static readonly Regex _ipV4Rgx;

	private static readonly Regex _ipV6Rgx;

	private static readonly Regex _hostNameRgx;

	private static readonly Regex _stpRgx;

	internal static readonly Regex CommandRegex;

	internal static readonly Regex CommandDescriptionRegex;

	internal static readonly Regex RichTextRegex;

	public static readonly Regex PlayerCustomInfoRegex;

	private static readonly Regex FormatBracketRegex;

	public static readonly string[] AcceptedColours;

	public static readonly Dictionary<PlayerInfoColorTypes, string> AllowedColors;

	private static readonly Color32 _defaultColor;

	static Misc()
	{
		TagRegex = new Regex("<(\\/?(align|allcaps|alpha|b|color|cspace|font|font-weight|gradient|i|indent|line-height|line-indent|link|lowercase|margin|mark|mspace|nobr|noparse|page|pos|rotate|s|size|smallcaps|space|sprite|style|sub|sup|u|uppercase|voffset|width))[^<>]*>");
		_raOrange = new Color32(byte.MaxValue, 180, 0, byte.MaxValue);
		_darkGreen = new Color32(80, 150, 80, byte.MaxValue);
		Utf8Encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);
		ConsoleColors = new Dictionary<ConsoleColor, Color>();
		_pbRgx = new Regex("^[a-zA-Z0-9]{8}$", RegexOptions.IgnoreCase | RegexOptions.Compiled);
		_ipV4Rgx = new Regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$", RegexOptions.IgnoreCase | RegexOptions.Compiled);
		_ipV6Rgx = new Regex("^((([0-9a-f]{1,4}:){7}([0-9a-f]{1,4}|:))|(([0-9a-f]{1,4}:){6}(:[0-9a-f]{1,4}|((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9a-f]{1,4}:){5}(((:[0-9a-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9a-f]{1,4}:){4}(((:[0-9a-f]{1,4}){1,3})|((:[0-9a-f]{1,4})?:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9a-f]{1,4}:){3}(((:[0-9a-f]{1,4}){1,4})|((:[0-9a-f]{1,4}){0,2}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9a-f]{1,4}:){2}(((:[0-9a-f]{1,4}){1,5})|((:[0-9a-f]{1,4}){0,3}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9a-f]{1,4}:){1}(((:[0-9a-f]{1,4}){1,6})|((:[0-9a-f]{1,4}){0,4}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(:(((:[0-9a-f]{1,4}){1,7})|((:[0-9a-f]{1,4}){0,5}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:)))$", RegexOptions.IgnoreCase | RegexOptions.Compiled);
		_hostNameRgx = new Regex("^(([a-z0-9]|[a-z0-9][a-z0-9\\-]*[a-z0-9])\\.)*([a-z0-9]|[a-z0-9][a-z0-9\\-]*[a-z0-9])$", RegexOptions.IgnoreCase | RegexOptions.Compiled);
		_stpRgx = new Regex("<size=[^>]{0,}>", RegexOptions.Compiled);
		CommandRegex = new Regex("^[a-zA-Z0-9\\-_.]{1,40}$", RegexOptions.Compiled);
		CommandDescriptionRegex = new Regex("^[\\p{L}\\p{P}\\p{Sm}\\p{Sc}\\p{N} ^]{1,80}(\\.\\.\\.|)$", RegexOptions.Compiled);
		RichTextRegex = new Regex("(?!<*?>)<.*?>", RegexOptions.Compiled);
		PlayerCustomInfoRegex = new Regex("^((?![\\[\\]])[\\p{L}\\p{P}\\p{Sc}\\p{N} ^=+|~`<>\\n]){0,400}$", RegexOptions.Compiled);
		FormatBracketRegex = new Regex("{\\d*}", RegexOptions.Compiled);
		AcceptedColours = new string[24]
		{
			"FF96DE", "C50000", "944710", "A0A0A0", "32CD32", "DC143C", "00B7EB", "00FFFF", "FF1493", "FF6448",
			"FAFF86", "FF0090", "4DFFB8", "FF9966", "BFFF00", "228B22", "50C878", "960018", "727472", "98FB98",
			"4B5320", "EE7600", "FFFFFF", "000000"
		};
		AllowedColors = new Dictionary<PlayerInfoColorTypes, string>
		{
			{
				PlayerInfoColorTypes.Pink,
				"#FF96DE"
			},
			{
				PlayerInfoColorTypes.Red,
				"#C50000"
			},
			{
				PlayerInfoColorTypes.Brown,
				"#944710"
			},
			{
				PlayerInfoColorTypes.Silver,
				"#A0A0A0"
			},
			{
				PlayerInfoColorTypes.LightGreen,
				"#32CD32"
			},
			{
				PlayerInfoColorTypes.Crimson,
				"#DC143C"
			},
			{
				PlayerInfoColorTypes.Cyan,
				"#00B7EB"
			},
			{
				PlayerInfoColorTypes.Aqua,
				"#00FFFF"
			},
			{
				PlayerInfoColorTypes.DeepPink,
				"#FF1493"
			},
			{
				PlayerInfoColorTypes.Tomato,
				"#FF6448"
			},
			{
				PlayerInfoColorTypes.Yellow,
				"#FAFF86"
			},
			{
				PlayerInfoColorTypes.Magenta,
				"#FF0090"
			},
			{
				PlayerInfoColorTypes.BlueGreen,
				"#4DFFB8"
			},
			{
				PlayerInfoColorTypes.Orange,
				"#FF9966"
			},
			{
				PlayerInfoColorTypes.Lime,
				"#BFFF00"
			},
			{
				PlayerInfoColorTypes.Green,
				"#228B22"
			},
			{
				PlayerInfoColorTypes.Emerald,
				"#50C878"
			},
			{
				PlayerInfoColorTypes.Carmine,
				"#960018"
			},
			{
				PlayerInfoColorTypes.Nickel,
				"#727472"
			},
			{
				PlayerInfoColorTypes.Mint,
				"#98FB98"
			},
			{
				PlayerInfoColorTypes.ArmyGreen,
				"#4B5320"
			},
			{
				PlayerInfoColorTypes.Pumpkin,
				"#EE7600"
			},
			{
				PlayerInfoColorTypes.Black,
				"#000000"
			},
			{
				PlayerInfoColorTypes.White,
				"#FFFFFF"
			}
		};
		_defaultColor = Color.white;
		ConsoleColor[] values = EnumUtils<ConsoleColor>.Values;
		foreach (ConsoleColor consoleColor in values)
		{
			ConsoleColors.Add(consoleColor, ServerConsole.ConsoleColorToColor(consoleColor));
		}
	}

	public static bool CheckPermission(this ICommandSender sender, PlayerPermissions[] perms)
	{
		if (sender is CommandSender commandSender)
		{
			return PermissionsHandler.IsPermitted(commandSender.Permissions, perms);
		}
		return false;
	}

	public static bool CheckPermission(this ICommandSender sender, PlayerPermissions perm)
	{
		if (sender is CommandSender commandSender)
		{
			if (!commandSender.FullPermissions)
			{
				return PermissionsHandler.IsPermitted(commandSender.Permissions, perm);
			}
			return true;
		}
		return false;
	}

	public static bool CheckPermission(this ICommandSender sender, PlayerPermissions perm, out string response)
	{
		if (sender.CheckPermission(perm))
		{
			response = null;
			return true;
		}
		response = "You don't have permissions to execute this command.\nRequired permission: " + perm;
		return false;
	}

	public static bool CheckPermission(this ICommandSender sender, PlayerPermissions[] perms, out string response)
	{
		if (sender.CheckPermission(perms))
		{
			response = null;
			return true;
		}
		response = "You don't have permissions to execute this command.\nYou need at least one of following permissions: " + string.Join(", ", perms);
		return false;
	}

	public static string LeadingZeroes(int integer, uint len, bool plusSign = false)
	{
		bool flag = integer < 0;
		if (flag)
		{
			integer *= -1;
		}
		string text = integer.ToString();
		while (text.Length < len)
		{
			text = "0" + text;
		}
		return (flag ? "-" : (plusSign ? "+" : "")) + text;
	}

	public static string LoggedNameFromRefHub(this ReferenceHub me)
	{
		return me.nicknameSync.CombinedName + " (" + (me.authManager.UserId ?? "null") + ")";
	}

	public static string LoggedNameFromFootprint(this Footprint me)
	{
		if (me.Hub != null)
		{
			return me.Hub.LoggedNameFromRefHub();
		}
		return me.Nickname + " (" + me.LogUserID + ")";
	}

	public static string SanitizeRichText(string content, string replaceOpenChar = "", string replaceCloseChar = "")
	{
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent(content);
		stringBuilder.Replace("<", replaceOpenChar);
		stringBuilder.Replace("\\u003c", replaceOpenChar);
		stringBuilder.Replace(">", replaceCloseChar);
		stringBuilder.Replace("\\u003e", replaceCloseChar);
		return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
	}

	public static string CloseAllRichTextTags(string content)
	{
		if (string.IsNullOrEmpty(content))
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent(content);
		MatchCollection matchCollection = TagRegex.Matches(content);
		Dictionary<string, int> dictionary = new Dictionary<string, int>();
		foreach (Match item in matchCollection)
		{
			string key = item.Groups[1].Value.ToLowerInvariant();
			if (!dictionary.TryAdd(key, 1))
			{
				dictionary[key]++;
			}
		}
		foreach (KeyValuePair<string, int> item2 in dictionary.Where((KeyValuePair<string, int> pair) => !pair.Key.StartsWith('/')))
		{
			int value = (dictionary.TryGetValue("/" + item2.Key, out value) ? (item2.Value - value) : item2.Value);
			for (int num = 0; num < value; num++)
			{
				stringBuilder.Append("</").Append(item2.Key).Append('>');
			}
		}
		return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
	}

	public static int LevenshteinDistance(string s, string t)
	{
		int length = s.Length;
		int length2 = t.Length;
		int[,] array = new int[length + 1, length2 + 1];
		if (length == 0)
		{
			return length2;
		}
		if (length2 == 0)
		{
			return length;
		}
		int num = 0;
		while (num <= length)
		{
			array[num, 0] = num++;
		}
		int num2 = 0;
		while (num2 <= length2)
		{
			array[0, num2] = num2++;
		}
		for (int i = 1; i <= length; i++)
		{
			for (int j = 1; j <= length2; j++)
			{
				int num3 = ((t[j - 1] != s[i - 1]) ? 1 : 0);
				array[i, j] = Math.Min(Math.Min(array[i - 1, j] + 1, array[i, j - 1] + 1), array[i - 1, j - 1] + num3);
			}
		}
		return array[length, length2];
	}

	public static string LongestCommonSubstring(string a, string b)
	{
		if (a == null || b == null)
		{
			return string.Empty;
		}
		int[,] array = new int[a.Length, b.Length];
		int num = 0;
		string result = "";
		for (int i = 0; i < a.Length; i++)
		{
			for (int j = 0; j < b.Length; j++)
			{
				if (a[i] == b[j])
				{
					array[i, j] = ((i == 0 || j == 0) ? 1 : (array[i - 1, j - 1] + 1));
					if (array[i, j] > num)
					{
						num = array[i, j];
						result = a.Substring(i - num + 1, num);
					}
				}
				else
				{
					array[i, j] = 0;
				}
			}
		}
		return result;
	}

	private static string LongestCommonSubstringOfAInB(string a, string b)
	{
		if (b.Length < a.Length)
		{
			string text = b;
			string text2 = a;
			a = text;
			b = text2;
		}
		for (int num = a.Length; num > 0; num--)
		{
			for (int i = a.Length - num; i <= a.Length - num; i++)
			{
				string text3 = a.Substring(i, num);
				if (b.Contains(text3))
				{
					return text3;
				}
			}
		}
		return string.Empty;
	}

	public static bool ValidatePastebin(string text)
	{
		return _pbRgx.IsMatch(text);
	}

	public static bool ValidateIpOrHostname(string ipOrHost, out IPAddressType type, bool allowHostname = true, bool allowLocalhost = true)
	{
		if (ipOrHost == "localhost")
		{
			type = IPAddressType.Localhost;
			return allowLocalhost;
		}
		if (_ipV4Rgx.IsMatch(ipOrHost))
		{
			type = IPAddressType.IPV4;
			return true;
		}
		if (_ipV6Rgx.IsMatch(ipOrHost))
		{
			type = IPAddressType.IPV6;
			return true;
		}
		if (_hostNameRgx.IsMatch(ipOrHost))
		{
			type = IPAddressType.Hostname;
			return allowHostname;
		}
		type = IPAddressType.Unknown;
		return false;
	}

	public static long RelativeTimeToSeconds(string time, int defaultFactor = 1)
	{
		if (long.TryParse(time, out var result))
		{
			return result * defaultFactor;
		}
		if (time.Length < 2)
		{
			throw new Exception($"{result} is not a valid time.");
		}
		if (!long.TryParse(time.Substring(0, time.Length - 1), out result))
		{
			throw new Exception($"{result} is not a valid time.");
		}
		switch (time[time.Length - 1])
		{
		case 'S':
		case 's':
			return result;
		case 'm':
			return result * 60;
		case 'H':
		case 'h':
			return result * 3600;
		case 'D':
		case 'd':
			return result * 86400;
		case 'M':
			return result * 2592000;
		case 'Y':
		case 'y':
			return result * 31536000;
		default:
			throw new Exception($"{result} is not a valid time.");
		}
	}

	public static List<int> ProcessRaPlayersList(string playerIds)
	{
		try
		{
			List<int> list = new List<int>();
			string[] source = playerIds.Split('.');
			list.AddRange(source.Where((string item) => !string.IsNullOrEmpty(item)).Select(int.Parse));
			return list;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return null;
		}
	}

	public static string GetRuntimeVersion()
	{
		try
		{
			return RuntimeInformation.FrameworkDescription;
		}
		catch
		{
			return "Not supported!";
		}
	}

	public static AudioType GetAudioType(string path)
	{
		switch (Path.GetExtension(path))
		{
		case ".ogg":
			return AudioType.OGGVORBIS;
		case ".wav":
			return AudioType.WAV;
		case ".aac":
			return AudioType.ACC;
		case ".aiff":
			return AudioType.AIFF;
		case ".mod":
			return AudioType.MOD;
		case ".mp3":
		case ".mp2":
		case ".mpeg":
			return AudioType.MPEG;
		default:
			return AudioType.UNKNOWN;
		}
	}

	public static bool CultureInfoTryParse(string name, out CultureInfo info)
	{
		try
		{
			info = CultureInfo.GetCultureInfo(name);
			return true;
		}
		catch
		{
			info = null;
			return false;
		}
	}

	public static string ToHex(this Color color)
	{
		return ((Color32)color).ToHex();
	}

	public static string ToHex(this Color32 color)
	{
		return "#" + color.r.ToString("X2") + color.g.ToString("X2") + color.b.ToString("X2") + color.a.ToString("X2");
	}

	public static bool TryParseColor(string input, out Color32 color)
	{
		if (string.IsNullOrEmpty(input))
		{
			color = _defaultColor;
			return false;
		}
		switch (input)
		{
		case "red":
			color = new Color32(byte.MaxValue, 0, 0, byte.MaxValue);
			return true;
		case "cyan":
			color = new Color32(0, byte.MaxValue, byte.MaxValue, byte.MaxValue);
			return true;
		case "blue":
			color = new Color32(0, 0, byte.MaxValue, byte.MaxValue);
			return true;
		case "darkblue":
			color = new Color32(0, 0, 139, byte.MaxValue);
			return true;
		case "lightblue":
			color = new Color32(173, 216, 230, byte.MaxValue);
			return true;
		case "purple":
			color = new Color32(128, 0, 128, byte.MaxValue);
			return true;
		case "yellow":
			color = new Color32(byte.MaxValue, byte.MaxValue, 0, byte.MaxValue);
			return true;
		case "lime":
			color = new Color32(0, byte.MaxValue, 0, byte.MaxValue);
			return true;
		case "fuchsia":
			color = new Color32(byte.MaxValue, 0, byte.MaxValue, byte.MaxValue);
			return true;
		case "white":
			color = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
			return true;
		case "silver":
			color = new Color32(192, 192, 192, byte.MaxValue);
			return true;
		case "gray":
		case "grey":
			color = new Color32(128, 128, 128, byte.MaxValue);
			return true;
		case "black":
			color = new Color32(0, 0, 0, byte.MaxValue);
			return true;
		case "orange":
			color = new Color32(byte.MaxValue, 165, 0, byte.MaxValue);
			return true;
		case "brown":
			color = new Color32(165, 42, 42, byte.MaxValue);
			return true;
		case "maroon":
			color = new Color32(128, 0, 0, byte.MaxValue);
			return true;
		case "green":
			color = new Color32(0, 128, 0, byte.MaxValue);
			return true;
		case "olive":
			color = new Color32(128, 128, 0, byte.MaxValue);
			return true;
		case "navy":
			color = new Color32(0, 0, 128, byte.MaxValue);
			return true;
		case "teal":
			color = new Color32(0, 128, 128, byte.MaxValue);
			return true;
		case "aqua":
			color = new Color32(0, byte.MaxValue, byte.MaxValue, byte.MaxValue);
			return true;
		case "magenta":
			color = new Color32(byte.MaxValue, 0, byte.MaxValue, byte.MaxValue);
			return true;
		default:
			if (input.StartsWith("#"))
			{
				input = input.Substring(1);
			}
			if (input.Length >= 6)
			{
				if (!byte.TryParse(input.Substring(0, 2), NumberStyles.HexNumber, null, out var result))
				{
					color = _defaultColor;
					return false;
				}
				if (!byte.TryParse(input.Substring(2, 2), NumberStyles.HexNumber, null, out var result2))
				{
					color = _defaultColor;
					return false;
				}
				if (!byte.TryParse(input.Substring(4, 2), NumberStyles.HexNumber, null, out var result3))
				{
					color = _defaultColor;
					return false;
				}
				byte a = byte.MaxValue;
				if (input.Length >= 8)
				{
					if (!byte.TryParse(input.Substring(6, 2), NumberStyles.HexNumber, null, out var result4))
					{
						color = _defaultColor;
						return false;
					}
					a = result4;
				}
				color = new Color32(result, result2, result3, a);
				return true;
			}
			color = _defaultColor;
			return false;
		}
	}

	public static ConsoleColor ClosestConsoleColor(Color color, bool excludeDark = true)
	{
		if (color == Color.green)
		{
			return ConsoleColor.Green;
		}
		if (color == Color.red)
		{
			return ConsoleColor.Red;
		}
		if (color == Color.gray || color == Color.white || color == Color.black)
		{
			return ConsoleColor.White;
		}
		if (color == Color.magenta)
		{
			return ConsoleColor.Magenta;
		}
		if (color == Color.yellow)
		{
			return ConsoleColor.Yellow;
		}
		if (color == _raOrange)
		{
			return ConsoleColor.DarkYellow;
		}
		if (color == _darkGreen)
		{
			return ConsoleColor.DarkGreen;
		}
		ConsoleColor consoleColor = ConsoleColor.White;
		double num = color.r;
		double num2 = color.g;
		double num3 = color.b;
		double num4 = double.MaxValue;
		foreach (KeyValuePair<ConsoleColor, Color> consoleColor2 in ConsoleColors)
		{
			Color value = consoleColor2.Value;
			double num5 = Math.Pow((double)value.r - num, 2.0) + Math.Pow((double)value.g - num2, 2.0) + Math.Pow((double)value.b - num3, 2.0);
			if (num5 == 0.0)
			{
				return consoleColor2.Key;
			}
			if (num5 < num4)
			{
				num4 = num5;
				consoleColor = consoleColor2.Key;
			}
		}
		if ((consoleColor == ConsoleColor.Black || consoleColor == ConsoleColor.Gray || consoleColor == ConsoleColor.DarkGray) & excludeDark)
		{
			return ConsoleColor.White;
		}
		return consoleColor;
	}

	public static void WriteBoolByte(this NetworkWriter writer, bool bool1 = false, bool bool2 = false, bool bool3 = false, bool bool4 = false, bool bool5 = false, bool bool6 = false, bool bool7 = false, bool bool8 = false)
	{
		byte b = 0;
		if (bool1)
		{
			b |= 1;
		}
		if (bool2)
		{
			b |= 2;
		}
		if (bool3)
		{
			b |= 4;
		}
		if (bool4)
		{
			b |= 8;
		}
		if (bool5)
		{
			b |= 0x10;
		}
		if (bool6)
		{
			b |= 0x20;
		}
		if (bool7)
		{
			b |= 0x40;
		}
		if (bool8)
		{
			b |= 0x80;
		}
		writer.WriteByte(b);
	}

	public static void ReadBoolByte(this NetworkReader reader, out bool bool1, out bool bool2, out bool bool3, out bool bool4, out bool bool5, out bool bool6, out bool bool7, out bool bool8)
	{
		byte b = reader.ReadByte();
		bool1 = (b & 1) == 1;
		bool2 = (b & 2) == 2;
		bool3 = (b & 4) == 4;
		bool4 = (b & 8) == 8;
		bool5 = (b & 0x10) == 16;
		bool6 = (b & 0x20) == 32;
		bool7 = (b & 0x40) == 64;
		bool8 = (b & 0x80) == 128;
	}

	public static void ReadBoolByte(this NetworkReader reader, out bool bool1, out bool bool2, out bool bool3, out bool bool4)
	{
		byte b = reader.ReadByte();
		bool1 = (b & 1) == 1;
		bool2 = (b & 2) == 2;
		bool3 = (b & 4) == 4;
		bool4 = (b & 8) == 8;
	}

	public static void WriteBoolArray(this NetworkWriter writer, bool[] array)
	{
		byte b = 0;
		bool flag = false;
		for (int i = 0; i < array.Length; i++)
		{
			int num = i % 8;
			if (array[i])
			{
				b |= (byte)(1 << num);
			}
			if (num + 1 < 8)
			{
				flag = true;
				continue;
			}
			writer.WriteByte(b);
			b = 0;
			flag = false;
		}
		if (flag)
		{
			writer.WriteByte(b);
		}
	}

	public static void ReadBoolArray(this NetworkReader reader, bool[] array)
	{
		byte b = 0;
		for (int i = 0; i < array.Length; i++)
		{
			int num = i % 8;
			if (num == 0)
			{
				b = reader.ReadByte();
			}
			byte b2 = (byte)(1 << num);
			array[i] = (b2 & b) != 0;
		}
	}

	public static byte BoolsToByte(bool bool1 = false, bool bool2 = false, bool bool3 = false, bool bool4 = false, bool bool5 = false, bool bool6 = false, bool bool7 = false, bool bool8 = false)
	{
		byte b = 0;
		if (bool1)
		{
			b |= 1;
		}
		if (bool2)
		{
			b |= 2;
		}
		if (bool3)
		{
			b |= 4;
		}
		if (bool4)
		{
			b |= 8;
		}
		if (bool5)
		{
			b |= 0x10;
		}
		if (bool6)
		{
			b |= 0x20;
		}
		if (bool7)
		{
			b |= 0x40;
		}
		if (bool8)
		{
			b |= 0x80;
		}
		return b;
	}

	public static void ByteToBools(byte b, out bool bool1, out bool bool2, out bool bool3, out bool bool4, out bool bool5, out bool bool6, out bool bool7, out bool bool8)
	{
		bool1 = (b & 1) == 1;
		bool2 = (b & 2) == 2;
		bool3 = (b & 4) == 4;
		bool4 = (b & 8) == 8;
		bool5 = (b & 0x10) == 16;
		bool6 = (b & 0x20) == 32;
		bool7 = (b & 0x40) == 64;
		bool8 = (b & 0x80) == 128;
	}

	public unsafe static int GetBytes(this Encoding encoding, string text, NativeMemory memory)
	{
		fixed (char* chars = text)
		{
			return encoding.GetBytes(chars, text.Length, memory.ToPointer<byte>(), memory.Length);
		}
	}

	public static bool IsSafeCharacter(char c)
	{
		if (c > '\u001f')
		{
			return c < '\u007f';
		}
		return false;
	}

	public static void ReplaceUnsafeCharacters(ref string text, char replaceCharacter = '?')
	{
		if (text == null)
		{
			text = string.Empty;
			return;
		}
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent(text.Length);
		for (int i = 0; i < text.Length; i++)
		{
			stringBuilder.Append(IsSafeCharacter(text[i]) ? text[i] : replaceCharacter);
		}
		text = stringBuilder.ToString();
		StringBuilderPool.Shared.Return(stringBuilder);
	}

	public static System.Random CreateRandom()
	{
		byte[] array = new byte[4];
		using (RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider())
		{
			rNGCryptoServiceProvider.GetBytes(array);
		}
		return new System.Random(BitConverter.ToInt32(array, 0));
	}

	public static Vector3 NormalizeIgnoreY(this Vector3 v)
	{
		v.y = 0f;
		return v.normalized;
	}

	public static Vector3 NormalizeConstrained(this Vector3 v, Vector3 constraintDirection)
	{
		Vector3 vector = Vector3.Dot(v, constraintDirection) * constraintDirection;
		Vector3 vector2 = v - vector;
		float sqrMagnitude = vector2.sqrMagnitude;
		if (sqrMagnitude > 0f)
		{
			float num = Mathf.Sqrt(1f - vector.sqrMagnitude) / Mathf.Sqrt(sqrMagnitude);
			vector2 *= num;
		}
		return vector + vector2;
	}

	public static Vector3 ClampDot(this Vector3 vectorToClamp, Vector3 targetDirectionVector, float minimumDot)
	{
		float num = Vector3.Dot(vectorToClamp, targetDirectionVector);
		if (num >= minimumDot)
		{
			return vectorToClamp;
		}
		Vector3 vector = vectorToClamp - targetDirectionVector * num;
		float num2 = Mathf.Sqrt(1f - minimumDot * minimumDot);
		return targetDirectionVector * minimumDot + vector.normalized * num2;
	}

	public static Vector3 Abs(this Vector3 v)
	{
		return new Vector3(Mathf.Abs(v.x), Mathf.Abs(v.y), Mathf.Abs(v.z));
	}

	public static float SqrMagnitudeIgnoreY(this Vector3 v)
	{
		return (float)((double)v.x * (double)v.x + (double)v.z * (double)v.z);
	}

	public static float MagnitudeIgnoreY(this Vector3 v)
	{
		return (float)Math.Sqrt((double)v.x * (double)v.x + (double)v.z * (double)v.z);
	}

	public static float MagnitudeOnlyY(this Vector3 v)
	{
		return Math.Abs(v.y);
	}

	public static string ToPreciseString(this Vector2 v)
	{
		return $"[{v.x:F3}, {v.y:F3}]";
	}

	public static string ToPreciseString(this Vector3 v)
	{
		return $"[{v.x:F3}, {v.y:F3}, {v.z:F3}]";
	}

	public static float AngleIgnoreY(Vector3 from, Vector3 to)
	{
		to.y = from.y;
		float num = (float)Math.Sqrt((double)from.SqrMagnitudeIgnoreY() * (double)to.SqrMagnitudeIgnoreY());
		if (!((double)num < 1.00000000362749E-15))
		{
			return (float)Math.Acos(Mathf.Clamp(Vector3.Dot(from, to) / num, -1f, 1f)) * 57.29578f;
		}
		return 0f;
	}

	public static Vector2 RotateAroundZ(this Vector2 vector, float degrees)
	{
		float num = Mathf.Sin(degrees * (MathF.PI / 180f));
		float num2 = Mathf.Cos(degrees * (MathF.PI / 180f));
		float x = vector.x;
		float y = vector.y;
		vector.x = num2 * x - num * y;
		vector.y = num * x + num2 * y;
		return vector;
	}

	public static bool SameSign(this float a, float b)
	{
		return a < 0f == b < 0f;
	}

	public static byte RoundToByte(float value)
	{
		return (byte)Mathf.Clamp(Mathf.RoundToInt(value), 0, 255);
	}

	public static ushort RoundToUShort(float value)
	{
		return (ushort)Mathf.Clamp(Mathf.RoundToInt(value), 0, 65535);
	}

	public static short RoundToShort(float value)
	{
		return (short)Mathf.Clamp(Mathf.RoundToInt(value), -32768, 32767);
	}

	public static bool TryGetClosestLineSegment(Vector3 start, Vector3 end, Vector3 point, float minLength, float maxLength, out Vector3 newStart, out Vector3 newEnd, out Vector3 closestPointOnLine, out Vector3 normalizedDir)
	{
		Vector3 vector = end - start;
		float magnitude = vector.magnitude;
		if (magnitude < minLength)
		{
			newStart = start;
			newEnd = end;
			normalizedDir = Vector3.zero;
			closestPointOnLine = point;
			return false;
		}
		normalizedDir = vector / magnitude;
		float num = Mathf.Clamp(Vector3.Dot(normalizedDir, end - point), 0f, magnitude);
		float num2 = magnitude - num;
		Vector3 vector2 = start + num2 * normalizedDir;
		float num3 = Mathf.Min(magnitude, maxLength) / 2f;
		float num4 = Mathf.Max(num3 - num2, 0f);
		float num5 = Mathf.Max(num3 - num, 0f);
		newStart = vector2 - normalizedDir * (num3 - num4 + num5);
		newEnd = vector2 + normalizedDir * (num3 + num4 - num5);
		closestPointOnLine = vector2;
		return true;
	}

	public static void GetClosestPointOnLine(Vector3 start, Vector3 end, Vector3 point, out Vector3 closestPointOnLine, out Vector3 normalizedDir)
	{
		Vector3 vector = end - start;
		float magnitude = vector.magnitude;
		if (Mathf.Approximately(magnitude, 0f))
		{
			closestPointOnLine = start;
			normalizedDir = Vector3.zero;
			return;
		}
		normalizedDir = vector / magnitude;
		float num = Vector3.Dot(normalizedDir, point - start);
		if (num <= 0f)
		{
			closestPointOnLine = start;
			return;
		}
		if (num >= magnitude)
		{
			closestPointOnLine = end;
			return;
		}
		Vector3 vector2 = normalizedDir * num;
		closestPointOnLine = start + vector2;
	}

	public static bool TryCommandModeFromArgs(ref string[] newargs, out CommandOperationMode mode)
	{
		if (newargs != null && newargs.Length != 0)
		{
			switch (newargs[0].ToLowerInvariant())
			{
			case "1":
			case "true":
			case "enable":
			case "on":
				mode = CommandOperationMode.Enable;
				return true;
			case "0":
			case "false":
			case "disable":
			case "off":
				mode = CommandOperationMode.Disable;
				return true;
			default:
				mode = CommandOperationMode.Toggle;
				return false;
			}
		}
		mode = CommandOperationMode.Toggle;
		return true;
	}

	public static bool TryGetComponentInParent<T>(this Transform startTransform, out T comp)
	{
		int depth;
		return startTransform.TryGetComponentInParent<T>(out comp, out depth);
	}

	public static bool TryGetComponentInParent<T>(this Transform startTransform, out T comp, out int depth)
	{
		depth = 0;
		while (startTransform != null)
		{
			if (startTransform.TryGetComponent<T>(out comp))
			{
				return true;
			}
			depth++;
			startTransform = startTransform.parent;
		}
		comp = default;
		return false;
	}

	public static void ForEachComponentInChildren<T>(this GameObject root, Action<T> action, bool includeInactive)
	{
		List<T> list = ListPool<T>.Shared.Rent();
		root.GetComponentsInChildren(includeInactive, list);
		list.ForEach(action);
		ListPool<T>.Shared.Return(list);
	}

	public static void ResetLocalPosition(this Transform tr)
	{
		tr.localPosition = Vector3.zero;
	}

	public static void ResetLocalRotation(this Transform tr)
	{
		tr.localRotation = Quaternion.identity;
	}

	public static void ResetLocalScale(this Transform tr)
	{
		tr.localScale = Vector3.one;
	}

	public static void ResetLocalPose(this Transform tr)
	{
		tr.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
	}

	public static void ResetTransform(this Transform tr)
	{
		tr.ResetLocalPose();
		tr.ResetLocalScale();
	}

	public static string GetHierarchyPath(this Transform tr)
	{
		List<Transform> list = ListPool<Transform>.Shared.Rent();
		Transform parent = tr.parent;
		while (parent != null)
		{
			list.Add(parent);
			parent = parent.parent;
		}
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
		for (int num = list.Count - 1; num >= 0; num--)
		{
			stringBuilder.Append(list[num].name);
			stringBuilder.Append("/");
		}
		stringBuilder.Append(tr.name);
		ListPool<Transform>.Shared.Return(list);
		return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
	}

	public static float GetDuration(this AnimationCurve curve)
	{
		return curve[curve.length - 1].time;
	}

	public static string RemoveStacktraceZeroes(string stacktrace)
	{
		return stacktrace.Replace(" [0x00000] in <00000000000000000000000000000000>:0", "");
	}

	public static void DirectoryCopy(string sourceDirName, string destDirName, bool copySubDirs = true)
	{
		DirectoryInfo directoryInfo = new DirectoryInfo(sourceDirName);
		if (!directoryInfo.Exists)
		{
			throw new DirectoryNotFoundException("Source directory does not exist or could not be found: " + sourceDirName);
		}
		DirectoryInfo[] directories = directoryInfo.GetDirectories();
		if (Directory.Exists(destDirName))
		{
			Directory.Delete(destDirName, recursive: true);
		}
		Directory.CreateDirectory(destDirName);
		FileInfo[] files = directoryInfo.GetFiles();
		foreach (FileInfo fileInfo in files)
		{
			string destFileName = Path.Combine(destDirName, fileInfo.Name);
			fileInfo.CopyTo(destFileName, overwrite: true);
		}
		if (copySubDirs)
		{
			DirectoryInfo[] array = directories;
			foreach (DirectoryInfo directoryInfo2 in array)
			{
				string destDirName2 = Path.Combine(destDirName, directoryInfo2.Name);
				DirectoryCopy(directoryInfo2.FullName, destDirName2);
			}
		}
	}

	public static Color ConvertToGray(this Color oldColor)
	{
		float num = oldColor.r * 0.299f + oldColor.g * 0.587f + oldColor.b * 0.114f;
		return new Color(num, num, num, oldColor.a);
	}

	public static string FormatAvailable(string format, params object[] args)
	{
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
		stringBuilder.Append(format);
		int num = 0;
		foreach (Match item in FormatBracketRegex.Matches(format))
		{
			if (num <= args.Length - 1)
			{
				stringBuilder.Replace(item.Value, args[num].ToString());
			}
			num++;
		}
		return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
	}
}

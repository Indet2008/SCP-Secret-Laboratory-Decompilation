using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using Cassie.Interpreters;
using UnityEngine;

namespace Cassie
{
	public class NumberInterpreter : CassieInterpreter
	{
		private static readonly string[] Digits = new string[10] { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };

		private static readonly string[] Teens = new string[9] { "11", "12", "13", "14", "15", "16", "17", "18", "19" };

		private static readonly string[] Tens = new string[10] { null, "10", "20", "30", "40", "50", "60", "70", "80", "90" };

		private static readonly string[] Scales = new string[5] { "HUNDRED", "THOUSAND", "MILLION", "BILLION", "TRILLION" };

		private static readonly string Negative = "NEGATIVE";

		private static readonly string Point = "POINT";

		private const double MaxPronouncableNumber = 999999999999.999;

		private static int[] _digitsPerScale;

		private static CassieLineDatabase _adderDatabase;

		private static CassiePlaybackModifiers _adderModifiers;

		private static List<Result> _adderList;

		protected override NextAction ProcessWord(ReadOnlySpan<char> word, CassieLineDatabase database, ref CassiePlaybackModifiers modifiers, StringBuilder subtitleBuilder, List<Result> lines)
		{
			if (!double.TryParse(word, NumberStyles.Integer | NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture, out var result))
			{
				return NextAction.Continue;
			}
			subtitleBuilder?.Append(word);
			subtitleBuilder?.Append(' ');
			_adderDatabase = database;
			_adderList = lines;
			_adderModifiers = modifiers;
			if (result < 0.0)
			{
				AddLine(Negative);
				result = 0.0 - result;
			}
			bool flag = result > 999999999999.999;
			if (!flag)
			{
				HandleNaturalNumber((long)result);
			}
			bool flag2 = false;
			for (int i = 0; i < word.Length; i++)
			{
				char c = word[i];
				if (c == '.')
				{
					flag2 = true;
					AddLine(Point);
				}
				else if ((flag2 || flag) && c >= '0' && c <= '9')
				{
					AddLine(word.Slice(i, 1));
				}
			}
			modifiers.ResetSingleUseModifiers();
			return NextAction.Halt;
		}

		private static void HandleNaturalNumber(long num)
		{
			if (num == 0L)
			{
				AddLine(Digits[0]);
				return;
			}
			if (_digitsPerScale == null)
			{
				_digitsPerScale = new int[Scales.Length];
			}
			Array.Clear(_digitsPerScale, 0, _digitsPerScale.Length);
			int num2 = 0;
			while (num > 0 && num2 < _digitsPerScale.Length)
			{
				_digitsPerScale[num2++] = (int)(num % 1000);
				num /= 1000;
			}
			for (int num3 = num2 - 1; num3 >= 0; num3--)
			{
				int num4 = _digitsPerScale[num3];
				if (num4 != 0)
				{
					AddUnder1000(num4);
					if (num3 > 0)
					{
						AddLine(Scales[num3]);
					}
				}
			}
		}

		private static void AddUnder1000(int n)
		{
			int num = n / 100;
			int num2 = n % 100;
			if (num > 0)
			{
				AddLine(Digits[num]);
				AddLine(Scales[0]);
			}
			switch (num2)
			{
			case 0:
				return;
			case 11:
			case 12:
			case 13:
			case 14:
			case 15:
			case 16:
			case 17:
			case 18:
			case 19:
				AddLine(Teens[num2 - 11]);
				return;
			}
			if (num2 == 10 || num2 >= 20)
			{
				int num3 = num2 / 10;
				AddLine(Tens[num3]);
				int num4 = num2 % 10;
				if (num4 != 0)
				{
					AddLine(Digits[num4]);
				}
			}
			else
			{
				AddLine(Digits[num2]);
			}
		}

		private static void AddLine(string word)
		{
			AddLine(word.AsSpan());
		}

		private static void AddLine(ReadOnlySpan<char> word)
		{
			if (!_adderDatabase.TryGetLine(word, out var line))
			{
				Debug.LogError("Unable to parse " + word.ToString() + " as a CASSIE line.");
			}
			else
			{
				_adderList.Add(new Result(line, _adderModifiers));
			}
		}
	}
}

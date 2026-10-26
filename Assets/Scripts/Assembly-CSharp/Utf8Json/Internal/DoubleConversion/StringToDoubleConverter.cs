using System;
using System.Text;

namespace Utf8Json.Internal.DoubleConversion
{
	internal static class StringToDoubleConverter
	{
		private enum Flags
		{
			NO_FLAGS = 0,
			ALLOW_HEX = 1,
			ALLOW_OCTALS = 2,
			ALLOW_TRAILING_JUNK = 4,
			ALLOW_LEADING_SPACES = 8,
			ALLOW_TRAILING_SPACES = 0x10,
			ALLOW_SPACES_AFTER_SIGN = 0x20,
			ALLOW_CASE_INSENSIBILITY = 0x40
		}

		[ThreadStatic]
		private static byte[] kBuffer;

		[ThreadStatic]
		private static byte[] fallbackBuffer;

		private const Flags flags_ = (Flags)52;

		private const double empty_string_value_ = 0.0;

		private const double junk_string_value_ = double.NaN;

		private const int kMaxSignificantDigits = 772;

		private const int kBufferSize = 782;

		private static readonly byte[] infinity_symbol_ = StringEncoding.UTF8.GetBytes(double.PositiveInfinity.ToString());

		private static readonly byte[] nan_symbol_ = StringEncoding.UTF8.GetBytes(double.NaN.ToString());

		private static readonly byte[] kWhitespaceTable7 = new byte[6] { 32, 13, 10, 9, 11, 12 };

		private static readonly int kWhitespaceTable7Length = kWhitespaceTable7.Length;

		private static readonly ushort[] kWhitespaceTable16 = new ushort[20]
		{
			160, 8232, 8233, 5760, 6158, 8192, 8193, 8194, 8195, 8196,
			8197, 8198, 8199, 8200, 8201, 8202, 8239, 8287, 12288, 65279
		};

		private static readonly int kWhitespaceTable16Length = kWhitespaceTable16.Length;

		private static byte[] GetBuffer()
		{
			if (kBuffer == null)
			{
				kBuffer = new byte[782];
			}
			return kBuffer;
		}

		private static byte[] GetFallbackBuffer()
		{
			if (fallbackBuffer == null)
			{
				fallbackBuffer = new byte[99];
			}
			return fallbackBuffer;
		}

		public static double ToDouble(byte[] buffer, int offset, out int readCount)
		{
			return StringToIeee(new Iterator(buffer, offset), buffer.Length - offset, read_as_double: true, out readCount);
		}

		public static float ToSingle(byte[] buffer, int offset, out int readCount)
		{
			return (float)StringToIeee(new Iterator(buffer, offset), buffer.Length - offset, read_as_double: false, out readCount);
		}

		private static bool isWhitespace(int x)
		{
			if (x < 128)
			{
				for (int i = 0; i < kWhitespaceTable7Length; i++)
				{
					if (kWhitespaceTable7[i] == x)
					{
						return true;
					}
				}
			}
			else
			{
				for (int j = 0; j < kWhitespaceTable16Length; j++)
				{
					if (kWhitespaceTable16[j] == x)
					{
						return true;
					}
				}
			}
			return false;
		}

		private static bool AdvanceToNonspace(ref Iterator current, Iterator end)
		{
			while (current != end)
			{
				if (!isWhitespace(current.Value))
				{
					return true;
				}
				++current;
			}
			return false;
		}

		private static bool ConsumeSubString(ref Iterator current, Iterator end, byte[] substring)
		{
			for (int i = 1; i < substring.Length; i++)
			{
				++current;
				if (current == end || current != substring[i])
				{
					return false;
				}
			}
			++current;
			return true;
		}

		private static bool ConsumeFirstCharacter(ref Iterator iter, byte[] str, int offset)
		{
			return iter.Value == str[offset];
		}

		private static double SignedZero(bool sign)
		{
			if (!sign)
			{
				return 0.0;
			}
			return -0.0;
		}

		private static double StringToIeee(Iterator input, int length, bool read_as_double, out int processed_characters_count)
		{
			Iterator current = input;
			Iterator iterator = input + length;
			processed_characters_count = 0;
			bool flag = true;
			bool flag2 = false;
			bool flag3 = true;
			bool flag4 = true;
			if (length == 0)
			{
				return 0.0;
			}
			if (flag2 | flag3)
			{
				if (!AdvanceToNonspace(ref current, iterator))
				{
					processed_characters_count = current - input;
					return 0.0;
				}
				if (!flag2 && input != current)
				{
					return double.NaN;
				}
			}
			byte[] buffer = GetBuffer();
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			int num4 = 0;
			bool flag5 = false;
			bool flag6 = false;
			if (current == '+' || current == '-')
			{
				flag6 = current == '-';
				++current;
				Iterator current2 = current;
				if (!AdvanceToNonspace(ref current2, iterator))
				{
					return double.NaN;
				}
				if (!flag4 && current != current2)
				{
					return double.NaN;
				}
				current = current2;
			}
			if (infinity_symbol_ != null && ConsumeFirstCharacter(ref current, infinity_symbol_, 0))
			{
				if (!ConsumeSubString(ref current, iterator, infinity_symbol_))
				{
					return double.NaN;
				}
				if (!(flag3 | flag) && current != iterator)
				{
					return double.NaN;
				}
				if (!flag && AdvanceToNonspace(ref current, iterator))
				{
					return double.NaN;
				}
				processed_characters_count = current - input;
				if (!flag6)
				{
					return double.PositiveInfinity;
				}
				return double.NegativeInfinity;
			}
			if (nan_symbol_ != null && ConsumeFirstCharacter(ref current, nan_symbol_, 0))
			{
				if (!ConsumeSubString(ref current, iterator, nan_symbol_))
				{
					return double.NaN;
				}
				if (!(flag3 | flag) && current != iterator)
				{
					return double.NaN;
				}
				if (!flag && AdvanceToNonspace(ref current, iterator))
				{
					return double.NaN;
				}
				processed_characters_count = current - input;
				if (!flag6)
				{
					return double.NaN;
				}
				return double.NaN;
			}
			bool flag7 = false;
			if (current == '0')
			{
				++current;
				if (current == iterator)
				{
					processed_characters_count = current - input;
					return SignedZero(flag6);
				}
				flag7 = true;
				while (current == '0')
				{
					++current;
					if (current == iterator)
					{
						processed_characters_count = current - input;
						return SignedZero(flag6);
					}
				}
			}
			bool flag8 = !flag7 && false;
			do
			{
				if (current >= '0' && current <= '9')
				{
					if (num3 < 772)
					{
						buffer[num++] = current.Value;
						num3++;
					}
					else
					{
						num4++;
						flag5 = flag5 || current != '0';
					}
					++current;
					continue;
				}
				if (num3 == 0)
				{
					flag8 = false;
				}
				if (current == '.')
				{
					if (flag8 && !flag)
					{
						return double.NaN;
					}
					if (flag8)
					{
						break;
					}
					++current;
					if (current == iterator)
					{
						if (num3 != 0 || flag7)
						{
							break;
						}
						return double.NaN;
					}
					if (num3 == 0)
					{
						while (current == '0')
						{
							++current;
							if (current == iterator)
							{
								processed_characters_count = current - input;
								return SignedZero(flag6);
							}
							num2--;
						}
					}
					while (current >= '0' && current <= '9')
					{
						if (num3 < 772)
						{
							buffer[num++] = current.Value;
							num3++;
							num2--;
						}
						else
						{
							flag5 = flag5 || current != '0';
						}
						++current;
						if (current == iterator)
						{
							goto end_IL_0283;
						}
					}
				}
				if (!flag7 && num2 == 0 && num3 == 0)
				{
					return double.NaN;
				}
				if (current == 'e' || current == 'E')
				{
					if (flag8 && !flag)
					{
						return double.NaN;
					}
					if (flag8)
					{
						break;
					}
					++current;
					if (current == iterator)
					{
						if (flag)
						{
							break;
						}
						return double.NaN;
					}
					byte b = 43;
					if (current == '+' || current == '-')
					{
						b = current.Value;
						++current;
						if (current == iterator)
						{
							if (flag)
							{
								break;
							}
							return double.NaN;
						}
					}
					if (current == iterator || current < '0' || current > '9')
					{
						if (flag)
						{
							break;
						}
						return double.NaN;
					}
					int num5 = 0;
					do
					{
						int num6 = current.Value - 48;
						num5 = ((num5 < 107374182 || (num5 == 107374182 && num6 <= 3)) ? (num5 * 10 + num6) : 1073741823);
						++current;
					}
					while (current != iterator && current >= '0' && current <= '9');
					num2 += ((b == 45) ? (-num5) : num5);
				}
				if (!(flag3 | flag) && current != iterator)
				{
					return double.NaN;
				}
				if (!flag && AdvanceToNonspace(ref current, iterator))
				{
					return double.NaN;
				}
				if (flag3)
				{
					AdvanceToNonspace(ref current, iterator);
				}
				break;
				continue;
				end_IL_0283:
				break;
			}
			while (!(current == iterator));
			num2 += num4;
			if (flag5)
			{
				buffer[num++] = 49;
				num2--;
			}
			buffer[num] = 0;
			double? num7 = ((!read_as_double) ? ((double?)StringToDouble.Strtof(new Vector(buffer, 0, num), num2)) : StringToDouble.Strtod(new Vector(buffer, 0, num), num2));
			if (!num7.HasValue)
			{
				processed_characters_count = current - input;
				byte[] array = GetFallbackBuffer();
				BinaryUtil.EnsureCapacity(ref fallbackBuffer, 0, processed_characters_count);
				int count = 0;
				while (input != current)
				{
					array[count++] = input.Value;
					++input;
				}
				return double.Parse(Encoding.UTF8.GetString(array, 0, count));
			}
			processed_characters_count = current - input;
			if (!flag6)
			{
				return num7.Value;
			}
			return 0.0 - num7.Value;
		}
	}
}

using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class ISO8601DateTimeOffsetFormatter : IJsonFormatter<DateTimeOffset>, IJsonFormatter
	{
		public static readonly IJsonFormatter<DateTimeOffset> Default = new ISO8601DateTimeOffsetFormatter();

		public void Serialize(ref JsonWriter writer, DateTimeOffset value, IJsonFormatterResolver formatterResolver)
		{
			int year = value.Year;
			int month = value.Month;
			int day = value.Day;
			int hour = value.Hour;
			int minute = value.Minute;
			int second = value.Second;
			long num = value.Ticks % 10000000;
			writer.EnsureCapacity(21 + ((num != 0L) ? 8 : 0) + 6);
			writer.WriteRawUnsafe(34);
			if (year < 10)
			{
				writer.WriteRawUnsafe(48);
				writer.WriteRawUnsafe(48);
				writer.WriteRawUnsafe(48);
			}
			else if (year < 100)
			{
				writer.WriteRawUnsafe(48);
				writer.WriteRawUnsafe(48);
			}
			else if (year < 1000)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(year);
			writer.WriteRawUnsafe(45);
			if (month < 10)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(month);
			writer.WriteRawUnsafe(45);
			if (day < 10)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(day);
			writer.WriteRawUnsafe(84);
			if (hour < 10)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(hour);
			writer.WriteRawUnsafe(58);
			if (minute < 10)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(minute);
			writer.WriteRawUnsafe(58);
			if (second < 10)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(second);
			if (num != 0L)
			{
				writer.WriteRawUnsafe(46);
				if (num < 10)
				{
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
				}
				else if (num < 100)
				{
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
				}
				else if (num < 1000)
				{
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
				}
				else if (num < 10000)
				{
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
				}
				else if (num < 100000)
				{
					writer.WriteRawUnsafe(48);
					writer.WriteRawUnsafe(48);
				}
				else if (num < 1000000)
				{
					writer.WriteRawUnsafe(48);
				}
				writer.WriteInt64(num);
			}
			TimeSpan timeSpan = value.Offset;
			bool flag = timeSpan < TimeSpan.Zero;
			if (flag)
			{
				timeSpan = timeSpan.Negate();
			}
			int hours = timeSpan.Hours;
			int minutes = timeSpan.Minutes;
			writer.WriteRawUnsafe((byte)(flag ? 45 : 43));
			if (hours < 10)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(hours);
			writer.WriteRawUnsafe(58);
			if (minutes < 10)
			{
				writer.WriteRawUnsafe(48);
			}
			writer.WriteInt32(minutes);
			writer.WriteRawUnsafe(34);
		}

		public DateTimeOffset Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentUnsafe();
			byte[] array = arraySegment.Array;
			int i = arraySegment.Offset;
			int count = arraySegment.Count;
			int num = arraySegment.Offset + arraySegment.Count;
			switch (count)
			{
			case 4:
				return new DateTimeOffset((array[i++] - 48) * 1000 + (array[i++] - 48) * 100 + (array[i++] - 48) * 10 + (array[i++] - 48), 1, 1, 0, 0, 0, TimeSpan.Zero);
			case 7:
			{
				int year3 = (array[i++] - 48) * 1000 + (array[i++] - 48) * 100 + (array[i++] - 48) * 10 + (array[i++] - 48);
				if (array[i++] == 45)
				{
					int month3 = (array[i++] - 48) * 10 + (array[i++] - 48);
					return new DateTimeOffset(year3, month3, 1, 0, 0, 0, TimeSpan.Zero);
				}
				break;
			}
			case 10:
			{
				int year2 = (array[i++] - 48) * 1000 + (array[i++] - 48) * 100 + (array[i++] - 48) * 10 + (array[i++] - 48);
				if (array[i++] == 45)
				{
					int month2 = (array[i++] - 48) * 10 + (array[i++] - 48);
					if (array[i++] == 45)
					{
						int day2 = (array[i++] - 48) * 10 + (array[i++] - 48);
						return new DateTimeOffset(year2, month2, day2, 0, 0, 0, TimeSpan.Zero);
					}
				}
				break;
			}
			default:
			{
				if (array.Length < 19)
				{
					break;
				}
				int year = (array[i++] - 48) * 1000 + (array[i++] - 48) * 100 + (array[i++] - 48) * 10 + (array[i++] - 48);
				if (array[i++] != 45)
				{
					break;
				}
				int month = (array[i++] - 48) * 10 + (array[i++] - 48);
				if (array[i++] != 45)
				{
					break;
				}
				int day = (array[i++] - 48) * 10 + (array[i++] - 48);
				if (array[i++] != 84)
				{
					break;
				}
				int hour = (array[i++] - 48) * 10 + (array[i++] - 48);
				if (array[i++] != 58)
				{
					break;
				}
				int minute = (array[i++] - 48) * 10 + (array[i++] - 48);
				if (array[i++] != 58)
				{
					break;
				}
				int second = (array[i++] - 48) * 10 + (array[i++] - 48);
				int num2 = 0;
				if (i < num && array[i] == 46)
				{
					i++;
					if (i < num && NumberConverter.IsNumber(array[i]))
					{
						num2 += (array[i] - 48) * 1000000;
						i++;
						if (i < num && NumberConverter.IsNumber(array[i]))
						{
							num2 += (array[i] - 48) * 100000;
							i++;
							if (i < num && NumberConverter.IsNumber(array[i]))
							{
								num2 += (array[i] - 48) * 10000;
								i++;
								if (i < num && NumberConverter.IsNumber(array[i]))
								{
									num2 += (array[i] - 48) * 1000;
									i++;
									if (i < num && NumberConverter.IsNumber(array[i]))
									{
										num2 += (array[i] - 48) * 100;
										i++;
										if (i < num && NumberConverter.IsNumber(array[i]))
										{
											num2 += (array[i] - 48) * 10;
											i++;
											if (i < num && NumberConverter.IsNumber(array[i]))
											{
												num2 += array[i] - 48;
												for (i++; i < num && NumberConverter.IsNumber(array[i]); i++)
												{
												}
											}
										}
									}
								}
							}
						}
					}
				}
				if ((i < num && array[i] == 45) || array[i] == 43)
				{
					if (i + 5 < num)
					{
						bool num3 = array[i++] == 45;
						int hours = (array[i++] - 48) * 10 + (array[i++] - 48);
						i++;
						int minutes = (array[i++] - 48) * 10 + (array[i++] - 48);
						TimeSpan offset = new TimeSpan(hours, minutes, 0);
						if (num3)
						{
							offset = offset.Negate();
						}
						return new DateTimeOffset(year, month, day, hour, minute, second, offset).AddTicks(num2);
					}
					break;
				}
				return new DateTimeOffset(year, month, day, hour, minute, second, TimeSpan.Zero).AddTicks(num2);
			}
			}
			throw new InvalidOperationException("invalid datetime format. value:" + StringEncoding.UTF8.GetString(arraySegment.Array, arraySegment.Offset, arraySegment.Count));
		}
	}
}

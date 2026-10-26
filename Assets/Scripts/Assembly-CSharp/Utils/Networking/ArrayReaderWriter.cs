using System.Collections.Generic;
using Mirror;

namespace Utils.Networking
{
	public static class ArrayReaderWriter<TItem>
	{
		public delegate TItem ReadItem(NetworkReader reader);

		public delegate void WriteItem(NetworkWriter writer, TItem item);

		public static TItem[] ReadArray(NetworkReader reader, ReadItem itemReader)
		{
			int num = reader.ReadInt();
			if (num < 0)
			{
				return null;
			}
			TItem[] array = new TItem[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = itemReader(reader);
			}
			return array;
		}

		public static void WriteArray(NetworkWriter writer, IReadOnlyCollection<TItem> array, WriteItem itemWriter)
		{
			if (array != null)
			{
				writer.WriteInt(array.Count);
				{
					foreach (TItem item in array)
					{
						itemWriter(writer, item);
					}
					return;
				}
			}
			writer.WriteInt(-1);
		}
	}
}

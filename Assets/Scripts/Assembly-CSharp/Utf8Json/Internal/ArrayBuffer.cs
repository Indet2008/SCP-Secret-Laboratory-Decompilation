using System;

namespace Utf8Json.Internal
{
	public struct ArrayBuffer<T>
	{
		public T[] Buffer;

		public int Size;

		public ArrayBuffer(int initialSize)
		{
			Buffer = new T[initialSize];
			Size = 0;
		}

		public void Add(T value)
		{
			if (Size >= Buffer.Length)
			{
				Array.Resize(ref Buffer, Size * 2);
			}
			Buffer[Size++] = value;
		}

		public T[] ToArray()
		{
			if (Buffer.Length == Size)
			{
				return Buffer;
			}
			T[] array = new T[Size];
			Array.Copy(Buffer, array, Size);
			return array;
		}
	}
}

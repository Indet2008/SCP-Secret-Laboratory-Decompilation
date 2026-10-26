using System;

namespace Utf8Json.Internal
{
	internal class ArrayPool<T>
	{
		private readonly int bufferLength;

		private readonly object gate;

		private int index;

		private T[][] buffers;

		public ArrayPool(int bufferLength)
		{
			this.bufferLength = bufferLength;
			buffers = new T[4][];
			gate = new object();
		}

		public T[] Rent()
		{
			lock (gate)
			{
				if (index >= buffers.Length)
				{
					Array.Resize(ref buffers, buffers.Length * 2);
				}
				if (buffers[index] == null)
				{
					buffers[index] = new T[bufferLength];
				}
				T[] result = buffers[index];
				buffers[index] = null;
				index++;
				return result;
			}
		}

		public void Return(T[] array)
		{
			if (array.Length != bufferLength)
			{
				throw new InvalidOperationException("return buffer is not from pool");
			}
			lock (gate)
			{
				if (index != 0)
				{
					buffers[--index] = array;
				}
			}
		}
	}
}

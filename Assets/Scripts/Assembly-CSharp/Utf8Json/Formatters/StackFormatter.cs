using System.Collections.Generic;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class StackFormatter<T> : CollectionFormatterBase<T, ArrayBuffer<T>, Stack<T>.Enumerator, Stack<T>>
	{
		protected override void Add(ref ArrayBuffer<T> collection, int index, T value)
		{
			collection.Add(value);
		}

		protected override ArrayBuffer<T> Create()
		{
			return new ArrayBuffer<T>(4);
		}

		protected override Stack<T>.Enumerator GetSourceEnumerator(Stack<T> source)
		{
			return source.GetEnumerator();
		}

		protected override Stack<T> Complete(ref ArrayBuffer<T> intermediateCollection)
		{
			T[] buffer = intermediateCollection.Buffer;
			Stack<T> stack = new Stack<T>(intermediateCollection.Size);
			for (int num = intermediateCollection.Size - 1; num >= 0; num--)
			{
				stack.Push(buffer[num]);
			}
			return stack;
		}
	}
}

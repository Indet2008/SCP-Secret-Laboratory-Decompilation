namespace Mirror
{
	public class ConcurrentPool<T>
	{
		private readonly global::System.Collections.Concurrent.ConcurrentBag<T> objects = new global::System.Collections.Concurrent.ConcurrentBag<T>();

		private readonly global::System.Func<T> objectGenerator;

		public int Count => objects.Count;

		public ConcurrentPool(global::System.Func<T> objectGenerator, int initialCapacity)
		{
			this.objectGenerator = objectGenerator;
			for (int i = 0; i < initialCapacity; i++)
			{
				objects.Add(objectGenerator());
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public T Get()
		{
			if (!objects.TryTake(out var result))
			{
				return objectGenerator();
			}
			return result;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void Return(T item)
		{
			objects.Add(item);
		}
	}
}

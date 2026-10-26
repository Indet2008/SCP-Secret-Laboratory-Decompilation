namespace Mirror
{
	public class Pool<T>
	{
		private readonly global::System.Collections.Generic.Stack<T> objects = new global::System.Collections.Generic.Stack<T>();

		private readonly global::System.Func<T> objectGenerator;

		public int Count => objects.Count;

		public Pool(global::System.Func<T> objectGenerator, int initialCapacity)
		{
			this.objectGenerator = objectGenerator;
			for (int i = 0; i < initialCapacity; i++)
			{
				objects.Push(objectGenerator());
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public T Get()
		{
			if (objects.Count <= 0)
			{
				return objectGenerator();
			}
			return objects.Pop();
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void Return(T item)
		{
			objects.Push(item);
		}
	}
}

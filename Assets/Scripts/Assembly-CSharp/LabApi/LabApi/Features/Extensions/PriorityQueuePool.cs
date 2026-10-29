namespace LabApi.Features.Extensions
{
	public sealed class PriorityQueuePool<T> : global::NorthwoodLib.Pools.IPool<global::LabApi.Features.Extensions.PriorityQueue<T>>
	{
		public static readonly global::LabApi.Features.Extensions.PriorityQueuePool<T> Shared = new global::LabApi.Features.Extensions.PriorityQueuePool<T>();

		private readonly global::System.Collections.Concurrent.ConcurrentQueue<global::LabApi.Features.Extensions.PriorityQueue<T>> _pool = new global::System.Collections.Concurrent.ConcurrentQueue<global::LabApi.Features.Extensions.PriorityQueue<T>>();

		public global::LabApi.Features.Extensions.PriorityQueue<T> Rent()
		{
			if (!_pool.TryDequeue(out global::LabApi.Features.Extensions.PriorityQueue<T> result))
			{
				return new global::LabApi.Features.Extensions.PriorityQueue<T>();
			}
			return result;
		}

		public void Return(global::LabApi.Features.Extensions.PriorityQueue<T> queue)
		{
			queue.Clear();
			_pool.Enqueue(queue);
		}
	}
}

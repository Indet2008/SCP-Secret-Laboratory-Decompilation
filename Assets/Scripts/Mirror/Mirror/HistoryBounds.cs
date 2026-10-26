namespace Mirror
{
	public class HistoryBounds
	{
		private readonly int boundsPerBucket;

		private readonly global::System.Collections.Generic.Queue<global::Mirror.MinMaxBounds> fullBuckets;

		private readonly int bucketLimit;

		private global::Mirror.MinMaxBounds? currentBucket;

		private int currentBucketSize;

		private global::Mirror.MinMaxBounds totalMinMax;

		public int boundsCount { get; private set; }

		public global::UnityEngine.Bounds total
		{
			get
			{
				global::UnityEngine.Bounds result = default;
				result.SetMinMax(totalMinMax.min, totalMinMax.max);
				return result;
			}
		}

		public HistoryBounds(int boundsLimit, int boundsPerBucket)
		{
			this.boundsPerBucket = boundsPerBucket;
			bucketLimit = boundsLimit / boundsPerBucket;
			fullBuckets = new global::System.Collections.Generic.Queue<global::Mirror.MinMaxBounds>(bucketLimit + 1);
		}

		public void Insert(global::UnityEngine.Bounds bounds)
		{
			global::Mirror.MinMaxBounds minMaxBounds = new global::Mirror.MinMaxBounds
			{
				min = bounds.min,
				max = bounds.max
			};
			if (boundsCount == 0)
			{
				totalMinMax = minMaxBounds;
			}
			if (!currentBucket.HasValue)
			{
				currentBucket = minMaxBounds;
			}
			else
			{
				currentBucket.Value.Encapsulate(minMaxBounds);
			}
			currentBucketSize++;
			boundsCount++;
			totalMinMax.Encapsulate(minMaxBounds);
			if (currentBucketSize != boundsPerBucket)
			{
				return;
			}
			fullBuckets.Enqueue(currentBucket.Value);
			currentBucket = null;
			currentBucketSize = 0;
			if (fullBuckets.Count <= bucketLimit)
			{
				return;
			}
			fullBuckets.Dequeue();
			boundsCount -= boundsPerBucket;
			totalMinMax = minMaxBounds;
			foreach (global::Mirror.MinMaxBounds fullBucket in fullBuckets)
			{
				totalMinMax.Encapsulate(fullBucket);
			}
		}

		public void Reset()
		{
			fullBuckets.Clear();
			currentBucket = null;
			currentBucketSize = 0;
			boundsCount = 0;
			totalMinMax = default;
		}
	}
}

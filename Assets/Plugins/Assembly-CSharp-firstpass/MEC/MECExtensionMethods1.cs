using System.Collections.Generic;
using UnityEngine;

namespace MEC
{
	public static class MECExtensionMethods1
	{
		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine)
		{
			return Timing.RunCoroutine(coroutine);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, GameObject gameObj)
		{
			return Timing.RunCoroutine(coroutine, gameObj);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, int layer)
		{
			return Timing.RunCoroutine(coroutine, layer);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, string tag)
		{
			return Timing.RunCoroutine(coroutine, tag);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, GameObject gameObj, string tag)
		{
			return Timing.RunCoroutine(coroutine, gameObj, tag);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, int layer, string tag)
		{
			return Timing.RunCoroutine(coroutine, layer, tag);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, Segment segment)
		{
			return Timing.RunCoroutine(coroutine, segment);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, Segment segment, GameObject gameObj)
		{
			return Timing.RunCoroutine(coroutine, segment, gameObj);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, Segment segment, int layer)
		{
			return Timing.RunCoroutine(coroutine, segment, layer);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, Segment segment, string tag)
		{
			return Timing.RunCoroutine(coroutine, segment, tag);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, Segment segment, GameObject gameObj, string tag)
		{
			return Timing.RunCoroutine(coroutine, segment, gameObj, tag);
		}

		public static CoroutineHandle RunCoroutine(this IEnumerator<float> coroutine, Segment segment, int layer, string tag)
		{
			return Timing.RunCoroutine(coroutine, segment, layer, tag);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, CoroutineHandle handle, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, handle, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, GameObject gameObj, SingletonBehavior behaviorOnCollision)
		{
			if (!(gameObj == null))
			{
				return Timing.RunCoroutineSingleton(coroutine, gameObj.GetInstanceID(), behaviorOnCollision);
			}
			return Timing.RunCoroutine(coroutine);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, int layer, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, layer, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, string tag, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, tag, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, GameObject gameObj, string tag, SingletonBehavior behaviorOnCollision)
		{
			if (!(gameObj == null))
			{
				return Timing.RunCoroutineSingleton(coroutine, gameObj.GetInstanceID(), tag, behaviorOnCollision);
			}
			return Timing.RunCoroutineSingleton(coroutine, tag, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, int layer, string tag, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, layer, tag, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, CoroutineHandle handle, Segment segment, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, handle, segment, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, Segment segment, GameObject gameObj, SingletonBehavior behaviorOnCollision)
		{
			if (!(gameObj == null))
			{
				return Timing.RunCoroutineSingleton(coroutine, segment, gameObj.GetInstanceID(), behaviorOnCollision);
			}
			return Timing.RunCoroutine(coroutine, segment);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, Segment segment, int layer, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, segment, layer, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, Segment segment, string tag, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, segment, tag, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, Segment segment, GameObject gameObj, string tag, SingletonBehavior behaviorOnCollision)
		{
			if (!(gameObj == null))
			{
				return Timing.RunCoroutineSingleton(coroutine, segment, gameObj.GetInstanceID(), tag, behaviorOnCollision);
			}
			return Timing.RunCoroutineSingleton(coroutine, segment, tag, behaviorOnCollision);
		}

		public static CoroutineHandle RunCoroutineSingleton(this IEnumerator<float> coroutine, Segment segment, int layer, string tag, SingletonBehavior behaviorOnCollision)
		{
			return Timing.RunCoroutineSingleton(coroutine, segment, layer, tag, behaviorOnCollision);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine)
		{
			return Timing.WaitUntilDone(newCoroutine);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine, string tag)
		{
			return Timing.WaitUntilDone(newCoroutine, tag);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine, int layer)
		{
			return Timing.WaitUntilDone(newCoroutine, layer);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine, int layer, string tag)
		{
			return Timing.WaitUntilDone(newCoroutine, layer, tag);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine, Segment segment)
		{
			return Timing.WaitUntilDone(newCoroutine, segment);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine, Segment segment, string tag)
		{
			return Timing.WaitUntilDone(newCoroutine, segment, tag);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine, Segment segment, int layer)
		{
			return Timing.WaitUntilDone(newCoroutine, segment, layer);
		}

		public static float WaitUntilDone(this IEnumerator<float> newCoroutine, Segment segment, int layer, string tag)
		{
			return Timing.WaitUntilDone(newCoroutine, segment, layer, tag);
		}
	}
}

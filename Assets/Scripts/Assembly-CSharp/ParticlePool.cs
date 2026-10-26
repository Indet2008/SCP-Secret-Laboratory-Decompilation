using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.VFX;

public static class ParticlePool
{
	private readonly struct PooledSystem<T> where T : Component
	{
		public readonly T System;

		public readonly Stopwatch LastUseTime;

		public double AgeSeconds => LastUseTime.Elapsed.TotalSeconds;

		public PooledSystem(T template)
		{
			System = UnityEngine.Object.Instantiate(template);
			LastUseTime = Stopwatch.StartNew();
		}
	}

	private static readonly Dictionary<VisualEffect, Queue<PooledSystem<VisualEffect>>> VfxPools = new Dictionary<VisualEffect, Queue<PooledSystem<VisualEffect>>>();

	private static readonly Dictionary<ParticleSystem, Queue<PooledSystem<ParticleSystem>>> PsPools = new Dictionary<ParticleSystem, Queue<PooledSystem<ParticleSystem>>>();

	public static VisualEffect GetFromPool(this VisualEffect template, float minAge = 0.1f)
	{
		return GetAny(template, VfxPools, (VisualEffect x) => x.aliveParticleCount > 0, minAge);
	}

	public static ParticleSystem GetFromPool(this ParticleSystem template, float minAge = 0.1f)
	{
		return GetAny(template, PsPools, (ParticleSystem x) => x.isPlaying, minAge);
	}

	private static T GetAny<T>(T template, Dictionary<T, Queue<PooledSystem<T>>> pool, Predicate<T> isBusy, float minElapsed) where T : Component
	{
		Queue<PooledSystem<T>> orAddNew = pool.GetOrAddNew(template);
		PooledSystem<T> result;
		while (orAddNew.TryPeek(out result))
		{
			if (result.System == null)
			{
				orAddNew.Dequeue();
				continue;
			}
			if (result.AgeSeconds < (double)minElapsed || isBusy(result.System))
			{
				break;
			}
			PooledSystem<T> item = orAddNew.Dequeue();
			item.LastUseTime.Restart();
			orAddNew.Enqueue(item);
			return item.System;
		}
		PooledSystem<T> item2 = new PooledSystem<T>(template);
		orAddNew.Enqueue(item2);
		return item2.System;
	}
}

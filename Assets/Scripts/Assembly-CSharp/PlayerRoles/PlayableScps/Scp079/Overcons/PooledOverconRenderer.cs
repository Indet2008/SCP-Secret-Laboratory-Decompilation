using System.Collections.Generic;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public abstract class PooledOverconRenderer : OverconRendererBase
	{
		[SerializeField]
		private OverconBase _template;

		private readonly Queue<OverconBase> _queue = new Queue<OverconBase>();

		private readonly HashSet<OverconBase> _spawned = new HashSet<OverconBase>();

		protected T GetFromPool<T>() where T : OverconBase
		{
			if (!_queue.TryDequeue(out var result))
			{
				result = Object.Instantiate(_template);
			}
			result.gameObject.SetActive(value: true);
			_spawned.Add(result);
			return result as T;
		}

		protected void ReturnToPool(OverconBase instance)
		{
			_spawned.Remove(instance);
			_queue.Enqueue(instance);
			instance.gameObject.SetActive(value: false);
		}

		protected void ReturnAll()
		{
			foreach (OverconBase item in _spawned)
			{
				if (!(item == null))
				{
					item.gameObject.SetActive(value: false);
					_queue.Enqueue(item);
				}
			}
			_spawned.Clear();
		}
	}
}

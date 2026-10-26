using System.Collections.Generic;
using UnityEngine;

namespace Decals
{
	public class DecalPool
	{
		private const int StartQueueCapacity = 5000;

		private readonly Queue<Decal> _spawned;

		private readonly Queue<Decal> _disabled;

		private readonly Decal _template;

		public readonly DecalPoolType Type;

		public int Instances => _spawned.Count;

		private Decal PrepareInstance(Decal inst)
		{
			if (inst == null)
			{
				inst = Object.Instantiate(_template);
			}
			else
			{
				inst.gameObject.SetActive(value: true);
			}
			return inst;
		}

		public Decal Get()
		{
			Decal decal = ((!_disabled.TryDequeue(out decal)) ? Object.Instantiate(_template) : PrepareInstance(decal));
			_spawned.Enqueue(decal);
			return decal;
		}

		public void DisableLast()
		{
			if (_spawned.TryDequeue(out var result) && !(result == null))
			{
				result.gameObject.SetActive(value: false);
				_disabled.Enqueue(result);
			}
		}

		public void SetLimit(int limit)
		{
			while (_spawned.Count > limit)
			{
				Decal decal = _spawned.Dequeue();
				if (!(decal == null))
				{
					decal.Detach();
					Object.Destroy(decal.gameObject);
				}
			}
		}

		public DecalPool(Decal template)
		{
			Type = template.DecalPoolType;
			_template = template;
			_spawned = new Queue<Decal>(5000);
			_disabled = new Queue<Decal>(5000);
		}
	}
}

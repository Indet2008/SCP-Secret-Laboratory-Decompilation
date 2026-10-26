using System;
using System.Collections.Generic;
using UnityEngine;

namespace NetworkManagerUtils.Dummies
{
	public static class DummyActionCollector
	{
		private class CachedActions
		{
			private readonly List<DummyAction> _actions;

			private readonly IRootDummyActionProvider[] _providers;

			private bool _everUpdated;

			public List<DummyAction> Actions
			{
				get
				{
					if (AnyDirty)
					{
						UpdateCache();
					}
					return _actions;
				}
			}

			public bool AnyDirty
			{
				get
				{
					if (!_everUpdated)
					{
						return true;
					}
					IRootDummyActionProvider[] providers = _providers;
					for (int i = 0; i < providers.Length; i++)
					{
						if (providers[i].DummyActionsDirty)
						{
							return true;
						}
					}
					return false;
				}
			}

			public CachedActions(ReferenceHub hub)
			{
				_actions = new List<DummyAction>();
				_providers = hub.GetComponents<IRootDummyActionProvider>();
				_everUpdated = false;
			}

			private void UpdateCache()
			{
				_actions.Clear();
				IRootDummyActionProvider[] providers = _providers;
				for (int i = 0; i < providers.Length; i++)
				{
					providers[i].PopulateDummyActions(_actions.Add, AddCategory);
				}
				_everUpdated = true;
			}

			private void AddCategory(string categoryName)
			{
				_actions.Add(new DummyAction(categoryName, null));
			}
		}

		private static readonly Dictionary<ReferenceHub, CachedActions> CollectionCache = new Dictionary<ReferenceHub, CachedActions>();

		public static bool IsDirty(ReferenceHub hub)
		{
			return GetCache(hub).AnyDirty;
		}

		public static List<DummyAction> ServerGetActions(ReferenceHub hub)
		{
			return GetCache(hub).Actions;
		}

		private static CachedActions GetCache(ReferenceHub hub)
		{
			if (hub == null || !hub.IsDummy)
			{
				throw new ArgumentException("Provided argument is not a dummy.", "hub");
			}
			if (!CollectionCache.TryGetValue(hub, out var value))
			{
				value = new CachedActions(hub);
				CollectionCache[hub] = value;
			}
			return value;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ReferenceHub.OnPlayerRemoved += OnHubRemoved;
		}

		private static void OnHubRemoved(ReferenceHub hub)
		{
			if (hub.IsDummy)
			{
				CollectionCache.Remove(hub);
			}
		}
	}
}

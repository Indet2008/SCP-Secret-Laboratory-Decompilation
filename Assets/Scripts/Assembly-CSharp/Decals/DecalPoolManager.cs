using System;
using UnityEngine;
using UserSettings;
using UserSettings.VideoSettings;

namespace Decals
{
	public class DecalPoolManager : MonoBehaviour
	{
		[Serializable]
		private class DecalCollection
		{
			[SerializeField]
			private Decal[] _templates;

			[SerializeField]
			private PerformanceVideoSetting _enabledSetting;

			[SerializeField]
			private PerformanceVideoSetting _limitSetting;

			private DecalPool[] _pools;

			private int _decalLimit;

			private bool _decalsEnabled;

			public void Setup()
			{
				_pools = new DecalPool[_templates.Length];
				for (int i = 0; i < _pools.Length; i++)
				{
					_pools[i] = new DecalPool(_templates[i]);
				}
				UserSetting<bool>.AddListener(_enabledSetting, OnSettingToggled);
				UserSetting<float>.AddListener(_limitSetting, OnLimitChanged);
				_decalsEnabled = UserSetting<bool>.Get(_enabledSetting);
				_decalLimit = (int)UserSetting<float>.Get(_limitSetting);
			}

			public void UnlinkListeners()
			{
				UserSetting<bool>.RemoveListener(_enabledSetting, OnSettingToggled);
				UserSetting<float>.RemoveListener(_limitSetting, OnLimitChanged);
			}

			public bool TryGet(DecalPoolType type, out Decal decal)
			{
				int num = 0;
				int num2 = 0;
				DecalPool decalPool = null;
				DecalPool decalPool2 = null;
				for (int i = 0; i < _pools.Length; i++)
				{
					DecalPool decalPool3 = _pools[i];
					int instances = decalPool3.Instances;
					num += instances;
					if (decalPool3.Type == type)
					{
						decalPool = decalPool3;
					}
					else if (instances > num2)
					{
						decalPool2 = decalPool3;
						num2 = instances;
					}
				}
				if (decalPool == null)
				{
					decal = null;
					return false;
				}
				while (num >= _decalLimit)
				{
					if (decalPool2 == null || decalPool2.Instances == 0)
					{
						decalPool.DisableLast();
					}
					else
					{
						decalPool2.DisableLast();
					}
					num--;
				}
				decal = decalPool.Get();
				return true;
			}

			internal void Clear(DecalPoolType decalPoolType, int amount)
			{
				DecalPool[] pools = _pools;
				foreach (DecalPool decalPool in pools)
				{
					if (decalPool.Type == decalPoolType)
					{
						decalPool.SetLimit(Mathf.Max(decalPool.Instances - amount, 0));
					}
				}
			}

			private void OnLimitChanged(float limit)
			{
				_decalLimit = (int)limit;
				RefreshLimits();
			}

			private void OnSettingToggled(bool status)
			{
				_decalsEnabled = status;
				RefreshLimits();
			}

			private void RefreshLimits()
			{
				int limit = (_decalsEnabled ? _decalLimit : 0);
				_pools.ForEach((DecalPool x) =>
				{
					x.SetLimit(limit);
				});
			}
		}

		private static DecalPoolManager _singleton;

		private static bool _singletonSet;

		[SerializeField]
		private DecalCollection[] _collections;

		private void Awake()
		{
			_singleton = this;
			_singletonSet = true;
			_collections.ForEach((DecalCollection x) =>
			{
				x.Setup();
			});
		}

		private void OnDestroy()
		{
			_singletonSet = false;
			_collections.ForEach((DecalCollection x) =>
			{
				x.UnlinkListeners();
			});
		}

		public static bool TryGet(DecalPoolType poolType, out Decal decal)
		{
			if (_singletonSet)
			{
				DecalCollection[] collections = _singleton._collections;
				for (int i = 0; i < collections.Length; i++)
				{
					if (collections[i].TryGet(poolType, out decal))
					{
						return true;
					}
				}
			}
			decal = null;
			return false;
		}

		public static void ClientClear(DecalPoolType decalPoolType, int amount)
		{
			DecalCollection[] collections = _singleton._collections;
			for (int i = 0; i < collections.Length; i++)
			{
				collections[i].Clear(decalPoolType, amount);
			}
		}
	}
}

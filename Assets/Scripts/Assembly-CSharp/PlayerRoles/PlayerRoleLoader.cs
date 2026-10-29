using System;
using System.Collections.Generic;
using FastResources;
using GameObjectPools;

namespace PlayerRoles
{
	public static class PlayerRoleLoader
	{
		private static bool _loaded;

		private static Dictionary<RoleTypeId, PlayerRoleBase> _loadedRoles = new Dictionary<RoleTypeId, PlayerRoleBase>();

		public static Dictionary<RoleTypeId, PlayerRoleBase> AllRoles
		{
			get
			{
				if (!_loaded)
				{
					LoadRoles();
				}
				return _loadedRoles;
			}
		}

		public static event Action OnLoaded;

		public static bool TryGetRoleTemplate<T>(this RoleTypeId roleType, out T result)
		{
			if (!AllRoles.TryGetValue(roleType, out var value) || !(value is T val))
			{
				result = default;
				return false;
			}
			result = val;
			return true;
		}

		private static void LoadRoles()
		{
			_loadedRoles = new Dictionary<RoleTypeId, PlayerRoleBase>();
			PlayerRoleBase[] array = FastResourcesDatabase.GetAll<PlayerRoleBase>().ToArray();
			Array.Sort(array, (PlayerRoleBase x, PlayerRoleBase y) => ((int)x.RoleTypeId).CompareTo((int)y.RoleTypeId));
			for (int num = 0; num < array.Length; num++)
			{
				PlayerRoleBase playerRoleBase = array[num];
				// Local change: in the Unity editor, holiday roles load outside their event too (matches InventoryItemLoader).
				if ((!(playerRoleBase is IHolidayRole { IsAvailable: false }) || UnityEngine.Application.isEditor) && playerRoleBase.gameObject.activeSelf)
				{
					if (playerRoleBase.VariantsModule != null && playerRoleBase.VariantsModule.TryGetVariant(out var variant))
					{
						playerRoleBase = variant;
					}
					_loadedRoles[playerRoleBase.RoleTypeId] = playerRoleBase;
					PoolManager.Singleton.TryAddPool(playerRoleBase);
				}
			}
			_loaded = true;
			OnLoaded?.Invoke();
		}
	}
}

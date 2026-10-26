using System.Collections.Generic;
using System.Linq;
using PlayerRoles;
using PlayerRoles.PlayableScps;
using PlayerRoles.RoleAssign;
using TMPro;
using UnityEngine;

namespace UserSettings.OtherSettings
{
	public class ScpPreferenceListGenerator : MonoBehaviour
	{
		[SerializeField]
		private GameObject _template;

		[SerializeField]
		private Transform[] _columns;

		private Transform[] _prevSiblings;

		private IEnumerable<PlayerRoleBase> SpawnableScps => from x in PlayerRoleLoader.AllRoles
			where x.Value is ISpawnableScp spawnableScp && spawnableScp.RespectPreferences
			select x.Value;

		private void Awake()
		{
			_prevSiblings = new Transform[_columns.Length];
			int num = 0;
			foreach (PlayerRoleBase item in SpawnableScps.OrderBy((PlayerRoleBase x) => x.RoleName))
			{
				int num2 = num++ % _columns.Length;
				GameObject gameObject = Object.Instantiate(_template, _columns[num2]);
				Transform transform = _prevSiblings[num2];
				if (transform != null)
				{
					gameObject.transform.SetSiblingIndex(transform.GetSiblingIndex() + 1);
				}
				gameObject.GetComponentInChildren<TMP_Text>().text = item.RoleName;
				gameObject.GetComponentInChildren<ScpPreferenceSlider>().SetRole(item.RoleTypeId);
				_prevSiblings[num2] = gameObject.transform;
			}
		}
	}
}

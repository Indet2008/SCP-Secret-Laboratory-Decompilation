using System.Collections.Generic;
using System.Text;
using PlayerRoles;
using TMPro;
using UnityEngine;

namespace Respawning.NamingRules
{
	public class UnitNamingHud : MonoBehaviour
	{
		public TextMeshProUGUI UnitsList;

		private Team _localTeam;

		private int _localIndex;

		private static readonly StringBuilder StrBuilder = new StringBuilder();

		private void AppendUnit(int index, string unitName)
		{
			if (_localIndex == index)
			{
				StrBuilder.Append("<u>");
				StrBuilder.Append(unitName);
				StrBuilder.Append("</u>\n");
			}
			else
			{
				StrBuilder.Append(unitName);
				StrBuilder.Append("\n");
			}
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!hub.isLocalPlayer)
			{
				return;
			}
			if (newRole is HumanRole humanRole && NamingRulesManager.GeneratedNames.TryGetValue(humanRole.Team, out var value))
			{
				StrBuilder.Clear();
				_localTeam = humanRole.Team;
				_localIndex = humanRole.UnitNameId;
				UnitsList.enabled = true;
				int num = 0;
				foreach (string item in value)
				{
					AppendUnit(num++, item);
				}
				UnitsList.text = StrBuilder.ToString();
			}
			else
			{
				_localTeam = Team.OtherAlive;
				UnitsList.text = string.Empty;
				UnitsList.enabled = false;
			}
		}

		private void OnMsgReceived(Team team, string unit, int index)
		{
			if (team == _localTeam)
			{
				AppendUnit(index, unit);
				UnitsList.text = StrBuilder.ToString();
			}
		}

		private void OnDestroy()
		{
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			NamingRulesManager.OnNameAdded -= OnMsgReceived;
		}

		private void Start()
		{
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			NamingRulesManager.OnNameAdded += OnMsgReceived;
		}
	}
}

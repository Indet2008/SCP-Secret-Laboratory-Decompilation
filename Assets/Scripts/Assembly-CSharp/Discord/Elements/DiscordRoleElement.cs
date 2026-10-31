using PlayerRoles;
using UnityEngine;

namespace Discord.Elements
{
	[CreateAssetMenu(fileName = "New Role Element", menuName = "ScriptableObject/Discord/Role Element")]
	public class DiscordRoleElement : DiscordElementBase
	{
		[field: SerializeField]
		public RoleTypeId RoleId { get; private set; }
	}
}

using PlayerRoles;
using UnityEngine;

namespace Discord.Elements
{
	[CreateAssetMenu(fileName = "New Team Element", menuName = "ScriptableObject/Discord/Team Element")]
	public class DiscordTeamElement : DiscordElementBase
	{
		[field: SerializeField]
		public Team TeamId { get; private set; }
	}
}

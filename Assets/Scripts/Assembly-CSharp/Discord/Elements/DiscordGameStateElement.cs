using UnityEngine;

namespace Discord.Elements
{
	[CreateAssetMenu(fileName = "New GameState Element", menuName = "ScriptableObject/Discord/GameState Element")]
	public class DiscordGameStateElement : DiscordElementBase
	{
		[field: SerializeField]
		public DiscordGameStatus Status { get; private set; }
	}
}

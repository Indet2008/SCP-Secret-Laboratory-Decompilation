using UnityEngine;

namespace Discord.Elements
{
	public abstract class DiscordElementBase : ScriptableObject
	{
		[field: SerializeField]
		public string Title { get; private set; }

		[field: SerializeField]
		public string LargeImageId { get; private set; }

		[field: SerializeField]
		public string SmallImageId { get; private set; }

		[field: SerializeField]
		public bool IsInstance { get; private set; }
	}
}

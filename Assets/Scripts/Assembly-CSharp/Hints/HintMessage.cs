using Mirror;

namespace Hints
{
	public readonly struct HintMessage : NetworkMessage
	{
		public readonly Hint Content;

		public HintMessage(Hint content)
		{
			Content = content;
		}
	}
}

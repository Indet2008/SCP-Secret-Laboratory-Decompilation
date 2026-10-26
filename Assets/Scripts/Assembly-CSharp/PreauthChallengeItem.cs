using System;

public struct PreauthChallengeItem
{
	public long Added { get; private set; }

	public ArraySegment<byte> ValidResponse { get; private set; }

	public PreauthChallengeItem(ArraySegment<byte> response)
	{
		ValidResponse = response;
		Added = DateTime.Now.Ticks;
	}
}

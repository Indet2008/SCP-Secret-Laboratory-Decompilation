using System;

namespace Utils.Http.SDR
{
	internal class FragmentedPacket
	{
		public int FragmentId { get; set; }

		public int FragmentCount { get; set; }

		public int TotalFragments { get; set; }

		public int Size { get; set; }

		public byte[][] Data { get; set; }

		public bool[] Received { get; set; }

		public bool ShouldCleanup { get; set; }

		public DateTime LastReceived { get; set; }

		public bool IsComplete
		{
			get
			{
				for (int i = 0; i < TotalFragments; i++)
				{
					if (!Received[i])
					{
						return false;
					}
				}
				return true;
			}
		}
	}
}

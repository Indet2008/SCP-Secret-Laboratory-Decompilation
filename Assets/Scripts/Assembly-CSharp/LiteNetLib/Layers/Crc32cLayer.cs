using System;
using System.Net;
using LiteNetLib.Utils;

namespace LiteNetLib.Layers
{
	public sealed class Crc32cLayer : PacketLayerBase
	{
		public Crc32cLayer()
			: base(4)
		{
		}

		public override void ProcessInboundPacket(ref IPEndPoint endPoint, ref byte[] data, ref int length)
		{
			if (length < 5)
			{
				NetDebug.WriteError("[NM] DataReceived size: bad!");
				length = 0;
				return;
			}
			int num = length - 4;
			if (CRC32C.Compute(data, 0, num) != BitConverter.ToUInt32(data, num))
			{
				length = 0;
			}
			else
			{
				length -= 4;
			}
		}

		public override void ProcessOutBoundPacket(ref IPEndPoint endPoint, ref byte[] data, ref int offset, ref int length)
		{
			FastBitConverter.GetBytes(data, length, CRC32C.Compute(data, offset, length));
			length += 4;
		}
	}
}

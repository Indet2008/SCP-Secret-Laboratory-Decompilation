using Mirror;

namespace Cassie
{
	public static class CassieTtsPayloadReadersWriters
	{
		public static void WriteCassieTtsPayload(this NetworkWriter writer, CassieTtsPayload value)
		{
			value.WriteSelf(writer);
		}

		public static CassieTtsPayload ReadCassieTtsPayload(this NetworkReader reader)
		{
			return new CassieTtsPayload(reader);
		}
	}
}

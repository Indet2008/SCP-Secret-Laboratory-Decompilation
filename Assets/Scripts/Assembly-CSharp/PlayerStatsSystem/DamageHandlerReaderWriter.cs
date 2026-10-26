using System;
using Mirror;

namespace PlayerStatsSystem
{
	public static class DamageHandlerReaderWriter
	{
		public static void WriteDamageHandler(this NetworkWriter writer, DamageHandlerBase info)
		{
			writer.WriteByte(DamageHandlers.IdsByTypeHash[info.GetType().FullName.GetStableHashCode()]);
			info.WriteAdditionalData(writer);
		}

		public static DamageHandlerBase ReadDamageHandler(this NetworkReader reader)
		{
			byte key = reader.ReadByte();
			if (!DamageHandlers.ConstructorsById.TryGetValue(key, out var value))
			{
				throw new InvalidOperationException("DamageType " + key + " does not have a defined handler!");
			}
			DamageHandlerBase damageHandlerBase = value();
			damageHandlerBase.ReadAdditionalData(reader);
			return damageHandlerBase;
		}
	}
}

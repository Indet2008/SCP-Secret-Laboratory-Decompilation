using System;
using Mirror;

namespace InventorySystem.Items.Autosync
{
	public static class AutosyncMessageUtils
	{
		public static void WriteSubheader(this NetworkWriter writer, Enum val)
		{
			writer.WriteByte(((IConvertible)val).ToByte((IFormatProvider)null));
		}
	}
}

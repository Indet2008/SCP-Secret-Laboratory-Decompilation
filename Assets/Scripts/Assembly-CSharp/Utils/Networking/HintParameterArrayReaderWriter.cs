using System.Collections.Generic;
using Hints;
using Mirror;

namespace Utils.Networking
{
	public static class HintParameterArrayReaderWriter
	{
		public static HintParameter[] ReadHintParameterArray(this NetworkReader reader)
		{
			return ArrayReaderWriter<HintParameter>.ReadArray(reader, HintParameterReaderWriter.ReadHintParameter);
		}

		public static void WriteHintParameterArray(this NetworkWriter writer, IReadOnlyCollection<HintParameter> array)
		{
			ArrayReaderWriter<HintParameter>.WriteArray(writer, array, HintParameterReaderWriter.WriteHintParameter);
		}
	}
}

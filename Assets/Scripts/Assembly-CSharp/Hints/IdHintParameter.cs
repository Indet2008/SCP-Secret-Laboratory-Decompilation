using Mirror;

namespace Hints
{
	public abstract class IdHintParameter : HintParameter
	{
		private bool _stopFormatting;

		protected int Id { get; private set; }

		protected IdHintParameter()
		{
		}

		protected IdHintParameter(byte id)
		{
			Id = id;
		}

		public override void Deserialize(NetworkReader reader)
		{
			Id = reader.ReadInt();
		}

		public override void Serialize(NetworkWriter writer)
		{
			writer.WriteInt(Id);
		}

		protected override string UpdateState(float progress)
		{
			if (_stopFormatting)
			{
				return null;
			}
			return FormatId(progress, out _stopFormatting);
		}

		protected abstract string FormatId(float progress, out bool stopFormatting);
	}
}

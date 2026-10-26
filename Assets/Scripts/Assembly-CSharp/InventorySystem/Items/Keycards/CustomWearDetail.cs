using System;
using Mirror;

namespace InventorySystem.Items.Keycards
{
	public class CustomWearDetail : SyncedDetail, ICustomizableDetail
	{
		private static byte _customWearLevel;

		public int CustomizablePropertiesAmount => 1;

		public string[] CommandArguments => new string[1] { "Wear level (index)" };

		public void ParseArguments(ArraySegment<string> args)
		{
			_customWearLevel = byte.Parse(args.At(0));
		}

		public void SetArguments(ArraySegment<object> args)
		{
			_customWearLevel = (byte)args.At(0);
		}

		public override void WriteDefault(NetworkWriter writer)
		{
			writer.WriteByte(0);
		}

		public override void WriteNewItem(KeycardItem item, NetworkWriter writer)
		{
			writer.WriteByte(_customWearLevel);
		}

		public override void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer)
		{
			writer.WriteByte(_customWearLevel);
		}

		protected override void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template)
		{
			int num = reader.ReadByte();
			for (int i = 0; i < target.ElementVariants.Length; i++)
			{
				target.ElementVariants[i].SetActive(i == num);
			}
		}
	}
}

using System;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class CustomTintDetail : SyncedDetail, ICustomizableDetail
	{
		private static Color32 _customColor;

		public int CustomizablePropertiesAmount => 1;

		public string[] CommandArguments => new string[1] { "Primary tint color (hex or name)" };

		public void ParseArguments(ArraySegment<string> args)
		{
			Misc.TryParseColor(args.At(0), out _customColor);
		}

		public void SetArguments(ArraySegment<object> args)
		{
			_customColor = (Color32)args.At(0);
		}

		public override void WriteDefault(NetworkWriter writer)
		{
			writer.WriteColor32(Color.white);
		}

		public override void WriteNewItem(KeycardItem item, NetworkWriter writer)
		{
			writer.WriteColor32(_customColor);
		}

		public override void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer)
		{
			writer.WriteColor32(_customColor);
		}

		protected override void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template)
		{
			target.SetTint(reader.ReadColor32());
		}
	}
}

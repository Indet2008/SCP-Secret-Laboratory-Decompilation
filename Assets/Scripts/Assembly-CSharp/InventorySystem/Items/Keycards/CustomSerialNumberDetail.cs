using System;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class CustomSerialNumberDetail : SerialNumberDetail, ICustomizableDetail
	{
		private static string _customVal;

		public string[] CommandArguments => new string[1] { "Serial number" };

		public int CustomizablePropertiesAmount => 1;

		public void ParseArguments(ArraySegment<string> args)
		{
			_customVal = args.At(0);
		}

		public void SetArguments(ArraySegment<object> args)
		{
			_customVal = (string)args.At(0);
		}

		public override void WriteDefault(NetworkWriter writer)
		{
			writer.WriteString(null);
		}

		public override void WriteNewItem(KeycardItem item, NetworkWriter writer)
		{
			writer.WriteString(_customVal);
		}

		public override void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer)
		{
			writer.WriteString(_customVal);
		}

		protected override void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template)
		{
			Renderer[] serialNumberDigits = target.SerialNumberDigits;
			string text = reader.ReadString() ?? string.Empty;
			text = text.PadLeft(serialNumberDigits.Length, '0');
			for (int i = 0; i < serialNumberDigits.Length; i++)
			{
				serialNumberDigits[i].sharedMaterial = GetDigitMaterial(text[i] - 48);
			}
		}
	}
}

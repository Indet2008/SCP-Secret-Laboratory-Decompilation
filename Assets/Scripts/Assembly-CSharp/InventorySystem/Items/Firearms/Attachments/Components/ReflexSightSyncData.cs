using Mirror;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public readonly struct ReflexSightSyncData
	{
		private readonly int _colorHue;

		private readonly int _colorBrightness;

		private readonly int _size;

		private readonly int _iconIndex;

		public ReflexSightSyncData(int colorHue, int colorBrightness, int size, int iconIndex)
		{
			_colorHue = colorHue;
			_colorBrightness = colorBrightness;
			_size = size;
			_iconIndex = iconIndex;
		}

		public ReflexSightSyncData(ReflexSightAttachment attachment)
		{
			_colorHue = attachment.CurColorIndex;
			_colorBrightness = attachment.CurBrightnessIndex;
			_size = attachment.CurSizeIndex;
			_iconIndex = attachment.CurTextureIndex;
		}

		public ReflexSightSyncData(NetworkReader reader)
		{
			ushort num = reader.ReadUShort();
			_colorHue = (num & 0xF000) >> 12;
			_colorBrightness = (num & 0xF00) >> 8;
			_size = (num & 0xF0) >> 4;
			_iconIndex = num & 0xF;
		}

		public void Write(NetworkWriter writer)
		{
			int num = _colorHue << 12;
			int num2 = _colorBrightness << 8;
			int num3 = _size << 4;
			int iconIndex = _iconIndex;
			writer.WriteUShort((ushort)(num + num2 + num3 + iconIndex));
		}

		public void Apply(ReflexSightAttachment att)
		{
			att.SetValues(_iconIndex, _colorHue, _size, _colorBrightness);
		}
	}
}

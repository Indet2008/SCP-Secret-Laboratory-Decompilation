namespace Discord
{
	public struct ImageHandle
	{
		public ImageType Type;

		public long Id;

		public uint Size;

		public static ImageHandle User(long id)
		{
			return User(id, 128u);
		}

		public static ImageHandle User(long id, uint size)
		{
			return new ImageHandle
			{
				Type = ImageType.User,
				Id = id,
				Size = size
			};
		}
	}
}

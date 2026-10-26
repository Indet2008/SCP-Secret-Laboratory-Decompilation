namespace ServerOutput
{
	public interface IOutputEntry
	{
		string GetString();

		int GetBytesLength();

		void GetBytes(ref byte[] buffer, out int length);
	}
}

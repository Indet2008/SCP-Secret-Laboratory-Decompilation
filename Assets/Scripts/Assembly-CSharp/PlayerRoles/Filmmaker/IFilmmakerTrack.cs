namespace PlayerRoles.Filmmaker
{
	public interface IFilmmakerTrack
	{
		int FirstFrame { get; }

		int LastFrame { get; }

		bool TryGetNextFrame(int startTime, out int next);

		bool TryGetPrevFrame(int startTime, out int prev);

		void ClearAll();

		void ClearFrame();

		void ClearFrame(int timeFrames);
	}
}

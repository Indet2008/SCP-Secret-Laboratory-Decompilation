namespace PlayerRoles.Filmmaker
{
	public class FilmmakerKeyframe<T> where T : struct
	{
		public T Value;

		public int TimeFrames;

		public FilmmakerBlendPreset BlendCurve;
	}
}

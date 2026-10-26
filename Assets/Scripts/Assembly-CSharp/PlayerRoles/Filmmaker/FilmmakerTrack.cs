using System.Collections.Generic;
using System.Linq;

namespace PlayerRoles.Filmmaker
{
	public class FilmmakerTrack<T> : IFilmmakerTrack where T : struct
	{
		public readonly T DefaultValue;

		private readonly List<FilmmakerKeyframe<T>> _unordered;

		private FilmmakerKeyframe<T>[] _ordered;

		public FilmmakerKeyframe<T>[] Keyframes => _ordered ?? (_ordered = _unordered.OrderBy((FilmmakerKeyframe<T> x) => x.TimeFrames).ToArray());

		public int FirstFrame
		{
			get
			{
				if (Keyframes.Length != 0)
				{
					return Keyframes[0].TimeFrames;
				}
				return 0;
			}
		}

		public int LastFrame
		{
			get
			{
				if (Keyframes.Length != 0)
				{
					return Keyframes[^1].TimeFrames;
				}
				return 0;
			}
		}

		public FilmmakerTrack(T defVal)
		{
			DefaultValue = defVal;
			_unordered = new List<FilmmakerKeyframe<T>>();
		}

		public void AddOrReplace(T val, FilmmakerBlendPreset blend)
		{
			AddOrReplace(val, blend, FilmmakerTimelineManager.TimeFrames);
		}

		public void AddOrReplace(T val, FilmmakerBlendPreset blend, int timeFrames)
		{
			ClearFrame(timeFrames);
			FilmmakerKeyframe<T> item = new FilmmakerKeyframe<T>
			{
				TimeFrames = timeFrames,
				Value = val,
				BlendCurve = blend
			};
			_unordered.Add(item);
			_ordered = null;
		}

		public void ClearAll()
		{
			_unordered.Clear();
			_ordered = null;
		}

		public void ClearFrame()
		{
			ClearFrame(FilmmakerTimelineManager.TimeFrames);
		}

		public void ClearFrame(int frameTimes)
		{
			int count = _unordered.Count;
			for (int i = 0; i < count; i++)
			{
				if (_unordered[i].TimeFrames == frameTimes)
				{
					_ordered = null;
					_unordered.RemoveAt(i);
					break;
				}
			}
		}

		public bool TryGetNextFrame(int startTime, out int next)
		{
			int num = Keyframes.Length;
			for (int i = 0; i < num; i++)
			{
				next = Keyframes[i].TimeFrames;
				if (next > startTime)
				{
					return true;
				}
			}
			next = 0;
			return false;
		}

		public bool TryGetPrevFrame(int startTime, out int prev)
		{
			for (int num = Keyframes.Length - 1; num >= 0; num--)
			{
				prev = Keyframes[num].TimeFrames;
				if (prev < startTime)
				{
					return true;
				}
			}
			prev = 0;
			return false;
		}
	}
}

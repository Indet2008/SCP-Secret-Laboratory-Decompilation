using System;

namespace MEC
{
	public struct CoroutineHandle : IEquatable<CoroutineHandle>
	{
		private const byte ReservedSpace = 15;

		private static readonly int[] NextIndex = new int[16]
		{
			16, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0
		};

		private readonly int _id;

		public byte Key => (byte)(_id & 0xF);

		public string Tag
		{
			get
			{
				return Timing.GetTag(this);
			}
			set
			{
				Timing.SetTag(this, value);
			}
		}

		public int? Layer
		{
			get
			{
				return Timing.GetLayer(this);
			}
			set
			{
				if (!value.HasValue)
				{
					Timing.RemoveLayer(this);
				}
				else
				{
					Timing.SetLayer(this, value.Value);
				}
			}
		}

		public Segment Segment
		{
			get
			{
				return Timing.GetSegment(this);
			}
			set
			{
				Timing.SetSegment(this, value);
			}
		}

		public bool IsRunning
		{
			get
			{
				return Timing.IsRunning(this);
			}
			set
			{
				if (!value)
				{
					Timing.KillCoroutines(this);
				}
			}
		}

		public bool IsAliveAndPaused
		{
			get
			{
				return Timing.IsAliveAndPaused(this);
			}
			set
			{
				if (value)
				{
					Timing.PauseCoroutines(this);
				}
				else
				{
					Timing.ResumeCoroutines(this);
				}
			}
		}

		public bool IsValid => Key != 0;

		public CoroutineHandle(byte ind)
		{
			if (ind > 15)
			{
				ind -= 15;
			}
			_id = NextIndex[ind] + ind;
			NextIndex[ind] += 16;
		}

		public CoroutineHandle(CoroutineHandle other)
		{
			_id = other._id;
		}

		public bool Equals(CoroutineHandle other)
		{
			return _id == other._id;
		}

		public override bool Equals(object other)
		{
			if (other is CoroutineHandle)
			{
				return Equals((CoroutineHandle)other);
			}
			return false;
		}

		public static bool operator ==(CoroutineHandle a, CoroutineHandle b)
		{
			return a._id == b._id;
		}

		public static bool operator !=(CoroutineHandle a, CoroutineHandle b)
		{
			return a._id != b._id;
		}

		public override int GetHashCode()
		{
			return _id;
		}

		public override string ToString()
		{
			if (Timing.GetTag(this) == null)
			{
				if (!Timing.GetLayer(this).HasValue)
				{
					return Timing.GetDebugName(this);
				}
				return Timing.GetDebugName(this) + " Layer: " + Timing.GetLayer(this);
			}
			if (!Timing.GetLayer(this).HasValue)
			{
				return Timing.GetDebugName(this) + " Tag: " + Timing.GetTag(this);
			}
			return Timing.GetDebugName(this) + " Tag: " + Timing.GetTag(this) + " Layer: " + Timing.GetLayer(this);
		}
	}
}

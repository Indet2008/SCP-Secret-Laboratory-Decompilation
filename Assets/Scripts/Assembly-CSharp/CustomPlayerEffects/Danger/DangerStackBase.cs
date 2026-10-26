using System.Diagnostics;

namespace CustomPlayerEffects.Danger
{
	public abstract class DangerStackBase
	{
		public readonly Stopwatch TimeTracker = new Stopwatch();

		private bool _isActive;

		public abstract float DangerValue { get; set; }

		public virtual float Duration { get; } = 20f;

		public virtual bool IsActive
		{
			get
			{
				bool flag = TimeTracker.IsRunning && TimeTracker.Elapsed.TotalSeconds <= (double)Duration;
				if (!_isActive && !flag)
				{
					TimeTracker.Stop();
				}
				return _isActive | flag;
			}
			protected set
			{
				if (value != _isActive)
				{
					_isActive = value;
					if (!_isActive)
					{
						TimeTracker.Restart();
					}
				}
			}
		}

		protected ReferenceHub Owner { get; set; }

		public virtual void Initialize(ReferenceHub target)
		{
			Owner = target;
		}

		public virtual void Dispose()
		{
		}
	}
}

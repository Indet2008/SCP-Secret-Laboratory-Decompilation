using System;

namespace Rounds.Options
{
	public class SetValueOption<T> : IRoundOption
	{
		private readonly T _newValue;

		private readonly Action<T> _action;

		public SetValueOption(Action<T> action, T newValue)
		{
			_action = action;
			_newValue = newValue;
		}

		public void Invoke()
		{
			_action(_newValue);
		}
	}
}

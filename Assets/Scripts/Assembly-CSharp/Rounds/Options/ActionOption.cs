using System;

namespace Rounds.Options
{
	public class ActionOption : IRoundOption
	{
		private readonly Action _action;

		public ActionOption(Action action)
		{
			_action = action;
		}

		public void Invoke()
		{
			_action();
		}
	}
}

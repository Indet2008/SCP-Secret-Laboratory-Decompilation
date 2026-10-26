using System;

namespace NetworkManagerUtils.Dummies
{
	public interface IDummyActionProvider
	{
		void PopulateDummyActions(Action<DummyAction> actionAdder);
	}
}

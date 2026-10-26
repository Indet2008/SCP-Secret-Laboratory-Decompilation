using System;

namespace NetworkManagerUtils.Dummies
{
	public interface IRootDummyActionProvider
	{
		bool DummyActionsDirty { get; set; }

		void PopulateDummyActions(Action<DummyAction> actionAdder, Action<string> categoryAdder);
	}
}

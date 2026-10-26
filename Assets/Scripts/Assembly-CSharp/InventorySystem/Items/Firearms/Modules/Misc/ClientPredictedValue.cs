using System;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class ClientPredictedValue<T>
	{
		private readonly Func<T> _fetcher;

		private readonly ClientRequestTimer _predictionTimeout;

		private T _predicted;

		public T Value
		{
			get
			{
				if (_predictionTimeout.Busy)
				{
					return _predicted;
				}
				_predicted = _fetcher();
				return _predicted;
			}
			set
			{
				_predicted = value;
				_predictionTimeout.Trigger();
			}
		}

		public void ForceResync()
		{
			_predictionTimeout.Reset();
		}

		public ClientPredictedValue(Func<T> serverSyncvarFetcher)
		{
			_fetcher = serverSyncvarFetcher;
			_predictionTimeout = new ClientRequestTimer();
		}
	}
}

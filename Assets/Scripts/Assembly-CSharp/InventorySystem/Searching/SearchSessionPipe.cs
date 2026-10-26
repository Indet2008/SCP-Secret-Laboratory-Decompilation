using System;
using Mirror;
using Security;
using UnityEngine;

namespace InventorySystem.Searching
{
	public class SearchSessionPipe
	{
		public enum Activity
		{
			Idle = 0,
			Requested = 1,
			Promised = 2
		}

		private readonly SearchCoordinator _owner;

		private readonly RateLimit _rateLimiter;

		private SearchRequest _request;

		private SearchSession _session;

		private SearchInvalidation Invalidation => new SearchInvalidation(_request.Id);

		public SearchRequest Request => _request;

		public SearchSession Session
		{
			get
			{
				return _session;
			}
			set
			{
				if (!NetworkServer.active)
				{
					throw new InvalidOperationException("The promise can only be set from the server.");
				}
				if (!value.Equals(_session))
				{
					_owner.connectionToClient.Send(value);
					Status = Activity.Promised;
					_session = value;
				}
			}
		}

		public Activity Status { get; private set; }

		public event Action RequestUpdated;

		public event Action SessionAborted;

		public event Action SessionUpdated;

		public SearchSessionPipe(SearchCoordinator owner, RateLimit rateLimit)
		{
			_owner = owner;
			_rateLimiter = rateLimit;
		}

		private static void ReceiveRequest(NetworkConnection source, SearchRequest request)
		{
			SearchCoordinator searchCoordinator = ((source == null) ? ReferenceHub.LocalHub.searchCoordinator : source.identity.GetComponent<SearchCoordinator>());
			if (!(searchCoordinator == null))
			{
				SearchSessionPipe sessionPipe = searchCoordinator.SessionPipe;
				if (request.Target == null)
				{
					sessionPipe.Invalidate();
					source?.identity.GetComponent<GameConsoleTransmission>().SendToClient("Search request rejected - target is null.", "red");
				}
				else if (request.Target.ServerValidateRequest(source, sessionPipe))
				{
					sessionPipe.HandleRequest(request);
				}
			}
		}

		private void HandleRequest(SearchRequest request)
		{
			if (_rateLimiter.CanExecute())
			{
				_request = request;
				Status = Activity.Requested;
				RequestUpdated?.Invoke();
			}
		}

		private static void ReceivePromise(SearchSession session)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.searchCoordinator != null && hub.searchCoordinator.SessionPipe != null)
			{
				hub.searchCoordinator.SessionPipe.HandlePromise(session);
			}
		}

		private void HandlePromise(SearchSession session)
		{
			if (NetworkServer.active)
			{
				return;
			}
			if (Status != Activity.Idle && object.Equals(session.Target, _request.Target))
			{
				_session = session;
				Status = Activity.Promised;
				SessionUpdated?.Invoke();
			}
		}

		private static void ReceiveAbortion(NetworkConnection source, SearchInvalidation invalidation)
		{
			SearchCoordinator searchCoordinator = ((source == null) ? ReferenceHub.LocalHub.searchCoordinator : source.identity.GetComponent<SearchCoordinator>());
			if (!(searchCoordinator == null))
			{
				searchCoordinator.SessionPipe.HandleAbort(invalidation);
			}
		}

		private void HandleAbort(SearchInvalidation invalidation)
		{
			if (_request.Id != invalidation.Id)
			{
				return;
			}
			if (_request.Target is UnityEngine.Object obj && obj != null)
			{
				_request.Target.ServerHandleAbort(_owner.Hub);
			}
			try
			{
				Status = Activity.Idle;
				SessionAborted?.Invoke();
			}
			finally
			{
				_request = default;
				_session = default;
			}
		}

		private static void ReceiveInvalidation(SearchInvalidation invalidation)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.searchCoordinator != null && hub.searchCoordinator.SessionPipe != null)
			{
				hub.searchCoordinator.SessionPipe.HandleInvalidate(invalidation);
			}
		}

		private void HandleInvalidate(SearchInvalidation invalidation)
		{
			if (_request.Id == invalidation.Id)
			{
				Status = Activity.Idle;
				SessionAborted?.Invoke();
			}
		}

		public void ClientRequest(SearchRequest request)
		{
			_request = request;
			_session = default(SearchSession);
			Status = Activity.Requested;
			NetworkClient.Send(request);
		}

		public void ClientAbort()
		{
			if (Status != Activity.Idle)
			{
				NetworkClient.Send(new SearchInvalidation(_request.Id));
				Status = Activity.Idle;
				SessionAborted?.Invoke();
			}
		}

		public void RegisterHandlers()
		{
			NetworkServer.ReplaceHandler<SearchRequest>(ReceiveRequest);
			NetworkServer.ReplaceHandler<SearchInvalidation>(ReceiveAbortion);
			NetworkClient.ReplaceHandler<SearchInvalidation>(ReceiveInvalidation);
			NetworkClient.ReplaceHandler<SearchSession>(ReceivePromise);
		}

		public void Invalidate()
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("An invalidation can only be performed by the server.");
			}
			if (_request.Target is UnityEngine.Object obj && obj != null)
			{
				_request.Target.ServerHandleAbort(_owner.Hub);
			}
			_owner.connectionToClient.Send(Invalidation);
			Status = Activity.Idle;
		}

		public void Update()
		{
			Activity activity = Status;
			Activity activity2;
			do
			{
				activity2 = activity;
				switch (Status)
				{
				case Activity.Promised:
					if (!(NetworkTime.time >= Session.FinishTime))
					{
						break;
					}
					activity = Activity.Requested;
					continue;
				case Activity.Requested:
					if (!(NetworkTime.time >= Request.FinishTime))
					{
						break;
					}
					activity = Activity.Idle;
					continue;
				}
				activity = Status;
			}
			while (activity != activity2);
			Status = activity;
		}
	}
}

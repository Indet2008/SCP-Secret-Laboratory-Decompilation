using Mirror;

namespace InventorySystem.Searching
{
	public interface ISearchable
	{
		bool CanSearch { get; }

		NetworkIdentity netIdentity { get; }

		ISearchCompletor GetSearchCompletor(SearchCoordinator coordinator, float sqrDistance);

		float SearchTimeForPlayer(ReferenceHub hub);

		bool ServerValidateRequest(NetworkConnection source, SearchSessionPipe session);

		void ServerHandleAbort(ReferenceHub hub);
	}
}

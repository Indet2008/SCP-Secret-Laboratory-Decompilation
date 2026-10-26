using Mirror;
using PlayerRoles;
using Utils.Networking;

namespace Respawning.Objectives
{
	public abstract class FactionObjectiveBase
	{
		public FactionObjectiveBase()
		{
			OnInstanceCreated();
			CustomNetworkManager.OnClientReady += OnInstanceReset;
		}

		public void Destroy()
		{
			CustomNetworkManager.OnClientReady -= OnInstanceReset;
		}

		public virtual void ServerWriteRpc(NetworkWriter writer)
		{
		}

		public virtual void ClientReadRpc(NetworkReader reader)
		{
		}

		protected void ServerSendUpdate()
		{
			new ObjectiveCompletionMessage(this).SendToHubsConditionally((ReferenceHub hub) => !hub.IsHost);
		}

		protected abstract bool IsValidFaction(Faction faction);

		protected virtual bool IsValidFaction(ReferenceHub hub)
		{
			return IsValidFaction(hub.GetFaction());
		}

		protected virtual void OnInstanceCreated()
		{
		}

		protected virtual void OnInstanceReset()
		{
		}

		protected virtual void OnInstanceDestroyed()
		{
		}

		protected void GrantInfluence(Faction faction, float influence)
		{
			FactionInfluenceManager.Add(faction, influence);
		}

		protected void ReduceTimer(Faction faction, float seconds)
		{
			WaveManager.AdvanceTimer(faction, seconds);
		}
	}
}

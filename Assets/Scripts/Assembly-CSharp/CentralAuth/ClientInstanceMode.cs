namespace CentralAuth
{
	public enum ClientInstanceMode : byte
	{
		Unverified = 0,
		ReadyClient = 1,
		Host = 2,
		DedicatedServer = 3,
		Dummy = 4
	}
}

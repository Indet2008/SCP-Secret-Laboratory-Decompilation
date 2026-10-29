namespace LabApi.Features.Enums
{
	[global::System.Flags]
	public enum PlayerSearchFlags
	{
		None = 0,
		AuthenticatedPlayers = 1,
		UnauthenticatedPlayers = 2,
		DummyNpcs = 4,
		RegularNpcs = 8,
		Host = 0x10,
		AuthenticatedAndDummy = AuthenticatedPlayers | DummyNpcs
	}
}

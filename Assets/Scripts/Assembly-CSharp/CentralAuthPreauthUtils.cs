public static class CentralAuthPreauthUtils
{
	public static bool HasFlagFast(this CentralAuthPreauthFlags flags, CentralAuthPreauthFlags flag)
	{
		return (flags & flag) == flag;
	}
}

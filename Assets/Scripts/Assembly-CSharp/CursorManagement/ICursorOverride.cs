namespace CursorManagement
{
	public interface ICursorOverride
	{
		CursorOverrideMode CursorOverride { get; }

		bool LockMovement { get; }
	}
}

using Interactables.Verification;

namespace Interactables
{
	public interface IInteractable
	{
		IVerificationRule VerificationRule { get; }
	}
}

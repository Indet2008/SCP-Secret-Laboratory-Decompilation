public class RagdollPart : global::UnityEngine.MonoBehaviour
{
	public global::PlayerRoles.Ragdolls.BasicRagdoll ParentRagdoll;

	private void Reset()
	{
		ParentRagdoll = GetComponentInParent<global::PlayerRoles.Ragdolls.BasicRagdoll>();
	}

	public RagdollPart()
	{
	}
}

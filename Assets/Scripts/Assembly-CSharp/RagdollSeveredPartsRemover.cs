using UnityEngine;

public class RagdollSeveredPartsRemover : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private global::PlayerRoles.Ragdolls.DynamicRagdoll _ragdoll;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.Transform[] _hands;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.Transform[] _eyes;


}

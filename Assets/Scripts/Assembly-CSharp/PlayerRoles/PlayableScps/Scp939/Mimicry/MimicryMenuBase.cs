using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public abstract class MimicryMenuBase : MonoBehaviour
	{
		protected virtual void Awake()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is Scp939Role role)
			{
				Setup(role);
			}
			else
			{
				base.gameObject.SetActive(value: false);
			}
		}

		protected virtual void Setup(Scp939Role role)
		{
		}
	}
}

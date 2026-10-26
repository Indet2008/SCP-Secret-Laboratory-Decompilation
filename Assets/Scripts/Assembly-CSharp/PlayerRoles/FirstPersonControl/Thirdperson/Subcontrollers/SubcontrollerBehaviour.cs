using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public abstract class SubcontrollerBehaviour : MonoBehaviour, INetworkedAnimatedModelSubcontroller, IAnimatedModelSubcontroller
	{
		public AnimatedCharacterModel Model { get; private set; }

		public int SubcontrollerIndex { get; private set; }

		public ReferenceHub OwnerHub => Model.OwnerHub;

		public Transform ModelTr => Model.CachedTransform;

		public Animator Animator => Model.Animator;

		protected bool Culled
		{
			get
			{
				if (HasCuller)
				{
					return Culler.IsCulled;
				}
				return false;
			}
		}

		protected CullingSubcontroller Culler { get; private set; }

		protected bool HasCuller { get; private set; }

		protected bool HasOwner => Model.HasOwner;

		public virtual void Init(AnimatedCharacterModel model, int index)
		{
			Model = model;
			SubcontrollerIndex = index;
			if (HasOwner && model.TryGetSubcontroller<CullingSubcontroller>(out var subcontroller))
			{
				Culler = subcontroller;
				HasCuller = true;
			}
			else
			{
				HasCuller = false;
			}
		}

		public virtual void OnReassigned()
		{
		}

		public virtual void ProcessRpc(NetworkReader reader)
		{
		}
	}
}

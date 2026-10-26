using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public class SimpleWearable : DisplayableWearableBase, ISingleObjectWearable
	{
		private Vector3 _parentOriginalScale;

		[field: SerializeField]
		public HumanBodyBones ParentBone { get; private set; }

		public WearableGameObject TargetObject { get; private set; }

		public override void UpdateVisibility()
		{
			base.UpdateVisibility();
			TargetObject.Source.SetActive(base.IsVisible);
		}

		public override void Initialize(WearableSubcontroller model)
		{
			base.Initialize(model);
			TargetObject = new WearableGameObject(base.gameObject);
			Transform boneTransform = model.Animator.GetBoneTransform(ParentBone);
			Transform sourceTr = TargetObject.SourceTr;
			sourceTr.SetParent(boneTransform);
			_parentOriginalScale = sourceTr.localScale;
		}

		public override void SetFade(float fade)
		{
			TargetObject.SourceTr.localScale = _parentOriginalScale * fade;
		}
	}
}

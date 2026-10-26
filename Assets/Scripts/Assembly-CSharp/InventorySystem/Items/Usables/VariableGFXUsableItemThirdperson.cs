using UnityEngine;

namespace InventorySystem.Items.Usables
{
	public class VariableGFXUsableItemThirdperson : UsableItemThirdperson
	{
		[SerializeField]
		private float _replacementTime;

		private float _remainingToReplace;

		private bool _alreadyReplaced;

		private GameObject _lastInstance;

		[field: SerializeField]
		protected GameObject MainGfx { get; private set; }

		[field: SerializeField]
		protected GameObject LeftHandedGfx { get; private set; }

		public override void ResetObject()
		{
			base.ResetObject();
			RestoreMainGfx();
		}

		protected override void Update()
		{
			base.Update();
			if (base.IsUsing && !_alreadyReplaced)
			{
				_remainingToReplace -= Time.deltaTime;
				if (_remainingToReplace < 0f)
				{
					ReplaceGfx();
					_alreadyReplaced = true;
				}
			}
		}

		protected override void OnUsingStatusChanged()
		{
			base.OnUsingStatusChanged();
			if (base.IsUsing)
			{
				_remainingToReplace = _replacementTime;
			}
			else
			{
				RestoreMainGfx();
			}
			_alreadyReplaced = false;
		}

		protected virtual void SetupLeftHandedInstance(GameObject instance, Transform leftHand)
		{
			Transform obj = instance.transform;
			obj.SetParent(leftHand);
			obj.ResetLocalPose();
			instance.SetActive(value: true);
		}

		private void RestoreMainGfx()
		{
			MainGfx.SetActive(value: true);
			if (_alreadyReplaced && _lastInstance != null)
			{
				_lastInstance.transform.SetParent(null);
				_lastInstance.SetActive(value: false);
			}
		}

		private void ReplaceGfx()
		{
			MainGfx.SetActive(value: false);
			if (!(LeftHandedGfx == null))
			{
				if (_lastInstance == null)
				{
					_lastInstance = Object.Instantiate(LeftHandedGfx);
				}
				Transform boneTransform = base.Animator.GetBoneTransform(HumanBodyBones.LeftHand);
				if (boneTransform != null)
				{
					SetupLeftHandedInstance(_lastInstance, boneTransform);
				}
			}
		}
	}
}

using System;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public class OffsetableSimpleWearable : SimpleWearable
	{
		[Serializable]
		private class OffsetConditionPair
		{
			[SerializeField]
			private GameObject _condition;

			[SerializeField]
			private bool _inverseCondition;

			[SerializeField]
			private float _upOffset;

			[SerializeField]
			private float _forwardOffset;

			private bool? _lastActive;

			public void Refresh(OffsetableSimpleWearable wearable)
			{
				bool activeSelf = _condition.activeSelf;
				if (_lastActive != activeSelf)
				{
					Transform sourceTr = wearable.TargetObject.SourceTr;
					Vector3 originalLocalPosition = wearable._originalLocalPosition;
					sourceTr.localPosition = originalLocalPosition;
					if (_inverseCondition ? (!activeSelf) : activeSelf)
					{
						Quaternion rotation = wearable._parent.rotation;
						Vector3 vector = rotation * Vector3.up * _upOffset;
						Vector3 vector2 = rotation * Vector3.forward * _forwardOffset;
						sourceTr.position += vector + vector2;
					}
					_lastActive = activeSelf;
				}
			}
		}

		private Vector3 _originalLocalPosition;

		private Transform _parent;

		[SerializeField]
		private OffsetConditionPair[] _offsets;

		public override void Initialize(WearableSubcontroller model)
		{
			base.Initialize(model);
			Transform sourceTr = base.TargetObject.SourceTr;
			_originalLocalPosition = sourceTr.localPosition;
			_parent = sourceTr.parent;
		}

		private void LateUpdate()
		{
			if (base.IsVisible)
			{
				for (int i = 0; i < _offsets.Length; i++)
				{
					_offsets[i].Refresh(this);
				}
			}
		}
	}
}

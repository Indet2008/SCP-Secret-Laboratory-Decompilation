using InventorySystem.Items.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables;
using UnityEngine;

namespace InventorySystem.Items.Usables
{
	public class UsableWearableThirdperson : UsableItemThirdperson
	{
		[SerializeField]
		private AnimationCurve _positionOverrideWeightOverTime;

		[SerializeField]
		private AnimationCurve _ikWeightOverTime;

		[SerializeField]
		private WearableElements _targetSlot;

		[SerializeField]
		private Vector3 _positionOffset;

		[SerializeField]
		private Vector3 _rotationOffset;

		[SerializeField]
		private Vector3 _scaleMultiplier = Vector3.one;

		[SerializeField]
		private Transform _movable;

		private Vector3 _lPos;

		private Quaternion _lRot;

		private Vector3 _lScale;

		private bool _locationModified;

		private bool _gfxDisabled;

		private float _lastWeight;

		private float _elapsed;

		private GameObject _gfxToDisable;

		private const float RewindTimeSeconds = 0.2f;

		protected override void OnUsingStatusChanged()
		{
			base.OnUsingStatusChanged();
			_elapsed = 0f;
			SetGfxVisibility(isVisible: true);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_elapsed = 0f;
			_lastWeight = 0f;
			UpdateOverrides(0f);
			SetGfxVisibility(isVisible: true);
		}

		public override LookatData ProcessLookat(LookatData data)
		{
			LookatData target = base.ProcessLookat(data);
			return data.LerpTo(target, _ikWeightOverTime.Evaluate(_elapsed));
		}

		public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			ThirdpersonLayerWeight weightForLayer = base.GetWeightForLayer(layer);
			return new ThirdpersonLayerWeight(weightForLayer.Weight * _ikWeightOverTime.Evaluate(_elapsed), weightForLayer.AllowOther);
		}

		protected override void Update()
		{
			base.Update();
			if (base.IsUsing)
			{
				_elapsed += Time.deltaTime;
				_lastWeight = _positionOverrideWeightOverTime.Evaluate(_elapsed);
			}
			else
			{
				float num = Time.deltaTime / 0.2f;
				_lastWeight = Mathf.Clamp01(_lastWeight - num);
			}
			UpdateOverrides(_lastWeight);
		}

		protected override void Awake()
		{
			base.Awake();
			_gfxToDisable = _movable.gameObject;
			_lScale = _movable.localScale;
			_movable.GetLocalPositionAndRotation(out _lPos, out _lRot);
		}

		private void UpdateOverrides(float weight)
		{
			if (_locationModified)
			{
				_movable.localScale = _lScale;
				_movable.SetLocalPositionAndRotation(_lPos, _lRot);
				_locationModified = false;
			}
			if (base.TargetModel.TryGetSubcontroller<WearableSubcontroller>(out var subcontroller) && subcontroller.TryGetWearable<SimpleWearable>(_targetSlot, out var ret))
			{
				WearableGameObject targetObject = ret.TargetObject;
				if (targetObject.Source.activeSelf)
				{
					SetGfxVisibility(isVisible: false);
				}
				if (!(weight <= 0f))
				{
					_movable.GetPositionAndRotation(out var position, out var rotation);
					Transform sourceTr = targetObject.SourceTr;
					position = Vector3.Lerp(position, sourceTr.TransformPoint(_positionOffset), weight);
					rotation = Quaternion.Lerp(rotation, Quaternion.Euler(_rotationOffset) * sourceTr.rotation, weight);
					_movable.SetPositionAndRotation(position, rotation);
					_movable.localScale = Vector3.Lerp(_lScale, Vector3.Scale(targetObject.GlobalScale, _scaleMultiplier), weight);
					_locationModified = true;
				}
			}
		}

		private void SetGfxVisibility(bool isVisible)
		{
			bool flag = !isVisible;
			if (flag != _gfxDisabled)
			{
				_gfxDisabled = flag;
				_gfxToDisable.SetActive(isVisible);
			}
		}
	}
}

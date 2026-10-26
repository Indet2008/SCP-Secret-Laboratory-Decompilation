using InventorySystem.Items.Thirdperson;
using InventorySystem.Items.Thirdperson.LayerProcessors;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Usables
{
	public class UsableItemThirdperson : IdleThirdpersonItem, ILookatModifier
	{
		[SerializeField]
		private AnimationClip _useAnim;

		[SerializeField]
		private HandPoseData _useHandPoseData;

		protected bool IsUsing { get; set; }

		protected float CurWeight { get; set; }

		protected virtual float IncreaseWeightSpeed => 8f;

		protected virtual float DecreaseWeightSpeed => 5f;

		public override void ResetObject()
		{
			base.ResetObject();
			IsUsing = false;
		}

		public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			ThirdpersonLayerWeight weightForLayer = base.GetWeightForLayer(layer);
			return new ThirdpersonLayerWeight(weightForLayer.Weight, !IsUsing && weightForLayer.AllowOther);
		}

		public override HandPoseData ProcessHandPose(HandPoseData data)
		{
			return base.ProcessHandPose(data).LerpTo(_useHandPoseData, CurWeight);
		}

		public virtual LookatData ProcessLookat(LookatData data)
		{
			data.GlobalWeight *= Mathf.Clamp01(1f - CurWeight);
			return data;
		}

		internal override void Initialize(InventorySubcontroller sctrl, ItemIdentifier id)
		{
			base.Initialize(sctrl, id);
			SetAnim(AnimState3p.Override1, _useAnim);
		}

		protected override void Update()
		{
			base.Update();
			if (!base.Pooled)
			{
				if (IsUsing)
				{
					CurWeight += Time.deltaTime * IncreaseWeightSpeed;
				}
				else
				{
					CurWeight -= Time.deltaTime * DecreaseWeightSpeed;
				}
				CurWeight = Mathf.Clamp01(CurWeight);
				base.OverrideBlend = CurWeight;
				if (TryGetLayerProcessor<HybridLayerProcessor>(out var processor))
				{
					processor.SetDualHandBlend(CurWeight);
				}
			}
		}

		protected virtual void OnUsingStatusChanged()
		{
			if (IsUsing)
			{
				ReplayOverrideBlend(soft: true);
			}
		}

		private void OnClientStatusReceived(StatusMessage msg)
		{
			if (msg.ItemSerial == base.ItemId.SerialNumber)
			{
				bool flag = msg.Status == StatusMessage.StatusType.Start;
				if (flag != IsUsing)
				{
					IsUsing = flag;
					OnUsingStatusChanged();
				}
			}
		}

		protected virtual void Awake()
		{
			UsableItemsController.OnClientStatusReceived += OnClientStatusReceived;
		}

		protected virtual void OnDestroy()
		{
			UsableItemsController.OnClientStatusReceived -= OnClientStatusReceived;
		}
	}
}

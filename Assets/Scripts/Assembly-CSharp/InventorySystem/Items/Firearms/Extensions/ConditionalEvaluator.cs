using System;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;

namespace InventorySystem.Items.Firearms.Extensions
{
	[Serializable]
	public class ConditionalEvaluator
	{
		[Serializable]
		public struct AttachmentStatusPair
		{
			public AttachmentLink Link;

			public AttachmentStatus DesiredStatus;
		}

		public enum AttachmentStatus
		{
			Disabled = 0,
			Enabled = 1,
			EnabledAndReady = 2,
			EnabledAndNotReady = 3
		}

		public enum OtherCondition
		{
			Equipped = 0,
			Firstperson = 1,
			Pickup = 2,
			Thirdperson = 3
		}

		public AttachmentStatusPair[] AttachmentConditions;

		public OtherCondition[] OtherConditions;

		public bool Any;

		private bool _worldmodelMode;

		private bool _hasSetter;

		private AnimatorStateSetterModule _setterModule;

		private Firearm _firearm;

		private FirearmWorldmodel _worldmodel;

		public bool Evaluate()
		{
			bool? flag = EvaluateArray(AttachmentConditions, EvaluateAttachmentCondition);
			bool? flag2 = EvaluateArray(OtherConditions, EvaluateModuleCondition);
			if (!flag.HasValue && !flag2.HasValue)
			{
				return true;
			}
			if (Any)
			{
				if (flag != true)
				{
					return flag2 == true;
				}
				return true;
			}
			if (flag ?? true)
			{
				return flag2 ?? true;
			}
			return false;
		}

		public void InitInstance(Firearm instance)
		{
			_firearm = instance;
			_hasSetter = instance.TryGetModule<AnimatorStateSetterModule>(out _setterModule);
			AttachmentStatusPair[] attachmentConditions = AttachmentConditions;
			for (int i = 0; i < attachmentConditions.Length; i++)
			{
				attachmentConditions[i].Link.InitCache(instance);
			}
		}

		public void InitWorldmodel(FirearmWorldmodel worldmodel)
		{
			_worldmodel = worldmodel;
			if ((!_worldmodelMode || !(_worldmodel == worldmodel)) && InventoryItemLoader.TryGetItem<Firearm>(worldmodel.Identifier.TypeId, out var result))
			{
				AttachmentStatusPair[] attachmentConditions = AttachmentConditions;
				for (int i = 0; i < attachmentConditions.Length; i++)
				{
					attachmentConditions[i].Link.InitCache(result);
				}
				_worldmodelMode = true;
			}
		}

		private bool EvaluateAttachmentCondition(AttachmentStatusPair pair)
		{
			AttachmentLink link = pair.Link;
			return pair.DesiredStatus switch
			{
				AttachmentStatus.Enabled => GetEnabled(), 
				AttachmentStatus.Disabled => !GetEnabled(), 
				AttachmentStatus.EnabledAndReady => GetEnabled() && GetReadyFlag(), 
				AttachmentStatus.EnabledAndNotReady => GetEnabled() && !GetReadyFlag(), 
				_ => false, 
			};
			bool GetEnabled()
			{
				if (!_worldmodelMode)
				{
					return link.Instance.IsEnabled;
				}
				return (_worldmodel.AttachmentCode & link.Filter) != 0;
			}
			bool GetReadyFlag()
			{
				if (_hasSetter)
				{
					return _setterModule.GetReadyFlag(link.Instance);
				}
				return false;
			}
		}

		private bool EvaluateModuleCondition(OtherCondition cond)
		{
			IEquipperModule module;
			return cond switch
			{
				OtherCondition.Equipped => _firearm.TryGetModule<IEquipperModule>(out module) && module.IsEquipped, 
				OtherCondition.Pickup => _worldmodelMode && _worldmodel.WorldmodelType == FirearmWorldmodelType.Pickup, 
				OtherCondition.Thirdperson => _worldmodelMode && _worldmodel.WorldmodelType == FirearmWorldmodelType.Thirdperson, 
				OtherCondition.Firstperson => !_worldmodelMode && _firearm.HasViewmodel, 
				_ => false, 
			};
		}

		private bool? EvaluateArray<T>(T[] arr, Predicate<T> evaluator)
		{
			if (arr == null || arr.Length == 0)
			{
				return null;
			}
			foreach (T obj in arr)
			{
				if (evaluator(obj))
				{
					if (Any)
					{
						return true;
					}
				}
				else if (!Any)
				{
					return false;
				}
			}
			return !Any;
		}
	}
}

using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Attachments.Components;
using NorthwoodLib.Pools;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments
{
	public static class AttachmentsUtils
	{
		private static int _paramNumberCache;

		private static AttachmentParameterDefinition[] _cachedDefitionons;

		private static bool[] _readyMixingModes;

		private static bool _mixingModesCacheSet;

		public static int TotalNumberOfParams
		{
			get
			{
				if (_paramNumberCache <= 0)
				{
					_paramNumberCache = EnumUtils<AttachmentParam>.Values.Length;
				}
				return _paramNumberCache;
			}
		}

		public static event Action<Firearm> OnAttachmentsApplied;

		public static uint GetCurrentAttachmentsCode(this Firearm firearm)
		{
			uint num = 1u;
			uint num2 = 0u;
			for (int i = 0; i < firearm.Attachments.Length; i++)
			{
				if (firearm.Attachments[i].IsEnabled)
				{
					num2 += num;
				}
				num *= 2;
			}
			return num2;
		}

		public static uint GetAttachmentId(ItemType firearmType, AttachmentName attachmentName)
		{
			if (!InventoryItemLoader.TryGetItem<Firearm>(firearmType, out var result))
			{
				return 0u;
			}
			uint num = 1u;
			for (int i = 0; i < result.Attachments.Length; i++)
			{
				if (result.Attachments[i].Name == attachmentName)
				{
					return num;
				}
				num *= 2;
			}
			return 0u;
		}

		public static uint GetRandomAttachmentsCode(ItemType firearmType)
		{
			if (!InventoryItemLoader.TryGetItem<Firearm>(firearmType, out var result))
			{
				return 0u;
			}
			int num = result.Attachments.Length;
			bool[] array = new bool[num];
			int num2 = 0;
			while (num2 < num)
			{
				AttachmentSlot slot = result.Attachments[num2].Slot;
				for (int i = num2; i < num; i++)
				{
					if (i + 1 >= num || result.Attachments[i + 1].Slot != slot)
					{
						array[UnityEngine.Random.Range(num2, i + 1)] = true;
						num2 = i + 1;
						break;
					}
				}
			}
			uint num3 = 1u;
			uint num4 = 0u;
			for (int j = 0; j < num; j++)
			{
				if (array[j])
				{
					num4 += num3;
				}
				num3 *= 2;
			}
			return num4;
		}

		public static bool TryGetAttachmentWithId(this Firearm firearm, int id, out Attachment att)
		{
			if (!firearm.TryGetSubcomponentFromId(id, out var subcomponent) || !(subcomponent is Attachment attachment))
			{
				att = null;
				return false;
			}
			att = attachment;
			return true;
		}

		public static float AttachmentsValue(this Firearm firearm, AttachmentParam param)
		{
			AttachmentParameterDefinition definitionOfParam = GetDefinitionOfParam(param);
			float num = definitionOfParam.DefaultValue;
			int num2 = firearm.Attachments.Length;
			for (int i = 0; i < num2; i++)
			{
				Attachment attachment = firearm.Attachments[i];
				if (attachment.IsEnabled && attachment.TryGetActiveValue(param, out var val))
				{
					num = MixValue(num, val, definitionOfParam.MixingMode);
				}
			}
			if (!firearm.HasOwner)
			{
				return num;
			}
			for (int j = 0; j < firearm.Owner.playerEffectsController.EffectsLength; j++)
			{
				if (firearm.Owner.playerEffectsController.AllEffects[j] is IWeaponModifierPlayerEffect { ParamsActive: not false } weaponModifierPlayerEffect && weaponModifierPlayerEffect.TryGetWeaponParam(param, out var val2))
				{
					num = MixValue(num, val2, definitionOfParam.MixingMode);
				}
			}
			return ClampValue(num, definitionOfParam);
		}

		public static float ProcessValue(this Firearm firearm, float value, AttachmentParam param)
		{
			float num = firearm.AttachmentsValue(param);
			return GetDefinitionOfParam(param).MixingMode switch
			{
				ParameterMixingMode.Additive => value + num, 
				ParameterMixingMode.Percent => value * num, 
				ParameterMixingMode.Override => num, 
				_ => value, 
			};
		}

		public static bool HasAdvantageFlag(this Firearm firearm, AttachmentDescriptiveAdvantages flag)
		{
			int num = firearm.Attachments.Length;
			for (int i = 0; i < num; i++)
			{
				Attachment attachment = firearm.Attachments[i];
				if (attachment.IsEnabled && attachment.DescriptivePros.HasFlagFast(flag))
				{
					return true;
				}
			}
			return false;
		}

		public static bool HasDownsideFlag(this Firearm firearm, AttachmentDescriptiveDownsides flag)
		{
			int num = firearm.Attachments.Length;
			for (int i = 0; i < num; i++)
			{
				Attachment attachment = firearm.Attachments[i];
				if (attachment.IsEnabled && attachment.DescriptiveCons.HasFlagFast(flag))
				{
					return true;
				}
			}
			return false;
		}

		public static float MixValue(float originalValue, float modifierValue, ParameterMixingMode mixMode)
		{
			switch (mixMode)
			{
			case ParameterMixingMode.Additive:
				originalValue += modifierValue;
				break;
			case ParameterMixingMode.Percent:
				originalValue += modifierValue - 1f;
				break;
			case ParameterMixingMode.Override:
				originalValue = modifierValue;
				break;
			}
			return originalValue;
		}

		private static float ClampValue(float f, AttachmentParameterDefinition definition)
		{
			return Mathf.Clamp(f, definition.MinValue, definition.MaxValue);
		}

		private static AttachmentParameterDefinition GetDefinitionOfParam(AttachmentParam param)
		{
			if (!_mixingModesCacheSet)
			{
				_cachedDefitionons = new AttachmentParameterDefinition[TotalNumberOfParams];
				_readyMixingModes = new bool[TotalNumberOfParams];
				_mixingModesCacheSet = true;
			}
			if (_readyMixingModes[(int)param])
			{
				return _cachedDefitionons[(int)param];
			}
			if (!AttachmentParameterDefinition.Definitions.TryGetValue(param, out var value))
			{
				throw new Exception($"Parameter {param} is not defined!");
			}
			_readyMixingModes[(int)param] = true;
			_cachedDefitionons[(int)param] = value;
			return value;
		}

		public static void ApplyAttachmentsCode(this Firearm firearm, uint code, bool reValidate)
		{
			if (reValidate)
			{
				code = firearm.ValidateAttachmentsCode(code);
			}
			uint num = 1u;
			for (int i = 0; i < firearm.Attachments.Length; i++)
			{
				firearm.Attachments[i].IsEnabled = (code & num) == num;
				num *= 2;
			}
			SubcomponentBase[] allSubcomponents = firearm.AllSubcomponents;
			for (int j = 0; j < allSubcomponents.Length; j++)
			{
				if (allSubcomponents[j] is FirearmSubcomponentBase firearmSubcomponentBase)
				{
					firearmSubcomponentBase.OnAttachmentsApplied();
				}
			}
			OnAttachmentsApplied?.Invoke(firearm);
		}

		public static uint ValidateAttachmentsCode(this Firearm firearm, uint code)
		{
			uint num = 0u;
			uint num2 = 1u;
			HashSet<AttachmentSlot> hashSet = HashSetPool<AttachmentSlot>.Shared.Rent();
			Attachment[] attachments = firearm.Attachments;
			foreach (Attachment attachment in attachments)
			{
				hashSet.Add(attachment.Slot);
			}
			for (int j = 0; j < firearm.Attachments.Length; j++)
			{
				if ((code & num2) == num2 && hashSet.Remove(firearm.Attachments[j].Slot))
				{
					num += num2;
				}
				num2 *= 2;
			}
			foreach (AttachmentSlot item in hashSet)
			{
				for (int k = 0; k < firearm.Attachments.Length; k++)
				{
					if (item == firearm.Attachments[k].Slot)
					{
						uint num3 = 1u;
						for (int l = 0; l < k; l++)
						{
							num3 *= 2;
						}
						num += num3;
						break;
					}
				}
			}
			HashSetPool<AttachmentSlot>.Shared.Return(hashSet);
			return num;
		}

		public static void GetDefaultLengthAndWeight(this Firearm fa, out float length, out float weight)
		{
			HashSet<AttachmentSlot> hashSet = HashSetPool<AttachmentSlot>.Shared.Rent();
			length = fa.BaseLength;
			weight = fa.BaseWeight;
			for (int i = 0; i < fa.Attachments.Length; i++)
			{
				if (hashSet.Add(fa.Attachments[i].Slot))
				{
					length += fa.Attachments[i].Length;
					weight += fa.Attachments[i].Weight;
				}
			}
			HashSetPool<AttachmentSlot>.Shared.Return(hashSet);
		}

		public static bool HasFlagFast(this AttachmentDescriptiveAdvantages flags, AttachmentDescriptiveAdvantages flag)
		{
			return (flags & flag) == flag;
		}

		public static bool HasFlagFast(this AttachmentDescriptiveDownsides flags, AttachmentDescriptiveDownsides flag)
		{
			return (flags & flag) == flag;
		}
	}
}

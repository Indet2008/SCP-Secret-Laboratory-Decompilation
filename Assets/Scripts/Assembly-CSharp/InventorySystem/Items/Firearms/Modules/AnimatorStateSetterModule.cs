using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Attachments.Components;
using InventorySystem.Items.Firearms.Modules.Misc;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class AnimatorStateSetterModule : ModuleBase
	{
		private static readonly Dictionary<AttachmentSlot, int> SlotHash = new Dictionary<AttachmentSlot, int>();

		private static readonly Dictionary<AttachmentParam, int> ParamHash = new Dictionary<AttachmentParam, int>();

		[SerializeField]
		private AttachmentSlot[] _exposedSlots;

		[SerializeField]
		private AttachmentParam[] _exposedParams;

		[SerializeField]
		private bool _setRoleId;

		private readonly HashSet<Attachment> _activeFlags = new HashSet<Attachment>();

		[ExposedFirearmEvent]
		public void SkipFrames(int frames)
		{
			FirearmEvent currentlyInvokedEvent = FirearmEvent.CurrentlyInvokedEvent;
			if (currentlyInvokedEvent != null)
			{
				float totalSpeedMultiplier = currentlyInvokedEvent.LastInvocation.TotalSpeedMultiplier;
				if (!(totalSpeedMultiplier <= 0f))
				{
					float num = 1f / (currentlyInvokedEvent.Clip.frameRate * totalSpeedMultiplier);
					base.Firearm.AnimForceUpdate(num * (float)frames);
				}
			}
		}

		[ExposedFirearmEvent]
		public void SetAttachmentReady(Attachment attachment)
		{
			_activeFlags.Add(attachment);
		}

		public bool GetReadyFlag(Attachment attachment)
		{
			return _activeFlags.Contains(attachment);
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			ExposeParameters();
			ExposeAttachments();
			if (_setRoleId)
			{
				base.Firearm.AnimSetInt(FirearmAnimatorHashes.RoleId, (int)base.Firearm.Owner.GetRoleId());
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			_activeFlags.Clear();
		}

		private void ExposeParameters()
		{
			AttachmentParam[] exposedParams = _exposedParams;
			foreach (AttachmentParam attachmentParam in exposedParams)
			{
				int hash = EnumToHash(attachmentParam, ParamHash, Animator.StringToHash);
				base.Firearm.AnimSetFloat(hash, base.Firearm.AttachmentsValue(attachmentParam));
			}
		}

		private void ExposeAttachments()
		{
			Attachment[] attachments = base.Firearm.Attachments;
			AttachmentSlot[] exposedSlots = _exposedSlots;
			foreach (AttachmentSlot attachmentSlot in exposedSlots)
			{
				int num = -1;
				for (int j = 0; j < attachments.Length; j++)
				{
					if (attachments[j].Slot == attachmentSlot)
					{
						num++;
						if (attachments[j].IsEnabled)
						{
							break;
						}
					}
				}
				if (num >= 0)
				{
					int hash = EnumToHash(attachmentSlot, SlotHash, GenerateAttachmentIdHash);
					base.Firearm.AnimSetInt(hash, num);
				}
			}
		}

		private static int GenerateAttachmentIdHash(string enumName)
		{
			return Animator.StringToHash(enumName + "Id");
		}

		private static int EnumToHash<T>(T enumValue, Dictionary<T, int> cache, Func<string, int> hashFunc) where T : struct, Enum, IConvertible
		{
			if (!cache.TryGetValue(enumValue, out var value))
			{
				int num = enumValue.ToInt32(null);
				value = (cache[enumValue] = hashFunc(EnumUtils<T>.Names[num]));
			}
			return value;
		}
	}
}

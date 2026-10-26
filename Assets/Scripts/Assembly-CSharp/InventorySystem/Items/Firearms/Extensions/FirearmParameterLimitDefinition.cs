using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Attachments.Components;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public readonly struct FirearmParameterLimitDefinition
	{
		private static readonly Dictionary<ItemType, FirearmParameterLimitDefinition> CachedDefinitions = new Dictionary<ItemType, FirearmParameterLimitDefinition>();

		public readonly Firearm Template;

		public readonly float Lightest;

		public readonly float Shortest;

		public readonly float Heaviest;

		public readonly float Longest;

		private FirearmParameterLimitDefinition(Firearm template)
		{
			Template = template;
			GetFirearmRamapValues(template, out Lightest, out Shortest, out Heaviest, out Longest);
		}

		public static FirearmParameterLimitDefinition Get(ItemType firearmType)
		{
			if (CachedDefinitions.TryGetValue(firearmType, out var value))
			{
				return value;
			}
			if (!InventoryItemLoader.TryGetItem<Firearm>(firearmType, out var result))
			{
				throw new InvalidOperationException($"Supplied firearmType '{firearmType}' did not represent a Firearm item");
			}
			value = new FirearmParameterLimitDefinition(result);
			CachedDefinitions.Add(firearmType, value);
			return value;
		}

		private static void GetFirearmRamapValues(Firearm firearm, out float lightest, out float shortest, out float heaviest, out float longest)
		{
			lightest = firearm.BaseWeight;
			shortest = firearm.BaseLength;
			heaviest = firearm.BaseWeight;
			longest = firearm.BaseLength;
			AttachmentSlot[] values = EnumUtils<AttachmentSlot>.Values;
			foreach (AttachmentSlot slot in values)
			{
				if (TryGetSlotRamapValues(firearm, slot, out var lightest2, out var shortest2, out var heaviest2, out var longest2))
				{
					lightest += lightest2;
					shortest += shortest2;
					heaviest += heaviest2;
					longest += longest2;
				}
			}
		}

		private static bool TryGetSlotRamapValues(Firearm firearm, AttachmentSlot slot, out float lightest, out float shortest, out float heaviest, out float longest)
		{
			lightest = float.MaxValue;
			shortest = float.MaxValue;
			heaviest = float.MinValue;
			longest = float.MinValue;
			bool result = false;
			Attachment[] attachments = firearm.Attachments;
			foreach (Attachment attachment in attachments)
			{
				if (attachment.Slot == slot)
				{
					result = true;
					lightest = Mathf.Min(lightest, attachment.Weight);
					shortest = Mathf.Min(shortest, attachment.Length);
					heaviest = Mathf.Max(heaviest, attachment.Weight);
					longest = Mathf.Max(longest, attachment.Length);
				}
			}
			return result;
		}
	}
}

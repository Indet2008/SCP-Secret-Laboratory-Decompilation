using System.Collections.Generic;
using System.Linq;
using InventorySystem.Items.Firearms.Attachments.Components;
using UnityEngine;

namespace InventorySystem.Items.Firearms
{
	public static class FirearmUtils
	{
		private static readonly Dictionary<RuntimeAnimatorController, HashSet<int>> ExistingHashes = new Dictionary<RuntimeAnimatorController, HashSet<int>>();

		public static void AnimSetInt(this Firearm fa, int hash, int i, bool checkIfExists = false)
		{
			if (!checkIfExists || HasParam(fa, hash))
			{
				if (fa.IsServer)
				{
					fa.ServerSideAnimator.SetInteger(hash, i);
				}
				if (fa.HasViewmodel)
				{
					fa.ClientViewmodelInstance.AnimatorSetInt(hash, i);
				}
			}
		}

		public static void AnimSetFloat(this Firearm fa, int hash, float f, bool checkIfExists = false)
		{
			if (!checkIfExists || HasParam(fa, hash))
			{
				if (fa.IsServer)
				{
					fa.ServerSideAnimator.SetFloat(hash, f);
				}
				if (fa.HasViewmodel)
				{
					fa.ClientViewmodelInstance.AnimatorSetFloat(hash, f);
				}
			}
		}

		public static void AnimSetBool(this Firearm fa, int hash, bool b, bool checkIfExists = false)
		{
			if (!checkIfExists || HasParam(fa, hash))
			{
				if (fa.IsServer)
				{
					fa.ServerSideAnimator.SetBool(hash, b);
				}
				if (fa.HasViewmodel)
				{
					fa.ClientViewmodelInstance.AnimatorSetBool(hash, b);
				}
			}
		}

		public static void AnimSetTrigger(this Firearm fa, int hash, bool checkIfExists = false)
		{
			if (!checkIfExists || HasParam(fa, hash))
			{
				if (fa.IsServer)
				{
					fa.ServerSideAnimator.SetTrigger(hash);
				}
				if (fa.HasViewmodel)
				{
					fa.ClientViewmodelInstance.AnimatorSetTrigger(hash);
				}
			}
		}

		public static AnimatorStateInfo AnimGetCurStateInfo(this Firearm fa, int layer)
		{
			if (fa.IsServer)
			{
				return fa.ServerSideAnimator.GetCurrentAnimatorStateInfo(layer);
			}
			if (fa.HasViewmodel)
			{
				return fa.ClientViewmodelInstance.AnimatorStateInfo(layer);
			}
			return default;
		}

		public static void AnimForceUpdate(this Firearm fa, float deltaTime)
		{
			if (fa.IsServer)
			{
				fa.ServerSideAnimator.Update(deltaTime);
			}
			if (fa.HasViewmodel)
			{
				fa.ClientViewmodelInstance.AnimatorForceUpdate(deltaTime);
			}
		}

		public static float TotalWeightKg(this Firearm fa)
		{
			float num = fa.BaseWeight;
			Attachment[] attachments = fa.Attachments;
			foreach (Attachment attachment in attachments)
			{
				if (attachment.IsEnabled)
				{
					num += attachment.Weight;
				}
			}
			return num;
		}

		public static float TotalLengthInches(this Firearm fa)
		{
			float num = fa.BaseLength;
			Attachment[] attachments = fa.Attachments;
			foreach (Attachment attachment in attachments)
			{
				if (attachment.IsEnabled)
				{
					num += attachment.Length;
				}
			}
			return num;
		}

		private static bool HasParam(Firearm fa, int hash)
		{
			Animator anim = fa.ServerSideAnimator;
			RuntimeAnimatorController runtimeAnimatorController = anim.runtimeAnimatorController;
			return ExistingHashes.GetOrAdd(runtimeAnimatorController, () => anim.parameters.Select((AnimatorControllerParameter x) => x.nameHash).ToHashSet()).Contains(hash);
		}
	}
}

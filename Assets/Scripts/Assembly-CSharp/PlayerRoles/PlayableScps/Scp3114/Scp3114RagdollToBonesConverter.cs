using System.Collections.Generic;
using Mirror;
using PlayerRoles.Ragdolls;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114RagdollToBonesConverter : SubroutineBase
	{
		[SerializeField]
		private GameObject[] _boneParts;

		private DynamicRagdoll _syncRagdoll;

		private static bool _cacheSet;

		private static string[] _cachedNames;

		private static GameObject[] _cachedTemplates;

		private static readonly List<Transform> ReplacementTransforms = new List<Transform>();

		private static readonly List<Rigidbody> ReplacementRbs = new List<Rigidbody>();

		public static void ConvertExisting(DynamicRagdoll ragdoll)
		{
			if (!_cacheSet)
			{
				if (!TryPrepCache())
				{
					return;
				}
				_cacheSet = true;
			}
			Transform transform = ragdoll.transform;
			int childCount = transform.childCount;
			for (int i = 0; i < childCount; i++)
			{
				Object.Destroy(transform.GetChild(i).gameObject);
			}
			ReplacementRbs.Clear();
			ReplacementTransforms.Clear();
			Transform[] linkedRigidbodiesTransforms = ragdoll.LinkedRigidbodiesTransforms;
			int num = linkedRigidbodiesTransforms.Length;
			for (int j = 0; j < num; j++)
			{
				string text = linkedRigidbodiesTransforms[j].name.ToLowerInvariant();
				for (int k = 0; k < _cachedNames.Length; k++)
				{
					if (text.Contains(_cachedNames[k]))
					{
						ProcessNameMatch(ragdoll, linkedRigidbodiesTransforms[j], _cachedTemplates[k]);
						break;
					}
				}
			}
			ragdoll.Hitboxes = new HitboxData[0];
			ragdoll.LinkedRigidbodies = ReplacementRbs.ToArray();
			ragdoll.LinkedRigidbodiesTransforms = ReplacementTransforms.ToArray();
			if (ragdoll is AutoHumanRagdoll autoHumanRagdoll)
			{
				autoHumanRagdoll.PauseBoneMatching = true;
			}
			if (ragdoll.TryGetComponent<Collider>(out var component))
			{
				component.enabled = false;
			}
			if (ragdoll.TryGetComponent<Rigidbody>(out var component2))
			{
				component2.isKinematic = true;
			}
		}

		public static void ServerConvertNew(Scp3114Role scp, DynamicRagdoll ragdoll)
		{
			if (scp.SubroutineModule.TryGetSubroutine<Scp3114RagdollToBonesConverter>(out var subroutine))
			{
				RagdollData info = ragdoll.Info;
				ragdoll.NetworkInfo = new RagdollData(info.OwnerHub, new Scp3114DamageHandler(ragdoll, isStarting: false), info.RoleType, info.StartRelativePosition, info.StartRelativeRotation, info.Nickname, info.CreationTime);
				subroutine._syncRagdoll = ragdoll;
				subroutine.ServerSendRpc(toAll: true);
			}
		}

		private static bool TryPrepCache()
		{
			if (!RoleTypeId.Scp3114.TryGetRoleTemplate<Scp3114Role>(out var result))
			{
				return false;
			}
			if (!result.SubroutineModule.TryGetSubroutine<Scp3114RagdollToBonesConverter>(out var subroutine))
			{
				return false;
			}
			_cachedTemplates = subroutine._boneParts;
			_cachedNames = new string[_cachedTemplates.Length];
			for (int i = 0; i < _cachedTemplates.Length; i++)
			{
				_cachedNames[i] = _cachedTemplates[i].name.ToLowerInvariant();
			}
			return true;
		}

		private static void ProcessNameMatch(DynamicRagdoll ragdoll, Transform ragdollPart, GameObject matchedBone)
		{
			Transform transform = matchedBone.transform;
			GameObject obj = Object.Instantiate(matchedBone, ragdoll.transform);
			obj.SetActive(value: true);
			Rigidbody component = obj.GetComponent<Rigidbody>();
			Transform transform2 = obj.transform;
			ReplacementRbs.Add(component);
			ReplacementTransforms.Add(transform2);
			transform2.SetPositionAndRotation(ragdollPart.TransformPoint(transform.localPosition), ragdollPart.rotation * transform.localRotation);
			if (ragdollPart.TryGetComponent<Rigidbody>(out var component2))
			{
				component.linearVelocity = component2.linearVelocity;
				component.angularVelocity = component2.angularVelocity;
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteNetworkBehaviour(_syncRagdoll);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncRagdoll = reader.ReadNetworkBehaviour<DynamicRagdoll>();
			if (!(_syncRagdoll == null))
			{
				ConvertExisting(_syncRagdoll);
			}
		}
	}
}

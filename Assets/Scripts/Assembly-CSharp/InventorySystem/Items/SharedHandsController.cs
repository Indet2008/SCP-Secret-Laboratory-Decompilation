using System;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items
{
	public class SharedHandsController : MonoBehaviour
	{
		[Serializable]
		private struct TeamOverride
		{
			public Team Team;

			public HandsVisuals Visuals;
		}

		[Serializable]
		private struct RoleOverride
		{
			public RoleTypeId Role;

			public HandsVisuals Visuals;
		}

		[Serializable]
		public struct HandsVisuals
		{
			public Material FleshMaterial;

			public Material SleeveMaterial;

			public Renderer[] FleshRenderers;

			public Renderer[] SleeveRenderers;

			public readonly void Disable()
			{
				Renderer[] fleshRenderers = FleshRenderers;
				for (int i = 0; i < fleshRenderers.Length; i++)
				{
					fleshRenderers[i].gameObject.SetActive(value: false);
				}
				fleshRenderers = SleeveRenderers;
				for (int i = 0; i < fleshRenderers.Length; i++)
				{
					fleshRenderers[i].gameObject.SetActive(value: false);
				}
			}

			public readonly void Select()
			{
				Renderer[] fleshRenderers = FleshRenderers;
				foreach (Renderer obj in fleshRenderers)
				{
					obj.sharedMaterial = FleshMaterial;
					obj.gameObject.SetActive(value: true);
				}
				fleshRenderers = SleeveRenderers;
				foreach (Renderer obj2 in fleshRenderers)
				{
					obj2.sharedMaterial = SleeveMaterial;
					obj2.gameObject.SetActive(value: true);
				}
			}

			public readonly void SetOverrideTexture(Material materialOverride)
			{
				FleshRenderers.ForEach((Renderer r) =>
				{
					r.sharedMaterial = materialOverride;
				});
				SleeveRenderers.ForEach((Renderer r) =>
				{
					r.sharedMaterial = materialOverride;
				});
			}

			public readonly void SetDefaultTextures()
			{
				Material fleshMaterial = FleshMaterial;
				Material sleeveMaterial = SleeveMaterial;
				FleshRenderers.ForEach((Renderer r) =>
				{
					r.sharedMaterial = fleshMaterial;
				});
				SleeveRenderers.ForEach((Renderer r) =>
				{
					r.sharedMaterial = sleeveMaterial;
				});
			}
		}

		[Serializable]
		private struct IKWristArmPair
		{
			public Transform Wrist;

			public Transform Forearm;

			public Vector3 WristOffset;

			public Transform MovablePart;

			public readonly void UpdateIK()
			{
				Vector3 position = Wrist.position;
				Vector3 vector = Forearm.TransformPoint(WristOffset) - position;
				Vector3 position2 = MovablePart.position;
				if (!float.IsNaN(position2.x))
				{
					MovablePart.position = position2 - vector;
				}
			}
		}

		public static Action<HandsVisuals> OnHandsSet;

		public static Action<HandsVisuals> OnHandsReset;

		public Animator Hands;

		private Transform _trackedPosition;

		private static bool _eventAssigned;

		private static bool _singletonSet;

		[SerializeField]
		private HandsVisuals _defaultVisuals;

		[SerializeField]
		private TeamOverride[] _teamOverrides;

		[SerializeField]
		private RoleOverride[] _roleOverrides;

		[SerializeField]
		private IKWristArmPair[] _ikWrists;

		private HandsVisuals? _lastSet;

		public static SharedHandsController Singleton { get; private set; }

		public HandsVisuals? LastHandVisuals => _lastSet;

		public static void UpdateInstance(ItemViewmodelBase ivb)
		{
			if (_singletonSet)
			{
				if (ivb is AnimatedViewmodelBase animatedViewmodelBase && animatedViewmodelBase != null && !animatedViewmodelBase.DisableSharedHands)
				{
					Singleton.Hands.gameObject.SetActive(value: true);
					Singleton.Hands.avatar = animatedViewmodelBase.AnimatorAvatar;
					Singleton.Hands.runtimeAnimatorController = animatedViewmodelBase.AnimatorRuntimeController;
					Singleton._trackedPosition = animatedViewmodelBase.AnimatorTransform;
					Singleton.Hands.Rebind();
				}
				else
				{
					Singleton.Hands.gameObject.SetActive(value: false);
				}
			}
		}

		private void LateUpdate()
		{
			UpdateTrackedPosition();
			IKWristArmPair[] ikWrists = _ikWrists;
			foreach (IKWristArmPair iKWristArmPair in ikWrists)
			{
				iKWristArmPair.UpdateIK();
			}
		}

		private void UpdateTrackedPosition()
		{
			if (!(_trackedPosition == null))
			{
				Hands.transform.localScale = _trackedPosition.localScale;
				Hands.transform.SetPositionAndRotation(_trackedPosition.position, _trackedPosition.rotation);
			}
		}

		private void Awake()
		{
			Singleton = this;
			_singletonSet = true;
			Hands.fireEvents = false;
			AnimatedViewmodelBase.OnSwayUpdated += UpdateTrackedPosition;
			if (!_eventAssigned)
			{
				PlayerRoleManager.OnRoleChanged += RoleChanged;
				_eventAssigned = true;
			}
		}

		private void OnDestroy()
		{
			AnimatedViewmodelBase.OnSwayUpdated -= UpdateTrackedPosition;
			_singletonSet = false;
		}

		private static void RoleChanged(ReferenceHub hub, PlayerRoleBase oldRole, PlayerRoleBase newRole)
		{
			if (hub.isLocalPlayer && !(Singleton == null))
			{
				SetRoleGloves(newRole.RoleTypeId);
			}
		}

		private void SetVisuals(HandsVisuals visuals)
		{
			_lastSet?.Disable();
			if (_lastSet.HasValue)
			{
				OnHandsReset?.Invoke(_lastSet.Value);
			}
			_lastSet = visuals;
			visuals.Select();
			OnHandsSet?.Invoke(visuals);
		}

		private void SetVisuals(RoleTypeId role, Team team)
		{
			_defaultVisuals.Disable();
			RoleOverride[] roleOverrides = _roleOverrides;
			for (int i = 0; i < roleOverrides.Length; i++)
			{
				RoleOverride roleOverride = roleOverrides[i];
				if (roleOverride.Role == role)
				{
					SetVisuals(roleOverride.Visuals);
					return;
				}
			}
			TeamOverride[] teamOverrides = _teamOverrides;
			for (int i = 0; i < teamOverrides.Length; i++)
			{
				TeamOverride teamOverride = teamOverrides[i];
				if (teamOverride.Team == team)
				{
					SetVisuals(teamOverride.Visuals);
					return;
				}
			}
			SetVisuals(_defaultVisuals);
		}

		public static void SetRoleGloves(RoleTypeId id)
		{
			Singleton.SetVisuals(id, id.GetTeam());
		}
	}
}

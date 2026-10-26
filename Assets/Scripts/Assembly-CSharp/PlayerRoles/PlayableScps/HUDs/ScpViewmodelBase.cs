using System;
using CameraShaking;
using InventorySystem.Items;
using InventorySystem.Items.SwayControllers;
using UnityEngine;

namespace PlayerRoles.PlayableScps.HUDs
{
	public abstract class ScpViewmodelBase : MonoBehaviour
	{
		private bool _destroyed;

		private GoopSway _sway;

		[SerializeField]
		private Vector3 _localRotation;

		[SerializeField]
		private Vector3 _trackerOffset;

		[SerializeField]
		private Transform _cameraBone;

		[SerializeField]
		private GoopSway.GoopSwaySettings _swaySettings;

		public abstract float CamFOV { get; }

		protected ScpHudBase Hud { get; private set; }

		protected ReferenceHub Owner { get; private set; }

		protected PlayerRoleBase Role { get; private set; }

		[field: SerializeField]
		protected Animator Anim { get; private set; }

		protected virtual void Start()
		{
			ScpHudBase component = null;
			Transform parent = base.transform;
			while (!parent.TryGetComponent<ScpHudBase>(out component))
			{
				parent = parent.parent;
				if (parent == null)
				{
					throw new NullReferenceException(string.Format("{0} failed to get component {1} for game object {2}", this, "ScpHudBase", base.name));
				}
			}
			Hud = component;
			Owner = Hud.Hub;
			Role = Owner.roleManager.CurrentRole;
			Transform obj = base.transform;
			Transform transform = SharedHandsController.Singleton.transform;
			obj.SetParent(transform);
			obj.localScale = Vector3.one;
			obj.localEulerAngles = _localRotation;
			obj.position += transform.position - _cameraBone.position;
			Hud.OnDestroyed += DestroySelf;
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			_sway = new GoopSway(_swaySettings, Owner);
			CameraShakeController.AddEffect(new TrackerShake(_cameraBone, _trackerOffset));
		}

		protected virtual void SkipAnimations(float totalTime, int steps = 3)
		{
			totalTime -= Time.deltaTime;
			Anim.Update(Time.deltaTime);
			UpdateAnimations();
			totalTime /= (float)steps;
			for (int i = 0; i < steps; i++)
			{
				Anim.Update(totalTime);
			}
		}

		protected virtual void OnDestroy()
		{
			_destroyed = true;
			if (Hud != null)
			{
				Hud.OnDestroyed -= DestroySelf;
			}
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
		}

		protected virtual void LateUpdate()
		{
			UpdateAnimations();
			_sway.UpdateSway();
		}

		protected abstract void UpdateAnimations();

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase oldRole, PlayerRoleBase newRole)
		{
			if (!(hub != Owner))
			{
				DestroySelf();
			}
		}

		private void DestroySelf()
		{
			if (!_destroyed)
			{
				UnityEngine.Object.Destroy(base.gameObject);
				_destroyed = true;
			}
		}
	}
}

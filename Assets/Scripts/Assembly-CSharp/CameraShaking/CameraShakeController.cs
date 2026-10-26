using System.Collections.Generic;
using InventorySystem.Items;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace CameraShaking
{
	public class CameraShakeController : MonoBehaviour
	{
		[SerializeField]
		private Camera _camera;

		private Vector3 _startPos;

		private Transform _viewmodelRoot;

		private readonly List<IShakeEffect> _effects = new List<IShakeEffect>();

		public static CameraShakeController Singleton;

		public float CamerasFOV
		{
			get
			{
				return _camera.fieldOfView;
			}
			private set
			{
				_camera.fieldOfView = value;
			}
		}

		public static bool CheckEffect(IShakeEffect effect)
		{
			return Singleton._effects.Contains(effect);
		}

		public static void AddEffect(IShakeEffect effect)
		{
			Singleton._effects.Add(effect);
		}

		private void Start()
		{
			_startPos = base.transform.localPosition;
			Singleton = this;
			_viewmodelRoot = GetComponentInChildren<SharedHandsController>().transform;
		}

		private void OnDisable()
		{
			_effects.Clear();
		}

		private void LateUpdate()
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return;
			}
			if (_effects.Count == 0)
			{
				if (hub.inventory.CurInstance is IZoomModifyingItem zoomModifyingItem)
				{
					CamerasFOV = 70f / zoomModifyingItem.ZoomAmount;
				}
				return;
			}
			HashSet<float> hashSet = HashSetPool<float>.Shared.Rent();
			Quaternion identity = Quaternion.identity;
			Quaternion identity2 = Quaternion.identity;
			Vector3 startPos = _startPos;
			for (int num = _effects.Count - 1; num >= 0; num--)
			{
				if (!_effects[num].GetEffect(hub, out var shakeValues))
				{
					_effects.RemoveAt(num);
				}
				else
				{
					if (shakeValues.FovPercent != 1f)
					{
						hashSet.Add(shakeValues.FovPercent);
					}
					if (FpcMouseLook.TryGetLocalMouseLook(out var ml))
					{
						if (shakeValues.HorizontalMouseLook != 0f)
						{
							ml.CurrentHorizontal += shakeValues.HorizontalMouseLook;
						}
						if (shakeValues.VerticalMouseLook != 0f)
						{
							ml.CurrentVertical += shakeValues.VerticalMouseLook;
						}
					}
					identity *= shakeValues.RootCameraRotation;
					startPos += shakeValues.RootCameraPositionOffset;
					identity2 *= shakeValues.ViewmodelCameraRotation;
				}
			}
			if (hashSet.Count > 0)
			{
				float num2 = 0f;
				foreach (float item in hashSet)
				{
					num2 += item - 1f;
				}
				CamerasFOV = 70f * (num2 + 1f);
			}
			else
			{
				CamerasFOV = 70f;
			}
			if (hub.inventory.CurInstance is IZoomModifyingItem zoomModifyingItem2)
			{
				CamerasFOV /= zoomModifyingItem2.ZoomAmount;
			}
			HashSetPool<float>.Shared.Return(hashSet);
			base.transform.SetLocalPositionAndRotation(Vector3.zero, identity);
			base.transform.position += startPos;
			_viewmodelRoot.localRotation = identity2;
		}
	}
}

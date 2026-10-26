using System;
using System.Collections.Generic;
using MapGeneration;
using MapGeneration.StaticHelpers;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079.Cameras
{
	public class Scp079Camera : Scp079InteractableBase, IAdvancedCameraController, ICameraController, IBlockStaticBatching
	{
		public bool IsMain;

		public string Label;

		public CameraRotationAxis VerticalAxis;

		public CameraRotationAxis HorizontalAxis;

		public CameraZoomAxis ZoomAxis;

		public Transform CameraAnchor;

		[SerializeField]
		private Renderer[] _targetRenderers;

		[SerializeField]
		private Material _offlineMat;

		[SerializeField]
		private Material _onlineMat;

		private bool _isActive;

		public bool IsActive
		{
			get
			{
				return _isActive;
			}
			set
			{
				if (value != _isActive)
				{
					_isActive = value;
					Renderer[] targetRenderers = _targetRenderers;
					for (int i = 0; i < targetRenderers.Length; i++)
					{
						targetRenderers[i].sharedMaterial = (_isActive ? _onlineMat : _offlineMat);
					}
					OnAnyCameraStateChanged?.Invoke(this);
					OnCameraStateChanged?.Invoke(this);
				}
			}
		}

		public bool IsUsedByLocalPlayer
		{
			get
			{
				if (Scp079Role.LocalInstanceActive)
				{
					return Scp079Role.LocalInstance.CurrentCamera == this;
				}
				return false;
			}
		}

		public Vector3 CameraPosition { get; private set; }

		public float VerticalRotation { get; private set; }

		public float HorizontalRotation { get; private set; }

		public float RollRotation { get; private set; }

		[field: SerializeField]
		public bool IsToy { get; private set; }

		public static event Action<Scp079Camera> OnInstanceCreated;

		public static event Action<Scp079Camera> OnInstanceRemoved;

		public static event Action<Scp079Camera> OnAnyCameraStateChanged;

		public event Action<Scp079Camera> OnCameraStateChanged;

		protected override void Awake()
		{
			base.Awake();
			VerticalAxis.Awake(this);
			HorizontalAxis.Awake(this);
			ZoomAxis.Awake(this);
		}

		private void Start()
		{
			OnInstanceCreated?.Invoke(this);
		}

		internal void WriteAxes(NetworkWriter writer)
		{
			writer.WriteUShort(VerticalAxis.Value16BitCompression);
			writer.WriteUShort(HorizontalAxis.Value16BitCompression);
			writer.WriteByte(ZoomAxis.Value8BitCompression);
		}

		internal void ApplyAxes(NetworkReader reader)
		{
			if (!IsUsedByLocalPlayer)
			{
				VerticalAxis.Value16BitCompression = reader.ReadUShort();
				HorizontalAxis.Value16BitCompression = reader.ReadUShort();
				ZoomAxis.Value8BitCompression = reader.ReadByte();
			}
		}

		protected virtual void Update()
		{
			VerticalAxis.Update(this);
			HorizontalAxis.Update(this);
			ZoomAxis.Update(this);
			if (IsActive)
			{
				if (Scp079Role.ActiveInstances.All((Scp079Role x) => x.CurrentCamera != this))
				{
					IsActive = false;
					return;
				}
				Vector3 eulerAngles = CameraAnchor.rotation.eulerAngles;
				VerticalRotation = eulerAngles.x;
				HorizontalRotation = eulerAngles.y;
				RollRotation = eulerAngles.z;
				CameraPosition = CameraAnchor.position;
			}
		}

		public static bool TryGetClosestCamera(Vector3 pos, Func<Scp079Camera, bool> validator, out Scp079Camera closest)
		{
			closest = null;
			float num = float.MaxValue;
			bool result = false;
			foreach (Scp079InteractableBase allInstance in Scp079InteractableBase.AllInstances)
			{
				if (allInstance is Scp079Camera scp079Camera && (validator == null || validator(scp079Camera)))
				{
					float sqrMagnitude = (scp079Camera.Position - pos).sqrMagnitude;
					if (!(num < sqrMagnitude))
					{
						result = true;
						closest = scp079Camera;
						num = sqrMagnitude;
					}
				}
			}
			return result;
		}

		public static bool TryGetMainCamera(RoomIdentifier room, out Scp079Camera main)
		{
			foreach (Scp079InteractableBase allInstance in Scp079InteractableBase.AllInstances)
			{
				if (allInstance is Scp079Camera { IsMain: not false } scp079Camera && !(scp079Camera.Room != room))
				{
					main = scp079Camera;
					return true;
				}
			}
			main = null;
			return false;
		}

		public static List<Scp079Camera> GetRoomCameras(RoomIdentifier room)
		{
			List<Scp079Camera> list = new List<Scp079Camera>();
			foreach (Scp079InteractableBase allInstance in Scp079InteractableBase.AllInstances)
			{
				if (allInstance is Scp079Camera scp079Camera && !(scp079Camera.Room != room))
				{
					list.Add(scp079Camera);
				}
			}
			return list;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			OnInstanceRemoved?.Invoke(this);
		}
	}
}

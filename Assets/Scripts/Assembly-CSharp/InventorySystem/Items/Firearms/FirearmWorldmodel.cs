using System;
using System.Collections.Generic;
using System.Linq;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Extensions;
using UnityEngine;

namespace InventorySystem.Items.Firearms
{
	public class FirearmWorldmodel : MonoBehaviour
	{
		public static readonly Dictionary<ushort, FirearmWorldmodel> Instances = new Dictionary<ushort, FirearmWorldmodel>();

		private Dictionary<Renderer, int> _prevLayers;

		private const int HitboxLayer = 13;

		public ItemIdentifier Identifier { get; private set; }

		public uint AttachmentCode { get; private set; }

		public FirearmWorldmodelType WorldmodelType { get; private set; }

		[field: SerializeField]
		[field: LabelledAttachmentArray]
		public AttachmentGameObjectGroup[] Attachments { get; private set; }

		[field: SerializeField]
		public Component[] Extensions { get; private set; }

		[field: SerializeField]
		public Collider[] Colliders { get; private set; }

		[field: SerializeField]
		public Renderer[] Renderers { get; private set; }

		public static event Action<FirearmWorldmodel> OnSetup;

		private void Unlink()
		{
			if (Instances.TryGetValue(Identifier.SerialNumber, out var value) && !(value != this))
			{
				Instances.Remove(Identifier.SerialNumber);
			}
		}

		private void OnDestroy()
		{
			Unlink();
			Component[] extensions = Extensions;
			for (int i = 0; i < extensions.Length; i++)
			{
				if (extensions[i] is IDestroyExtensionReceiver destroyExtensionReceiver)
				{
					destroyExtensionReceiver.OnDestroyExtension();
				}
			}
		}

		private void OnValidate()
		{
			Colliders = GetComponentsInChildren<Collider>(includeInactive: true);
			Renderers = GetComponentsInChildren<Renderer>(includeInactive: true);
			Extensions = (from x in GetComponentsInChildren<Component>(includeInactive: true)
				where x is IWorldmodelExtension
				select x).ToArray();
		}

		private void UpdateWorldmodelContext()
		{
			bool flag;
			bool flag2;
			switch (WorldmodelType)
			{
			default:
				return;
			case FirearmWorldmodelType.Pickup:
				flag = true;
				flag2 = false;
				break;
			case FirearmWorldmodelType.Thirdperson:
				flag = false;
				flag2 = true;
				break;
			case FirearmWorldmodelType.Presentation:
				flag = false;
				flag2 = false;
				break;
			}
			Collider[] colliders = Colliders;
			for (int i = 0; i < colliders.Length; i++)
			{
				colliders[i].enabled = flag;
			}
			Renderer[] renderers;
			if (!flag2)
			{
				if (_prevLayers == null)
				{
					return;
				}
				renderers = Renderers;
				foreach (Renderer renderer in renderers)
				{
					if (_prevLayers.TryGetValue(renderer, out var value))
					{
						renderer.gameObject.layer = value;
					}
				}
				return;
			}
			if (_prevLayers == null)
			{
				_prevLayers = new Dictionary<Renderer, int>();
			}
			renderers = Renderers;
			foreach (Renderer renderer2 in renderers)
			{
				if (renderer2 is MeshRenderer || renderer2 is SkinnedMeshRenderer)
				{
					GameObject gameObject = renderer2.gameObject;
					_prevLayers[renderer2] = gameObject.layer;
					gameObject.layer = 13;
				}
			}
		}

		public void Setup(ItemIdentifier identifier, FirearmWorldmodelType worldmodelType)
		{
			if (!AttachmentCodeSync.TryGet(identifier.SerialNumber, out var code))
			{
				if (!InventoryItemLoader.TryGetItem<Firearm>(identifier.TypeId, out var result))
				{
					return;
				}
				code = result.ValidateAttachmentsCode(0u);
			}
			Setup(identifier, worldmodelType, code);
		}

		public void Setup(ItemIdentifier identifier, FirearmWorldmodelType worldmodelType, uint attachmentCode)
		{
			if (Identifier != identifier)
			{
				Unlink();
			}
			Identifier = identifier;
			Instances[Identifier.SerialNumber] = this;
			if (WorldmodelType != worldmodelType)
			{
				WorldmodelType = worldmodelType;
				UpdateWorldmodelContext();
			}
			AttachmentCode = attachmentCode;
			AttachmentGameObjectGroup[] attachments = Attachments;
			foreach (AttachmentGameObjectGroup attachmentGameObjectGroup in attachments)
			{
				attachmentGameObjectGroup.SetActive(state: false);
			}
			uint num = 1u;
			for (int j = 0; j < Attachments.Length; j++)
			{
				if ((attachmentCode & num) == num)
				{
					Attachments[j].SetActive(state: true);
				}
				num *= 2;
			}
			Component[] extensions = Extensions;
			for (int i = 0; i < extensions.Length; i++)
			{
				(extensions[i] as IWorldmodelExtension).SetupWorldmodel(this);
			}
			OnSetup?.Invoke(this);
		}

		public bool TryGetExtension<T>(out T extension)
		{
			Component[] extensions = Extensions;
			for (int i = 0; i < extensions.Length; i++)
			{
				if (extensions[i] is T val)
				{
					extension = val;
					return true;
				}
			}
			extension = default;
			return false;
		}
	}
}

using GameObjectPools;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public class WearableSubcontroller : SubcontrollerBehaviour, IPoolResettable
	{
		private WearableElements? _syncWearable;

		[field: SerializeField]
		public DisplayableWearableBase[] DefinedWearables { get; private set; }

		public WearableElements SyncWearable
		{
			get
			{
				return _syncWearable.GetValueOrDefault();
			}
			private set
			{
				if (_syncWearable != value)
				{
					_syncWearable = value;
					DisplayableWearableBase[] definedWearables = DefinedWearables;
					for (int i = 0; i < definedWearables.Length; i++)
					{
						definedWearables[i].OnFlagsUpdated();
					}
				}
			}
		}

		public void ResetObject()
		{
			SyncWearable = WearableElements.None;
			SetWearables(WearableElements.None);
		}

		public override void OnReassigned()
		{
			base.OnReassigned();
			_syncWearable = null;
			if (WearableSync.TryGetData(base.OwnerHub, out var data))
			{
				ClientReceiveWearables(data.Flags, data.GetPayloadReader());
			}
			else
			{
				SyncWearable = WearableElements.None;
			}
			if (base.HasCuller && !base.Culler.IsCulled)
			{
				SetWearables(SyncWearable);
			}
		}

		public override void Init(AnimatedCharacterModel model, int index)
		{
			base.Init(model, index);
			model.OnFadeChanged += OnFadeChanged;
			model.OnVisibilityChanged += OnVisibilityChanged;
			if (base.HasCuller)
			{
				base.Culler.OnCullChanged += OnCulllChanged;
			}
			DisplayableWearableBase[] definedWearables = DefinedWearables;
			foreach (DisplayableWearableBase displayableWearableBase in definedWearables)
			{
				displayableWearableBase.Initialize(this);
				int id = (int)displayableWearableBase.Id;
				if ((id & (id - 1)) != 0 || id == 0)
				{
					Debug.LogError("Invalid ID for wearable '" + displayableWearableBase.name + "' on model '" + model.name + "'.");
				}
			}
		}

		public void WriteWearableSyncvars(NetworkWriter writer, WearableElements mask)
		{
			DisplayableWearableBase[] definedWearables = DefinedWearables;
			foreach (DisplayableWearableBase displayableWearableBase in definedWearables)
			{
				if ((displayableWearableBase.Id & mask) != WearableElements.None)
				{
					displayableWearableBase.WriteSyncvars(writer);
				}
			}
		}

		public override void ProcessRpc(NetworkReader reader)
		{
			base.ProcessRpc(reader);
			byte wearable = reader.ReadByte();
			if (TryGetWearable<DisplayableWearableBase>((WearableElements)wearable, out var ret))
			{
				ret.ProcessRpc(reader);
			}
		}

		private void OnVisibilityChanged()
		{
			SetWearables(SyncWearable);
		}

		private void OnFadeChanged()
		{
			float fade = base.Model.Fade;
			DisplayableWearableBase[] definedWearables = DefinedWearables;
			for (int i = 0; i < definedWearables.Length; i++)
			{
				definedWearables[i].SetFade(fade);
			}
		}

		private void OnCulllChanged()
		{
			if (base.Culler.IsCulled)
			{
				SetWearables(WearableElements.None);
			}
			else
			{
				SetWearables(SyncWearable);
			}
		}

		private void SetWearables(WearableElements elements)
		{
			DisplayableWearableBase[] definedWearables = DefinedWearables;
			foreach (DisplayableWearableBase obj in definedWearables)
			{
				obj.SetVisible((obj.Id & elements) != WearableElements.None && base.Model.IsVisible);
			}
		}

		public void ClientReceiveWearables(WearableElements sync, NetworkReader payload)
		{
			SyncWearable = sync;
			SetWearables(sync);
			DisplayableWearableBase[] definedWearables = DefinedWearables;
			foreach (DisplayableWearableBase displayableWearableBase in definedWearables)
			{
				if (displayableWearableBase.IsWorn)
				{
					displayableWearableBase.ApplySyncvars(payload);
				}
			}
		}

		public bool TryGetWearable<T>(WearableElements wearable, out T ret)
		{
			DisplayableWearableBase[] definedWearables = DefinedWearables;
			foreach (DisplayableWearableBase displayableWearableBase in definedWearables)
			{
				if (displayableWearableBase.Id == wearable && displayableWearableBase is T val)
				{
					ret = val;
					return true;
				}
			}
			ret = default;
			return false;
		}
	}
}

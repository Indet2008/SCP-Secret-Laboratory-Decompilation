using System;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public abstract class DisplayableWearableBase : MonoBehaviour
	{
		private Action<NetworkWriter> _lastWriter;

		private bool _prevWorn;

		[field: SerializeField]
		public WearableElements Id { get; private set; }

		public bool IsVisible { get; private set; }

		public bool IsWorn => (Subcontroller.SyncWearable & Id) != 0;

		public AnimatedCharacterModel Model => Subcontroller.Model;

		public Animator Animator => Model.Animator;

		public WearableSubcontroller Subcontroller { get; private set; }

		public virtual void Initialize(WearableSubcontroller subcontroller)
		{
			Subcontroller = subcontroller;
		}

		public virtual void OnFlagsUpdated()
		{
			if (_prevWorn != IsWorn)
			{
				_prevWorn = !_prevWorn;
				OnWornStatusChanged();
			}
		}

		public virtual void OnWornStatusChanged()
		{
		}

		public virtual void UpdateVisibility()
		{
		}

		public virtual void WriteSyncvars(NetworkWriter writer)
		{
		}

		public virtual void ApplySyncvars(NetworkReader reader)
		{
		}

		public void SetVisible(bool newVisible)
		{
			if (newVisible != IsVisible)
			{
				IsVisible = newVisible;
				UpdateVisibility();
			}
		}

		public abstract void SetFade(float fade);

		public virtual void ProcessRpc(NetworkReader reader)
		{
		}

		public void SendRpc(Action<NetworkWriter> extraData = null)
		{
			_lastWriter = extraData;
			SubcontrollerRpcHandler.ServerSendRpc(Subcontroller, WriteRpc);
		}

		private void WriteRpc(NetworkWriter writer)
		{
			writer.WriteByte((byte)Id);
			_lastWriter?.Invoke(writer);
		}
	}
}

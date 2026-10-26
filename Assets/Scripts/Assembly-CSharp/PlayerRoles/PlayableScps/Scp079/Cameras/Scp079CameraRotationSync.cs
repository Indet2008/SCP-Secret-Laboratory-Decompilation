using System.Diagnostics;
using GameObjectPools;
using Mirror;
using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp079.Cameras
{
	public class Scp079CameraRotationSync : SubroutineBase, IPoolSpawnable
	{
		private Scp079Role _role;

		private Scp079CurrentCameraSync _curCamSync;

		private Scp079LostSignalHandler _lostSignalHandler;

		private ReferenceHub _owner;

		private readonly Stopwatch _clientSendLimit = Stopwatch.StartNew();

		private const float ClientSendRate = 15f;

		private void Update()
		{
			if (_owner.isLocalPlayer && !(_clientSendLimit.Elapsed.TotalSeconds < 0.06666667014360428))
			{
				ClientSendCmd();
				_clientSendLimit.Restart();
			}
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			if (_curCamSync.TryGetCurrentCamera(out var cam))
			{
				writer.WriteUShort(cam.SyncId);
				cam.WriteAxes(writer);
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (_curCamSync.TryGetCurrentCamera(out var cam) && cam.SyncId == reader.ReadUShort() && !_lostSignalHandler.Lost)
			{
				cam.ApplyAxes(reader);
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			if (_curCamSync.TryGetCurrentCamera(out var cam))
			{
				writer.WriteUShort(cam.SyncId);
				cam.WriteAxes(writer);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (Scp079InteractableBase.TryGetInteractable(reader.ReadUShort(), out Scp079Camera result))
			{
				result.ApplyAxes(reader);
			}
		}

		public void SpawnObject()
		{
			_role = base.Role as Scp079Role;
			_role.TryGetOwner(out _owner);
			_role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
			_role.SubroutineModule.TryGetSubroutine<Scp079LostSignalHandler>(out _lostSignalHandler);
		}
	}
}

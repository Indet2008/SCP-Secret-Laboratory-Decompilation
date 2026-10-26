using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class SnowballProjectile : FlybyDetectorProjectile
	{
		[SerializeField]
		private AudioSource _bonk;

		private const float BaseDamage = 15f;

		private const float SnowedDuration = 5f;

		public override void ServerProcessHit(HitboxIdentity hid)
		{
			base.ServerProcessHit(hid);
			float num = 15f;
			bool flag = false;
			bool flag2 = false;
			if (hid.HitboxType == HitboxType.Headshot)
			{
				flag = true;
				num *= 2f;
			}
			if (SnowballItem.IsCooked(Info.Serial, thrown: true))
			{
				flag2 = true;
				num *= 2f;
			}
			if (flag & flag2)
			{
				RpcBonk();
			}
			ReferenceHub targetHub = hid.TargetHub;
			targetHub.playerEffectsController.EnableEffect<Snowed>(5f);
			SnowballDamageHandler snowballDamageHandler = new SnowballDamageHandler(PreviousOwner, num, base.TrajPhysics.LastVelocity);
			if (targetHub.playerStats.DealDamage(snowballDamageHandler))
			{
				Hitmarker.SendHitmarkerConditionally(num / 15f, snowballDamageHandler, targetHub);
			}
		}

		[ClientRpc]
		private void RpcBonk()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void InventorySystem.Items.ThrowableProjectiles.SnowballProjectile::RpcBonk()", -925982122, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcBonk()
		{
			_bonk.Play();
		}

		protected static void InvokeUserCode_RpcBonk(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcBonk called on server.");
			}
			else
			{
				((SnowballProjectile)obj).UserCode_RpcBonk();
			}
		}

		static SnowballProjectile()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(SnowballProjectile), "System.Void InventorySystem.Items.ThrowableProjectiles.SnowballProjectile::RpcBonk()", InvokeUserCode_RpcBonk);
		}
	}
}

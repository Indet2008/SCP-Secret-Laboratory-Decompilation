using System.Diagnostics;
using System.Runtime.InteropServices;
using AudioPooling;
using CustomPlayerEffects;
using Mirror;
using PlayerRoles.PlayableScps.HumeShield;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244.Hypothermia
{
	public class HumeShieldSubEffect : HypothermiaSubEffectBase, IHumeShieldBlocker
	{
		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct HumeBlockMsg : NetworkMessage
		{
		}

		[SerializeField]
		private AudioClip[] _freezeSounds;

		[SerializeField]
		private float _hsSustainTime;

		[SerializeField]
		private float _hsDecreaseStartTime;

		[SerializeField]
		private float _hsDecreaseAbsolute;

		[SerializeField]
		private float _hsDecreasePerExposure;

		private float _decreaseTimer;

		private static HumeShieldSubEffect _localEffect;

		private readonly Stopwatch _cooldownSw = Stopwatch.StartNew();

		private readonly Stopwatch _sustainSw = new Stopwatch();

		public override bool IsActive
		{
			get
			{
				if (!HumeShieldBlocked)
				{
					if (_sustainSw.IsRunning)
					{
						return _sustainSw.Elapsed.TotalSeconds < (double)_hsSustainTime;
					}
					return false;
				}
				return true;
			}
		}

		public bool HumeShieldBlocked { get; private set; }

		[RuntimeInitializeOnLoadMethod]
		private static void Register()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<HumeBlockMsg>(OnMessageReceived);
			};
		}

		private static void OnMessageReceived(HumeBlockMsg msg)
		{
			if (!(_localEffect == null))
			{
				_localEffect.ReceiveHumeBlockMessage();
			}
		}

		internal override void Init(StatusEffectBase mainEffect)
		{
			base.Init(mainEffect);
			if (mainEffect.IsLocalPlayer)
			{
				_localEffect = this;
			}
		}

		internal override void UpdateEffect(float curExposure)
		{
			if (!NetworkServer.active)
			{
				if (HumeShieldBlocked && curExposure <= 0f)
				{
					HumeShieldBlocked = false;
				}
				return;
			}
			bool humeShieldBlocked = HumeShieldBlocked;
			HumeShieldBlocked = UpdateHumeShield(curExposure);
			if (HumeShieldBlocked)
			{
				if (!humeShieldBlocked)
				{
					base.Hub.networkIdentity.connectionToClient.Send<HumeBlockMsg>(default);
				}
			}
			else
			{
				_decreaseTimer = 0f;
			}
		}

		private bool UpdateHumeShield(float expo)
		{
			if (expo == 0f || !TryGetController(out var ctrl) || base.Hub.characterClassManager.GodMode)
			{
				return false;
			}
			ctrl.AddBlocker(this);
			_sustainSw.Restart();
			_decreaseTimer += expo * Time.deltaTime;
			if (_decreaseTimer < _hsDecreaseStartTime)
			{
				return true;
			}
			ctrl.HsCurrent -= (expo * _hsDecreasePerExposure + _hsDecreaseAbsolute) * Time.deltaTime;
			return true;
		}

		private void ReceiveHumeBlockMessage()
		{
			if (TryGetController(out var ctrl))
			{
				HumeShieldBlocked = true;
				ctrl.AddBlocker(this);
				if (!(_cooldownSw.Elapsed.TotalSeconds < (double)_hsSustainTime))
				{
					AudioSourcePoolManager.Play2D(_freezeSounds.RandomItem());
					_cooldownSw.Restart();
				}
			}
		}

		private bool TryGetController(out DynamicHumeShieldController ctrl)
		{
			if (!(base.Hub.roleManager.CurrentRole is IHumeShieldedRole { HumeShieldModule: DynamicHumeShieldController humeShieldModule }))
			{
				ctrl = null;
				return false;
			}
			ctrl = humeShieldModule;
			return true;
		}
	}
}

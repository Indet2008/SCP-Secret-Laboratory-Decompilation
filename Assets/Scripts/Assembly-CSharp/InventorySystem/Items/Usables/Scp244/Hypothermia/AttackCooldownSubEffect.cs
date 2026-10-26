using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244.Hypothermia
{
	public class AttackCooldownSubEffect : HypothermiaSubEffectBase
	{
		private float _prevExpo;

		private static readonly Dictionary<uint, float> MultipliersOfPlayers = new Dictionary<uint, float>();

		[SerializeField]
		private float _cooldownMultiplierPerExposure;

		public override bool IsActive => _prevExpo > 0f;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += MultipliersOfPlayers.Clear;
		}

		public static float CurrentAttackCooldownMultiplier(ReferenceHub hub)
		{
			if (!MultipliersOfPlayers.TryGetValue(hub.networkIdentity.netId, out var value))
			{
				return 1f;
			}
			return value;
		}

		internal override void UpdateEffect(float curExposure)
		{
			if (curExposure != _prevExpo)
			{
				float value = Mathf.LerpUnclamped(1f, _cooldownMultiplierPerExposure, curExposure);
				MultipliersOfPlayers[base.Hub.networkIdentity.netId] = value;
				_prevExpo = curExposure;
			}
		}
	}
}

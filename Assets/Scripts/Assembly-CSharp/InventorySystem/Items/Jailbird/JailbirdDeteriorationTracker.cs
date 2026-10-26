using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Jailbird
{
	[Serializable]
	public class JailbirdDeteriorationTracker
	{
		public static Dictionary<ushort, JailbirdWearState> ReceivedStates = new Dictionary<ushort, JailbirdWearState>();

		private static bool _anyReceived;

		private static bool _914ValuesSet;

		private JailbirdItem _jailbird;

		[SerializeField]
		private AnimationCurve _damageToWearState;

		[SerializeField]
		private AnimationCurve _chargesToWearState;

		public static float Scp914CoarseDamage { get; private set; }

		public static int Scp914CoarseCharges { get; private set; }

		public JailbirdWearState WearState
		{
			get
			{
				if (!ReceivedStates.TryGetValue(_jailbird.ItemSerial, out var value))
				{
					return JailbirdWearState.Healthy;
				}
				return value;
			}
		}

		public bool IsBroken => WearState == JailbirdWearState.Broken;

		public void Setup(JailbirdItem item)
		{
			_jailbird = item;
			if (_914ValuesSet)
			{
				return;
			}
			for (int i = 0; i < _damageToWearState.length; i++)
			{
				Keyframe keyframe = _damageToWearState.keys[i];
				if (FloatToState(keyframe.value) == JailbirdWearState.AlmostBroken)
				{
					Scp914CoarseDamage = keyframe.time;
					break;
				}
			}
			for (int j = 0; j < _chargesToWearState.length; j++)
			{
				Keyframe keyframe2 = _chargesToWearState.keys[j];
				if (FloatToState(keyframe2.value) == JailbirdWearState.AlmostBroken)
				{
					Scp914CoarseCharges = Mathf.RoundToInt(keyframe2.time);
					break;
				}
			}
			_914ValuesSet = true;
		}

		private JailbirdWearState FloatToState(float stateFloat)
		{
			return (JailbirdWearState)Mathf.Clamp((int)stateFloat, 0, 5);
		}

		private JailbirdWearState StateForTotalDamage(float totalDamage)
		{
			return FloatToState(_damageToWearState.Evaluate(totalDamage));
		}

		private JailbirdWearState StateForCharges(int numOfCharges)
		{
			return FloatToState(_chargesToWearState.Evaluate(numOfCharges));
		}

		public void RecheckUsage()
		{
			JailbirdWearState jailbirdWearState = StateForTotalDamage(_jailbird.TotalMeleeDamageDealt);
			JailbirdWearState jailbirdWearState2 = StateForCharges(_jailbird.TotalChargesPerformed);
			JailbirdWearState jailbirdWearState3 = ((jailbirdWearState > jailbirdWearState2) ? jailbirdWearState : jailbirdWearState2);
			ReceivedStates[_jailbird.ItemSerial] = jailbirdWearState3;
			NetworkWriter writer;
			using (new AutosyncRpc(_jailbird.ItemId, out writer))
			{
				writer.WriteByte(0);
				writer.WriteByte((byte)jailbirdWearState3);
			}
			if (jailbirdWearState3 != JailbirdWearState.Broken)
			{
				return;
			}
			NetworkWriter writer2;
			using (new AutosyncRpc(_jailbird.ItemId, out writer2))
			{
				writer2.WriteByte(1);
			}
		}

		public static void ReadUsage(ushort serial, NetworkReader reader)
		{
			ReceivedStates[serial] = (JailbirdWearState)reader.ReadByte();
			_anyReceived = true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				if (_anyReceived)
				{
					_anyReceived = false;
					ReceivedStates.Clear();
				}
			};
		}
	}
}

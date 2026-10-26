using System.Diagnostics;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Coin
{
	public class CoinViewmodel : StandardAnimatedViemodel
	{
		private static readonly int TriggerHash = Animator.StringToHash("Flip");

		private static readonly int TailsHash = Animator.StringToHash("IsTails");

		private readonly Stopwatch _animStopwatch = new Stopwatch();

		private const float MessageVitality = 3.9f;

		[SerializeField]
		private AnimationCurve _positionOverrideOverTime;

		[SerializeField]
		private Transform _coinTr;

		[SerializeField]
		private Transform _coinOverrideTr;

		public override void InitAny()
		{
			base.InitAny();
			Coin.OnFlipped += ProcessCoinflip;
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			if (wasEquipped)
			{
				GetComponent<AudioSource>().Stop();
				if (TryGetMessage(id.SerialNumber, out var isTails))
				{
					ProcessCoinflip(id.SerialNumber, isTails);
					AnimatorForceUpdate(base.SkipEquipTime, fastMode: false);
				}
				else
				{
					AnimatorForceUpdate(base.SkipEquipTime);
				}
			}
		}

		protected override void LateUpdate()
		{
			base.LateUpdate();
			float num = _positionOverrideOverTime.Evaluate((float)_animStopwatch.Elapsed.TotalSeconds);
			if (!(num <= 0f))
			{
				_coinTr.position = Vector3.Lerp(_coinTr.position, _coinOverrideTr.position, num);
			}
		}

		private bool TryGetMessage(ushort serial, out bool isTails)
		{
			bool num = Coin.FlipTimes.TryGetValue(serial, out var value);
			if (value < 0.0)
			{
				isTails = true;
				value += NetworkTime.time;
			}
			else
			{
				isTails = false;
				value = NetworkTime.time - value;
			}
			if (num)
			{
				return value < 3.9000000953674316;
			}
			return false;
		}

		private void ProcessCoinflip(ushort serial, bool isTails)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				AnimatorSetBool(TailsHash, isTails);
				AnimatorSetTrigger(TriggerHash);
				_animStopwatch.Restart();
			}
		}

		private void OnDisable()
		{
			_animStopwatch.Reset();
		}

		private void OnDestroy()
		{
			Coin.OnFlipped -= ProcessCoinflip;
		}
	}
}

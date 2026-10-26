using System;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class SubsequentShotsCounter
	{
		private bool _destructed;

		private float _counter;

		private float _decaySpeed;

		private float _remainingSustain;

		private readonly Firearm _firearm;

		private readonly float _sustainMultiplier;

		private readonly float _sustainAddition;

		private readonly float _decayTime;

		public int SubsequentShots
		{
			get
			{
				return Mathf.CeilToInt(_counter);
			}
			private set
			{
				_counter = value;
			}
		}

		public event Action OnShotRecorded;

		public event Action OnReset;

		private void OnShot(ShotEvent ev)
		{
			if (ev.ItemId.SerialNumber == _firearm.ItemSerial)
			{
				SubsequentShots++;
				float num = (_firearm.TryGetModule<IActionModule>(out var module) ? (1f / module.DisplayCyclicRate) : 0f);
				_remainingSustain = num * _sustainMultiplier + _sustainAddition;
				if (_decayTime > 0f)
				{
					_decaySpeed = _counter / _decayTime;
				}
				OnShotRecorded?.Invoke();
			}
		}

		public void Update()
		{
			if (_remainingSustain > 0f)
			{
				_remainingSustain -= Time.deltaTime;
			}
			else
			{
				if (SubsequentShots == 0)
				{
					return;
				}
				if (_decayTime > 0f)
				{
					_counter -= _decaySpeed * Time.deltaTime;
					if (_counter > 0f)
					{
						return;
					}
				}
				_counter = 0f;
				OnReset?.Invoke();
			}
		}

		public void Destruct()
		{
			if (!_destructed)
			{
				_destructed = true;
				ShotEventManager.OnShot -= OnShot;
			}
		}

		public SubsequentShotsCounter(Firearm firearm, float sustainCycleTimeMultiplier = 1f, float sustainAdditionSeconds = 0.1f, float decayTimeSeconds = 0.4f)
		{
			_firearm = firearm;
			_sustainMultiplier = sustainCycleTimeMultiplier;
			_sustainAddition = sustainAdditionSeconds;
			_decayTime = decayTimeSeconds;
			ShotEventManager.OnShot += OnShot;
		}

		~SubsequentShotsCounter()
		{
			Destruct();
		}
	}
}

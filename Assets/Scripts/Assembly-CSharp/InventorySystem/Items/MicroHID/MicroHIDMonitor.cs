using System;
using System.Collections.Generic;
using System.Text;
using InventorySystem.Items.MicroHID.Modules;
using TMPro;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace InventorySystem.Items.MicroHID
{
	public class MicroHIDMonitor : MonoBehaviour
	{
		[Serializable]
		private class LcdElementInstance
		{
			private bool? _prevActive;

			private float? _prevAlpha;

			private float _remainingBlinking;

			private const float DisabledAlpha = 0.22f;

			[SerializeField]
			private Graphic _target;

			public bool Active;

			public bool Blinking;

			public float BlinkFrequency;

			public float BlinkRatio;

			public float BlinkDuration;

			public float DisabledAlphaMultiplier;

			[field: SerializeField]
			public LcdElementType Type { get; private set; }

			public double BlinkOffset { get; private set; }

			public void Update()
			{
				bool flag = Active;
				if (flag && Blinking)
				{
					_remainingBlinking -= Time.deltaTime;
					flag = _remainingBlinking <= 0f || GetBlinkActive(BlinkFrequency, BlinkRatio, BlinkOffset);
				}
				float num = (flag ? 1f : (0.22f * DisabledAlphaMultiplier));
				if (_prevAlpha != num)
				{
					_prevAlpha = num;
					Color color = _target.color;
					color.a = num;
					_target.color = color;
				}
				if (_prevActive != Active)
				{
					_prevActive = Active;
					if (Active)
					{
						BlinkOffset = Time.timeAsDouble;
						_remainingBlinking = ((BlinkDuration < 0f) ? float.MaxValue : BlinkDuration);
					}
				}
			}
		}

		private enum LcdElementType
		{
			Windup = 0,
			Winddown = 1,
			ReadyToFire = 2,
			Firing = 3,
			Standby = 4,
			Broken = 5,
			JeffHappy = 6,
			JeffSad = 7,
			JeffConcerned = 8
		}

		[SerializeField]
		private LcdElementInstance[] _lcdElementInstances;

		[SerializeField]
		private GameObject[] _batteryIndicators;

		[SerializeField]
		private TMP_Text _windupProgress;

		[SerializeField]
		[FormerlySerializedAs("_remainigCharge")]
		private TMP_Text _remainingCharge;

		[SerializeField]
		private char _windupChar;

		[SerializeField]
		private int _maxWindupLen;

		[SerializeField]
		private Image _jeffRenderer;

		[SerializeField]
		private Sprite _jeffHappy;

		[SerializeField]
		private Sprite _jeffSad;

		[SerializeField]
		private Sprite _jeffConcerned;

		[SerializeField]
		private Sprite _jeffDead;

		private ushort _serial;

		private bool _worldmodelMode;

		private IIdentifierProvider _identifierProvider;

		private CycleController _cycle;

		private int _lastEnergyMultiplied;

		private readonly StringBuilder _sharedSb = new StringBuilder();

		private readonly Dictionary<LcdElementType, LcdElementInstance> _lcdElements = new Dictionary<LcdElementType, LcdElementInstance>();

		private bool BlinkNoBattery => GetBlinkActive(1.2f, 0.4f);

		private void Start()
		{
			if (!base.transform.TryGetComponentInParent<IIdentifierProvider>(out _identifierProvider))
			{
				return;
			}
			if (_identifierProvider is MicroHIDViewmodel)
			{
				_worldmodelMode = false;
				_lcdElementInstances.ForEach((LcdElementInstance x) =>
				{
					_lcdElements.Add(x.Type, x);
				});
			}
			else
			{
				_worldmodelMode = true;
			}
		}

		private void OnDisable()
		{
			_serial = 0;
		}

		private void Update()
		{
			if (_serial != _identifierProvider.ItemId.SerialNumber)
			{
				_serial = _identifierProvider.ItemId.SerialNumber;
				_cycle = CycleSyncModule.GetCycleController(_serial);
			}
			UpdateBattery();
			if (!_worldmodelMode)
			{
				UpdateWindup();
				UpdatePhase();
				UpdateJeff();
				LcdElementInstance[] lcdElementInstances = _lcdElementInstances;
				for (int i = 0; i < lcdElementInstances.Length; i++)
				{
					lcdElementInstances[i].Update();
				}
			}
		}

		private void UpdateBattery()
		{
			float energy = EnergyManagerModule.GetEnergy(_serial);
			int num = Mathf.CeilToInt(energy * (float)_batteryIndicators.Length);
			_remainingCharge.enabled = num > 0 || BlinkNoBattery;
			int num2 = Mathf.CeilToInt(energy * 100f);
			if (num2 != _lastEnergyMultiplied)
			{
				_remainingCharge.text = num2.ToString();
				_lastEnergyMultiplied = num2;
			}
			bool flag = num > 1 || BlinkNoBattery || _cycle.Phase == MicroHidPhase.Firing;
			for (int i = 0; i < _batteryIndicators.Length; i++)
			{
				_batteryIndicators[i].SetActive((i < num) & flag);
			}
		}

		private void UpdateWindup()
		{
			int num = Mathf.CeilToInt(WindupSyncModule.GetProgress(_serial) * (float)_maxWindupLen);
			_sharedSb.Clear();
			for (int i = 0; i < num; i++)
			{
				_sharedSb.Append(_windupChar);
			}
			LcdElementInstance lcdElementInstance = _lcdElements[LcdElementType.ReadyToFire];
			bool blinkActive = GetBlinkActive(lcdElementInstance.BlinkFrequency, lcdElementInstance.BlinkRatio, lcdElementInstance.BlinkOffset);
			_windupProgress.text = _sharedSb.ToString();
			_windupProgress.enabled = (_cycle.Phase != MicroHidPhase.WoundUpSustain) | blinkActive;
		}

		private void UpdatePhase()
		{
			bool broken = BrokenSyncModule.GetBroken(_serial);
			_lcdElements[LcdElementType.Broken].Active = broken;
			_lcdElementInstances.ForEach(UpdatePhaseLcd);
		}

		private void UpdatePhaseLcd(LcdElementInstance inst)
		{
			switch (inst.Type)
			{
			case LcdElementType.Windup:
				inst.Active = _cycle.Phase == MicroHidPhase.WindingUp;
				break;
			case LcdElementType.Winddown:
				inst.Active = _cycle.Phase == MicroHidPhase.WindingDown;
				break;
			case LcdElementType.ReadyToFire:
				inst.Active = _cycle.Phase == MicroHidPhase.WoundUpSustain;
				break;
			case LcdElementType.Firing:
				inst.Active = _cycle.Phase == MicroHidPhase.Firing;
				break;
			case LcdElementType.Standby:
				inst.Active = _cycle.Phase == MicroHidPhase.Standby;
				break;
			}
		}

		private void UpdateJeff()
		{
			if (EnergyManagerModule.GetEnergy(_serial) == 0f)
			{
				_jeffRenderer.sprite = _jeffDead;
				return;
			}
			if (BrokenSyncModule.GetBroken(_serial))
			{
				_jeffRenderer.sprite = _jeffSad;
				return;
			}
			float num = 6f;
			bool flag = _cycle.Phase == MicroHidPhase.WoundUpSustain && _cycle.CurrentPhaseElapsed > num;
			_jeffRenderer.sprite = (flag ? _jeffConcerned : _jeffHappy);
		}

		private static bool GetBlinkActive(float frequency, float ratio, double offset = 0.0)
		{
			double num = (Time.timeAsDouble - offset) * (double)frequency;
			return (float)(num - (double)(int)num) <= ratio;
		}
	}
}

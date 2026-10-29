using System.Collections.Generic;
using System.Diagnostics;
using TMPro;
using UnityEngine;

public class LabGramScale : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI _text;

	[SerializeField]
	private int _weightOffset;

	[SerializeField]
	private AudioSource _beep;

	private float _detectedWeight;

	private float _prevDetected;

	private float _weightRandom;

	private bool _idle;

	private const float AdjustmentLerp = 1.4f;

	private const int WeightLimitGrams = 4500;

	private const int SaladLimit = 14000;

	private const float DisableTime = 5f;

	private const float ConversionRate = 945f;

	private readonly Stopwatch _lastWeightSw = Stopwatch.StartNew();

	private readonly HashSet<Rigidbody> _detectedRbs = new HashSet<Rigidbody>();

	private bool Calibrated => Mathf.Abs(_weightRandom) < 0.00035f;

	private void OnTriggerStay(Collider other)
	{
		Rigidbody attachedRigidbody = other.attachedRigidbody;
		if (!(attachedRigidbody == null) && _detectedRbs.Add(attachedRigidbody))
		{
			_detectedWeight += other.attachedRigidbody.mass;
			_idle = false;
			if (Mathf.Approximately(_detectedWeight, 0f))
			{
				_detectedWeight = 0f;
			}
		}
	}

	// The reading wobbles after a change, settles with a beep, and blanks after a few idle seconds.
	private void FixedUpdate()
	{
		if (_idle)
		{
			return;
		}
		float detectedWeight = _detectedWeight;
		if (detectedWeight != _prevDetected)
		{
			if (detectedWeight == 0f)
			{
				_weightRandom = Random.Range(-0.005f, 0.001f);
			}
			else
			{
				float num = Random.Range(0.01f, 0.04f);
				_weightRandom = ((_detectedWeight - _prevDetected >= 0f) ? 1f : (-1f)) * num;
			}
			_prevDetected = _detectedWeight;
		}
		int num2 = Mathf.RoundToInt((_weightRandom + _detectedWeight) * 945f) + _weightOffset;
		if (!Calibrated)
		{
			_weightRandom = Mathf.Lerp(_weightRandom, 0f, Time.deltaTime * 1.4f);
			if (Calibrated && num2 >= 1 && num2 <= 4499)
			{
				_beep.Play();
			}
			_lastWeightSw.Restart();
		}
		if ((float)_lastWeightSw.Elapsed.TotalSeconds > 5f)
		{
			_text.text = string.Empty;
			_idle = true;
			return;
		}
		if (_beep.isPlaying)
		{
			_text.text = string.Empty;
		}
		else if (num2 > 14000)
		{
			_text.text = "Next time eat a salad.";
		}
		else if (num2 > 4500)
		{
			_text.text = "Err";
		}
		else
		{
			_text.text = num2 + " g";
		}
		_detectedWeight = 0f;
		_detectedRbs.Clear();
	}
}

using System;
using UnityEngine;

public class LiquidWobble : MonoBehaviour
{
	[SerializeField]
	private float _maxWobble = 0.03f;

	[SerializeField]
	private float _wobbleSpeed = 1f;

	[SerializeField]
	private float _recovery = 1f;

	private Renderer _renderer;

	private Vector3 _lastPosition;

	private Vector3 _velocity;

	private Vector3 _lastRotation;

	private Vector3 _angularVelocity;

	private float _wobbleAmountX;

	private float _wobbleAmountZ;

	private float _wobbleAmountToAddX;

	private float _wobbleAmountToAddZ;

	private float _pulse;

	private float _time = 0.5f;

	private void Start()
	{
		_renderer = GetComponent<Renderer>();
	}

	private void Update()
	{
		_time += Time.deltaTime;
		_wobbleAmountToAddX = Mathf.Lerp(_wobbleAmountToAddX, 0f, Time.deltaTime * _recovery);
		_wobbleAmountToAddZ = Mathf.Lerp(_wobbleAmountToAddZ, 0f, Time.deltaTime * _recovery);
		_pulse = MathF.PI * 2f * _wobbleSpeed;
		_wobbleAmountX = _wobbleAmountToAddX * Mathf.Sin(_pulse * _time);
		_wobbleAmountZ = _wobbleAmountToAddZ * Mathf.Sin(_pulse * _time);
		_renderer.material.SetFloat("_WobbleZ", _wobbleAmountX);
		_renderer.material.SetFloat("_WobbleX", _wobbleAmountZ);
		_velocity = (_lastPosition - base.transform.position) / Time.deltaTime;
		_angularVelocity = base.transform.rotation.eulerAngles - _lastRotation;
		_wobbleAmountToAddX += Mathf.Clamp((_velocity.x + _angularVelocity.z * 0.2f) * _maxWobble, 0f - _maxWobble, _maxWobble);
		_wobbleAmountToAddZ += Mathf.Clamp((_velocity.z + _angularVelocity.x * 0.2f) * _maxWobble, 0f - _maxWobble, _maxWobble);
		_lastPosition = base.transform.position;
		_lastRotation = base.transform.rotation.eulerAngles;
	}
}

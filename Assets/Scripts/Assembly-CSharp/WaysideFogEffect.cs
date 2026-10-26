using CustomRendering;
using UnityEngine;

public class WaysideFogEffect : MonoBehaviour
{
	private bool _prevActive;

	private Vector3 _position;

	private float _radiusSqr;

	[SerializeField]
	private float _radius;

	[SerializeField]
	private float _depth;

	[SerializeField]
	private float _fogEnableDuration;

	private bool GetDesiredFogState()
	{
		Vector3 lastPosition = MainCameraController.LastPosition;
		float y = lastPosition.y;
		if (y > _position.y)
		{
			return false;
		}
		if (y < _position.y - _depth)
		{
			return false;
		}
		return new Vector2(lastPosition.x - _position.x, lastPosition.z - _position.z).sqrMagnitude < _radiusSqr;
	}

	private void Start()
	{
		_position = base.transform.position;
		_radiusSqr = _radius * _radius;
	}

	private void Update()
	{
		bool desiredFogState = GetDesiredFogState();
		if (desiredFogState != _prevActive)
		{
			_prevActive = desiredFogState;
			if (desiredFogState)
			{
				FogController.EnableFogType(FogType.Nuke, _fogEnableDuration);
			}
			else
			{
				FogController.DisableFogType(FogType.Nuke);
			}
		}
	}
}

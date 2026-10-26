using UnityEngine;
using UnityEngine.UI;

public class FlipbookPlayer : MonoBehaviour
{
	[SerializeField]
	private int _updateCooldown;

	[SerializeField]
	private RawImage _image;

	[SerializeField]
	private Vector2 _primaryOffset;

	[SerializeField]
	private int _primaryCycles;

	[SerializeField]
	private Vector2 _secondaryOffset;

	[SerializeField]
	private int _secondaryCycles;

	private int _elapsedPrimary;

	private int _elapsedSecondary;

	private int _remainingCooldown;

	private Rect _rect;

	private void Awake()
	{
		_rect = _image.uvRect;
	}

	private void FixedUpdate()
	{
		if (_remainingCooldown > 0)
		{
			_remainingCooldown--;
			return;
		}
		_rect.position = _elapsedPrimary * _primaryOffset + _elapsedSecondary * _secondaryOffset;
		_elapsedPrimary++;
		if (_elapsedPrimary >= _primaryCycles)
		{
			_elapsedSecondary++;
			_elapsedPrimary = 0;
			if (_elapsedSecondary >= _secondaryCycles)
			{
				_elapsedSecondary = 0;
			}
		}
		_remainingCooldown = _updateCooldown;
		_image.uvRect = _rect;
	}
}

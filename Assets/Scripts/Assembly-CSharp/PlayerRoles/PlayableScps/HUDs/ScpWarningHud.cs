using System.Diagnostics;
using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.HUDs
{
	public class ScpWarningHud : MonoBehaviour
	{
		[SerializeField]
		private TextMeshProUGUI _text;

		private const float FadeSpeed = 8f;

		private const float DefaultTime = 3.8f;

		private float _duration;

		private string _targetText;

		private float _alpha;

		private bool _dirty;

		private readonly Stopwatch _elapsed = new Stopwatch();

		public float Alpha
		{
			get
			{
				return _alpha;
			}
			private set
			{
				value = Mathf.Clamp01(value);
				if (_alpha != value)
				{
					_alpha = value;
					_text.alpha = value;
				}
			}
		}

		private void Awake()
		{
			_text.alpha = Alpha;
		}

		private void Update()
		{
			if (_elapsed.Elapsed.TotalSeconds > (double)_duration || _dirty)
			{
				Alpha -= Time.deltaTime * 8f;
				if (!(Alpha > 0f) && _dirty)
				{
					_text.text = _targetText;
					_dirty = false;
				}
			}
			else
			{
				Alpha += Time.deltaTime * 8f;
			}
		}

		public void SetText(string text, float duration = 3.8f)
		{
			_dirty |= _targetText != text;
			_targetText = text;
			_duration = duration;
			_elapsed.Restart();
		}
	}
}

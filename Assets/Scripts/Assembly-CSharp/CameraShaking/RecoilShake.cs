using System.Diagnostics;
using UnityEngine;

namespace CameraShaking
{
	public class RecoilShake : IShakeEffect
	{
		private readonly Stopwatch _removeStopwatch;

		private readonly RecoilSettings _settings;

		private readonly Quaternion _startQuaternion;

		private bool _firstFrame;

		public RecoilShake(RecoilSettings settings)
		{
			_settings = settings;
			_startQuaternion = Quaternion.Euler(0f, 0f, settings.ZAxis * (Random.value - 0.5f));
			_firstFrame = true;
			_removeStopwatch = new Stopwatch();
			_removeStopwatch.Start();
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			float num = Mathf.Clamp01((float)_removeStopwatch.Elapsed.TotalSeconds / _settings.AnimationTime);
			float num2;
			float num3;
			if (_firstFrame)
			{
				num2 = _settings.UpKick;
				num3 = _settings.SideKick;
				_firstFrame = false;
			}
			else
			{
				num2 = 0f;
				num3 = 0f;
			}
			float verticalLook = num2;
			float horizontalLook = num3;
			Quaternion? rootCameraRotation = Quaternion.Slerp(_startQuaternion, Quaternion.identity, num);
			float fovPercent = Mathf.SmoothStep(_settings.FovKick, 1f, num);
			shakeValues = new ShakeEffectValues(rootCameraRotation, null, null, fovPercent, verticalLook, horizontalLook);
			return num < 1f;
		}
	}
}

using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;
using UserSettings;
using UserSettings.VideoSettings;

namespace CameraShaking
{
	public class HeadbobShake : IShakeEffect
	{
		private readonly AnimatedCharacterModel _model;

		private static HeadbobShake _mostCurrent;

		private static readonly CachedUserSetting<bool> EnableBobbing = new CachedUserSetting<bool>(MiscVideoSetting.HeadBobbing);

		public HeadbobShake(AnimatedCharacterModel model)
		{
			_model = model;
			_mostCurrent = this;
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			if (_model.Pooled || !_model.IsTracked || this != _mostCurrent)
			{
				shakeValues = ShakeEffectValues.None;
				return false;
			}
			Vector3 value = ((!EnableBobbing.Value) ? Vector3.zero : ply.transform.TransformDirection(_model.HeadBobPosition));
			Vector3? rootCameraPositionOffset = value;
			shakeValues = new ShakeEffectValues(null, null, rootCameraPositionOffset);
			return true;
		}
	}
}

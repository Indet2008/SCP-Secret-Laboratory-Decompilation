using System;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.SwayControllers
{
	public class GoopSway : IItemSwayController
	{
		[Serializable]
		public struct GoopSwaySettings
		{
			public Transform TargetTransform;

			public float SwayIntensity;

			public float TranslationIntensity;

			public float ZAxisIntensity;

			public float SwaySmoothness;

			public float TranslationSmoothness;

			public float BobIntensity;

			public float CentrifugalIntensity;

			public int Invert;

			public GoopSwaySettings(Transform targetTransform, float swayIntensity, float translationIntensity, float zAxisIntensity, float swaySmoothness, float translationSmoothness, float bobIntensity, float centrifugalIntensity, bool invertSway)
			{
				TargetTransform = targetTransform;
				SwayIntensity = swayIntensity;
				TranslationIntensity = translationIntensity;
				ZAxisIntensity = zAxisIntensity;
				SwaySmoothness = swaySmoothness;
				TranslationSmoothness = translationSmoothness;
				BobIntensity = bobIntensity;
				CentrifugalIntensity = centrifugalIntensity;
				Invert = ((!invertSway) ? 1 : (-1));
			}
		}

		private const float MaximumReasonableMouseSpeed = 15f;

		protected readonly ReferenceHub Owner;

		private readonly GoopSwaySettings _settings;

		private readonly Vector3 _positionOffset;

		private readonly Transform _ownerTransform;

		private readonly Transform _camTransform;

		private float _prevRotX;

		private float _prevRotY;

		private float CurRotX => _ownerTransform.localEulerAngles.y;

		private float CurRotY => _camTransform.localEulerAngles.x;

		private AnimatedCharacterModel CharModel
		{
			get
			{
				if (!(Owner.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					return null;
				}
				return fpcRole.FpcModule.CharacterModelInstance as AnimatedCharacterModel;
			}
		}

		protected virtual GoopSwaySettings Settings => _settings;

		protected virtual float OverallBobMultiplier => 12f;

		protected virtual float OverallSwayMultiplier => 0.013f;

		public GoopSway(GoopSwaySettings settings, ReferenceHub owner)
		{
			_settings = settings;
			_positionOffset = settings.TargetTransform.localPosition;
			Owner = owner;
			_ownerTransform = Owner.transform;
			_camTransform = owner.PlayerCameraReference;
			_prevRotX = CurRotX;
			_prevRotY = CurRotY;
		}

		public virtual void UpdateSway()
		{
			if (NetworkClient.active)
			{
				CameraSway(Settings.TargetTransform);
				Transition(Settings.TargetTransform);
			}
		}

		private void CameraSway(Transform tr)
		{
			GetInput(out var x, out var y);
			GoopSwaySettings settings = Settings;
			Quaternion quaternion = Quaternion.AngleAxis(settings.SwayIntensity * x, -Vector3.up * settings.Invert);
			Quaternion quaternion2 = Quaternion.AngleAxis(settings.SwayIntensity * y, Vector3.right * settings.Invert);
			Quaternion quaternion3 = Quaternion.AngleAxis(settings.ZAxisIntensity * x, -Vector3.forward * settings.Invert);
			Quaternion b = quaternion * quaternion2 * quaternion3;
			tr.localRotation = Quaternion.Slerp(tr.localRotation, b, settings.SwaySmoothness * Time.deltaTime);
		}

		private void GetInput(out float x, out float y)
		{
			float num = 15f;
			float value = Vector3.Dot(_ownerTransform.forward, _camTransform.forward);
			float num2 = OverallSwayMultiplier / Time.deltaTime;
			x = Mathf.Clamp(num2 * Mathf.DeltaAngle(_prevRotX, CurRotX), 0f - num, num);
			y = Mathf.Clamp(num2 * Mathf.DeltaAngle(CurRotY, _prevRotY) * Mathf.Clamp01(value), 0f - num, num);
			_prevRotX = CurRotX;
			_prevRotY = CurRotY;
		}

		private void Transition(Transform tr)
		{
			GoopSwaySettings settings = Settings;
			Vector3 vector = _ownerTransform.InverseTransformDirection(Owner.GetVelocity());
			float x = vector.x;
			float num = Mathf.Abs(vector.z);
			Vector3 b = new Vector3(settings.TranslationIntensity * (0f - x), settings.TranslationIntensity * (0f - num), 0f) + _positionOffset;
			if (settings.CentrifugalIntensity != 0f)
			{
				b += Vector3.forward * (Quaternion.Angle(Quaternion.identity, tr.localRotation) / 360f) * settings.CentrifugalIntensity;
			}
			AnimatedCharacterModel charModel = CharModel;
			Vector3 vector2 = ((charModel != null) ? (settings.BobIntensity * OverallBobMultiplier * charModel.HeadBobPosition) : Vector3.zero);
			tr.localPosition = Vector3.Slerp(tr.localPosition - vector2, b, Time.deltaTime * settings.TranslationSmoothness) + vector2;
		}
	}
}

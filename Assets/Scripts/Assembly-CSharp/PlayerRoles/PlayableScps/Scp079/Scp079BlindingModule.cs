using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using MapGeneration.Holidays;
using PlayerRoles.Spectating;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079BlindingModule : MonoBehaviour
	{
		private const float ModelRadius = 0.25f;

		private const float VisionTriggerDistance = 60f;

		public Volume ExposureVolume;

		[SerializeField]
		private float _enableSpeed;

		[SerializeField]
		private float _disableSpeed;

		private readonly List<ReferenceHub> _orangePlayers = new List<ReferenceHub>();

		// Restored from the client build (IL2CPP): SCP-079's screen over-exposes while its camera sees a player
		// under the Orange Candy effect.
		private void Awake()
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return;
			}
			HolidayType[] targetHolidays = hub.playerEffectsController.GetEffect<CustomPlayerEffects.OrangeCandy>().TargetHolidays;
			if (targetHolidays != null && targetHolidays.Length != 0)
			{
				bool flag = false;
				for (int i = 0; i < targetHolidays.Length; i++)
				{
					if (GameCore.Version.ActiveHoliday == targetHolidays[i])
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					return;
				}
			}
			base.gameObject.SetActive(true);
		}

		private void Update()
		{
			_orangePlayers.Clear();
			foreach (ReferenceHub hub in ReferenceHub.AllHubs)
			{
				if (hub.playerEffectsController.TryGetEffect<CustomPlayerEffects.OrangeCandy>(out var candy) && candy.IsEnabled)
				{
					_orangePlayers.Add(hub);
				}
			}
			bool blinded = false;
			foreach (Scp079Role role in Scp079Role.ActiveInstances)
			{
				if (!role.TryGetOwner(out var owner) || (!owner.isLocalPlayer && !owner.IsLocallySpectated()))
				{
					continue;
				}
				Cameras.Scp079Camera cam = role.CurrentCamera;
				if (cam == null)
				{
					continue;
				}
				foreach (ReferenceHub target in _orangePlayers)
				{
					if (target.roleManager.CurrentRole is FirstPersonControl.IFpcRole fpcRole && VisionInformation.GetVisionInformation(owner, cam.CameraAnchor, fpcRole.FpcModule.Position, ModelRadius, VisionTriggerDistance).IsLooking)
					{
						blinded = true;
						break;
					}
				}
			}
			float weight = ExposureVolume.weight + Time.deltaTime * (blinded ? _enableSpeed : (0f - _disableSpeed));
			AdjustExposure(Mathf.Clamp01(weight));
		}

		private void AdjustExposure(float weight)
		{
			ExposureVolume.weight = weight;
		}
	}
}

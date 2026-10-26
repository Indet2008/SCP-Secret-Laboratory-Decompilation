using System.Text;
using MapGeneration;
using NorthwoodLib.Pools;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.PlayableScps.Scp079.Overcons;
using UnityEngine;
using UserSettings;
using UserSettings.ControlsSettings;

namespace PlayerRoles.PlayableScps.Scp079.Cameras
{
	public class Scp079DirectionalCameraSelector : Scp079KeyAbilityBase
	{
		private static string _translationNoCamera;

		private static string _translationPaidSwitch;

		private static string _translationFreeSwitch;

		private static bool _translationsSet;

		private static readonly Vector3Int[] WorldDirections = new Vector3Int[4]
		{
			new Vector3Int(-1, 0, 0),
			new Vector3Int(0, 0, -1),
			new Vector3Int(1, 0, 0),
			new Vector3Int(0, 0, 1)
		};

		private static readonly CachedUserSetting<bool> AllowKeybindZoneSwitching = new CachedUserSetting<bool>(MiscControlsSetting.Scp079KeybindZoneSwitching);

		[SerializeField]
		private ActionName _key;

		[SerializeField]
		private Vector3 _direction;

		private Scp079Camera _lastCamera;

		private bool _lastValid;

		private float _lastSwitchCost;

		private float _failMessageSwitchCost;

		protected virtual bool AllowSwitchingBetweenZones => AllowKeybindZoneSwitching.Value;

		public override bool IsReady
		{
			get
			{
				_lastValid = TryGetCamera(out _lastCamera);
				if (!_lastValid)
				{
					return false;
				}
				if (!AllowSwitchingBetweenZones && _lastCamera.Room.Zone != base.CurrentCamSync.CurrentCamera.Room.Zone)
				{
					return false;
				}
				_lastSwitchCost = base.CurrentCamSync.GetSwitchCost(_lastCamera);
				return _lastSwitchCost <= base.AuxManager.CurrentAux;
			}
		}

		public override ActionName ActivationKey => _key;

		public override bool IsVisible => !Scp079CursorManager.LockCameras;

		public override string FailMessage
		{
			get
			{
				if (!(base.AuxManager.CurrentAux < _failMessageSwitchCost))
				{
					return null;
				}
				return GetNoAuxMessage(_failMessageSwitchCost);
			}
		}

		public override string AbilityName
		{
			get
			{
				if (!_lastValid)
				{
					return _translationNoCamera;
				}
				return string.Format((_lastSwitchCost == 0f) ? _translationFreeSwitch : _translationPaidSwitch, _lastCamera.Label, _lastSwitchCost);
			}
		}

		protected virtual bool TryGetCamera(out Scp079Camera targetCamera)
		{
			targetCamera = null;
			bool result = false;
			Transform currentCamera = MainCameraController.CurrentCamera;
			Vector3 normalized = currentCamera.TransformDirection(_direction).normalized;
			Vector3Int vector3Int = Vector3Int.zero;
			float num = -1f;
			Vector3Int[] worldDirections = WorldDirections;
			foreach (Vector3Int vector3Int2 in worldDirections)
			{
				float num2 = Vector3.Dot(vector3Int2, normalized);
				if (!(num2 < num))
				{
					vector3Int = vector3Int2;
					num = num2;
				}
			}
			if (num <= 0f)
			{
				return false;
			}
			Vector3Int vector3Int3 = RoomUtils.PositionToCoords(currentCamera.position) + vector3Int;
			foreach (CameraOvercon visibleOvercon in CameraOverconRenderer.VisibleOvercons)
			{
				if (visibleOvercon.IsElevator)
				{
					continue;
				}
				Scp079Camera target = visibleOvercon.Target;
				if (!(RoomUtils.PositionToCoords(target.Position) != vector3Int3))
				{
					targetCamera = target;
					result = true;
					if (targetCamera.IsMain)
					{
						return true;
					}
				}
			}
			return result;
		}

		protected override void Trigger()
		{
			base.CurrentCamSync.ClientSwitchTo(_lastCamera);
		}

		protected override void Start()
		{
			base.Start();
			base.CurrentCamSync.OnCameraChanged += () =>
			{
				_failMessageSwitchCost = 0f;
			};
			if (_translationsSet)
			{
				return;
			}
			_translationsSet = true;
			_translationNoCamera = Translations.Get(Scp079HudTranslation.NoCamera);
			_translationPaidSwitch = Translations.Get(Scp079HudTranslation.GoToCamera);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			string[] array = _translationPaidSwitch.Split(' ');
			foreach (string text in array)
			{
				if (!text.Contains("{1}"))
				{
					stringBuilder.Append(text);
					stringBuilder.Append(' ');
				}
			}
			_translationFreeSwitch = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		private void OnDestroy()
		{
			_translationsSet = false;
		}

		public override void OnFailMessageAssigned()
		{
			_failMessageSwitchCost = (_lastValid ? _lastSwitchCost : 0f);
		}
	}
}

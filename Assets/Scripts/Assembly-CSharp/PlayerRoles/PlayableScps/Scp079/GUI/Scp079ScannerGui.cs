using System;
using PlayerRoles.PlayableScps.Scp079.Map;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079ScannerGui : Scp079GuiElementBase
	{
		private struct ToggleInstance
		{
			public CanvasGroup Fader;

			public Image ToggleImage;

			public Graphic Outline;

			public bool IsSet;
		}

		[Serializable]
		private struct TeamFilter
		{
			public Toggle Checkbox;

			public Team Team;
		}

		[SerializeField]
		private float _lerpSpeed;

		[SerializeField]
		private RectTransform _fillRect;

		[SerializeField]
		private TMP_Text _selectionText;

		[SerializeField]
		private RectOffset _padding;

		[SerializeField]
		private CanvasGroup _uiFader;

		[SerializeField]
		private GameObject _centerCursor;

		[SerializeField]
		private GameObject _toggleInstanceTemplate;

		[SerializeField]
		private Sprite _onIcon;

		[SerializeField]
		private Sprite _offIcon;

		[SerializeField]
		private Color _onOutlineColor;

		[SerializeField]
		private Color _offOutlineColor;

		[SerializeField]
		private float _zoneBorderWidth;

		[SerializeField]
		private TMP_Text _nextScanText;

		[SerializeField]
		private TMP_Text _targetCounterText;

		[SerializeField]
		private TMP_Text _filtersWarningText;

		[SerializeField]
		private Scp079DetectedPlayerIndicator _indicator;

		[SerializeField]
		private TeamFilter[] _teamFilters;

		[SerializeField]
		private AudioClip[] _zoneSelectClips;

		[SerializeField]
		private AudioClip _toggleFliterSound;

		[SerializeField]
		private AudioClip _detectedHumanSound;

		private bool _wasOpen;

		private int _prevZoneCnt;

		private int _prevTeamsCnt;

		private Scp079ScannerTracker _tracker;

		private Scp079ScannerZoneSelector _zoneSelector;

		private Scp079ScannerTeamFilterSelector _teamSelector;

		private CachedValue<Bounds> _combinedBounds;

		private CachedValue<IZoneMap[]> _zoneMaps;

		private CachedValue<ToggleInstance[]> _toggleInstances;

		private static CachedValue<Vector3> _pos;

		public static float MapZoom => _pos?.Value.z ?? 1f;

		public static Vector2 MapPos => _pos?.Value ?? ((Vector3)Vector2.zero);

		public static float AnimInterpolant { get; private set; }

		private Bounds GenerateCombinedBounds()
		{
			int num = _zoneMaps.Value.Length;
			if (num == 0)
			{
				throw new InvalidOperationException("Cannot set cache of Breach Scanner zone maps before they are generated.");
			}
			bool flag = false;
			Bounds result = default;
			for (int i = 0; i < num; i++)
			{
				IZoneMap obj = _zoneMaps.Value[i];
				Bounds rectBounds = obj.RectBounds;
				if (!flag)
				{
					result = rectBounds;
					flag = true;
				}
				else
				{
					result.Encapsulate(rectBounds);
				}
				if (!obj.Ready)
				{
					_combinedBounds.SetDirty();
				}
			}
			result.SetMinMax(new Vector2(result.min.x - (float)_padding.left, result.min.y - (float)_padding.bottom), new Vector2(result.max.x + (float)_padding.right, result.max.y + (float)_padding.top));
			return result;
		}

		private ToggleInstance[] GenerateToggleInstances()
		{
			IZoneMap[] value = _zoneMaps.Value;
			ToggleInstance[] array = new ToggleInstance[value.Length];
			for (int i = 0; i < value.Length; i++)
			{
				if (value[i] is MonoBehaviour monoBehaviour)
				{
					GameObject gameObject = UnityEngine.Object.Instantiate(_toggleInstanceTemplate, monoBehaviour.transform);
					Button component = gameObject.GetComponent<Button>();
					RectTransform rectTransform = component.transform as RectTransform;
					array[i] = new ToggleInstance
					{
						IsSet = true,
						Fader = gameObject.GetComponent<CanvasGroup>(),
						Outline = (component.targetGraphic as Image),
						ToggleImage = rectTransform.GetChild(0).GetComponent<Image>()
					};
					int iCopy = i;
					component.onClick.AddListener(() =>
					{
						ProcessButtonEvent(iCopy);
					});
					Bounds rectBounds = value[i].RectBounds;
					rectTransform.anchoredPosition = rectBounds.center;
					rectTransform.sizeDelta = rectBounds.size + Vector3.one * _zoneBorderWidth;
				}
			}
			return array;
		}

		private void ProcessButtonEvent(int instanceId)
		{
			_zoneSelector.ToggleZoneStatus(_zoneMaps.Value[instanceId].Zone);
			RefreshZoneToggles();
		}

		private void RefreshZoneToggles()
		{
			ToggleInstance[] value = _toggleInstances.Value;
			for (int i = 0; i < value.Length; i++)
			{
				ToggleInstance toggleInstance = value[i];
				if (toggleInstance.IsSet)
				{
					bool zoneStatus = _zoneSelector.GetZoneStatus(_zoneMaps.Value[i].Zone);
					toggleInstance.Outline.color = (zoneStatus ? _onOutlineColor : _offOutlineColor);
					toggleInstance.ToggleImage.sprite = (zoneStatus ? _onIcon : _offIcon);
				}
			}
			int selectedZonesCnt = _zoneSelector.SelectedZonesCnt;
			Scp079HudTranslation val = ((selectedZonesCnt == 0) ? Scp079HudTranslation.ScannerNoZoneSelectedLabel : Scp079HudTranslation.ScannerSelectedZoneCntLabel);
			_selectionText.text = string.Format(Translations.Get(val), selectedZonesCnt);
			if (_prevZoneCnt != selectedZonesCnt)
			{
				PlaySound(_zoneSelectClips[Mathf.Min(selectedZonesCnt, _zoneSelectClips.Length - 1)]);
				_prevZoneCnt = selectedZonesCnt;
			}
		}

		private void RefreshFilters()
		{
			int num = 0;
			TeamFilter[] teamFilters = _teamFilters;
			for (int i = 0; i < teamFilters.Length; i++)
			{
				TeamFilter teamFilter = teamFilters[i];
				bool teamStatus = _teamSelector.GetTeamStatus(teamFilter.Team);
				teamFilter.Checkbox.SetIsOnWithoutNotify(teamStatus);
				if (teamStatus)
				{
					num++;
				}
			}
			_filtersWarningText.enabled = num == 0;
			if (num != _prevTeamsCnt)
			{
				if (_wasOpen)
				{
					PlaySound(_toggleFliterSound);
				}
				_prevTeamsCnt = num;
			}
		}

		private void OnHumanDetected(ReferenceHub hub)
		{
			PlaySound(_detectedHumanSound);
			Scp079DetectedPlayerIndicator scp079DetectedPlayerIndicator = UnityEngine.Object.Instantiate(_indicator);
			scp079DetectedPlayerIndicator.Setup(hub, _zoneMaps.Value, base.transform as RectTransform);
			scp079DetectedPlayerIndicator.gameObject.SetActive(value: true);
		}

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			AnimInterpolant = 0f;
			role.SubroutineModule.TryGetSubroutine<Scp079ScannerTracker>(out _tracker);
			role.SubroutineModule.TryGetSubroutine<Scp079ScannerZoneSelector>(out _zoneSelector);
			role.SubroutineModule.TryGetSubroutine<Scp079ScannerTeamFilterSelector>(out _teamSelector);
			_tracker.OnDetected += OnHumanDetected;
			_prevZoneCnt = _zoneSelector.SelectedZonesCnt;
			_combinedBounds = new CachedValue<Bounds>(GenerateCombinedBounds);
			_toggleInstances = new CachedValue<ToggleInstance[]>(GenerateToggleInstances);
			_zoneMaps = new CachedValue<IZoneMap[]>(() => GetComponentsInChildren<IZoneMap>());
			_pos = new CachedValue<Vector3>(() =>
			{
				Bounds value = _combinedBounds.Value;
				Vector2 vector = _fillRect.rect.size / value.size;
				float num2 = Mathf.Min(vector.x, vector.y);
				float num3 = 1f / num2;
				Vector3 vector2 = _fillRect.localPosition * num3;
				Vector2 vector3 = _fillRect.rect.size * num3 / 2f;
				return new Vector3(0f - value.center.x - vector3.x, 0f - value.center.y, num2) + vector2;
			});
			TeamFilter[] teamFilters = _teamFilters;
			for (int num = 0; num < teamFilters.Length; num++)
			{
				TeamFilter filter = teamFilters[num];
				if (!role.IsLocalPlayer)
				{
					filter.Checkbox.interactable = false;
					continue;
				}
				filter.Checkbox.onValueChanged.AddListener((bool isOn) =>
				{
					_teamSelector.SetTeamStatus(filter.Team, isOn);
					RefreshFilters();
				});
			}
		}

		private void OnDestroy()
		{
			_tracker.OnDetected -= OnHumanDetected;
		}

		private void Update()
		{
			bool visible = Scp079ToggleMenuAbilityBase<Scp079ScannerMenuToggler>.Visible;
			float target = (visible ? 1 : 0);
			float animInterpolant = AnimInterpolant;
			AnimInterpolant = Mathf.MoveTowards(animInterpolant, target, Time.deltaTime * _lerpSpeed);
			if (visible)
			{
				UpdateOpen();
			}
			_wasOpen = visible;
			_centerCursor.SetActive(!visible);
			if (animInterpolant != AnimInterpolant)
			{
				UpdateLayout();
			}
		}

		private void UpdateOpen()
		{
			IZoneMap[] value = _zoneMaps.Value;
			for (int i = 0; i < value.Length; i++)
			{
				if (!value[i].Ready)
				{
					return;
				}
			}
			bool flag = !Scp079Role.LocalInstanceActive;
			if (!_wasOpen | flag)
			{
				_pos?.SetDirty();
				RefreshZoneToggles();
				RefreshFilters();
			}
			_nextScanText.text = _tracker.StatusText;
		}

		private void UpdateLayout()
		{
			bool blocksRaycasts = Scp079ToggleMenuAbilityBase<Scp079ScannerMenuToggler>.Visible && Scp079Role.LocalInstanceActive;
			_uiFader.alpha = AnimInterpolant;
			_uiFader.blocksRaycasts = blocksRaycasts;
			ToggleInstance[] value = _toggleInstances.Value;
			for (int i = 0; i < value.Length; i++)
			{
				ToggleInstance toggleInstance = value[i];
				if (toggleInstance.IsSet)
				{
					toggleInstance.Fader.blocksRaycasts = blocksRaycasts;
					toggleInstance.Fader.alpha = AnimInterpolant;
				}
			}
			_targetCounterText.alpha = 1f - AnimInterpolant;
		}
	}
}

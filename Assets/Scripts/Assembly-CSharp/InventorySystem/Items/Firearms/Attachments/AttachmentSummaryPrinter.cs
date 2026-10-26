using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;
using UserSettings;
using UserSettings.UserInterfaceSettings;

namespace InventorySystem.Items.Firearms.Attachments
{
	public class AttachmentSummaryPrinter : MonoBehaviour
	{
		private class ComparableStat
		{
			private readonly Func<Firearm, float> _fetcher;

			private readonly Func<bool> _validator;

			private readonly bool _moreIsBetter;

			private readonly string _unit;

			private readonly string _translationKey;

			private readonly int _translationIndex;

			public string Label => TranslationReader.Get(_translationKey, _translationIndex);

			public bool Ignored
			{
				get
				{
					if (_validator != null)
					{
						return !_validator();
					}
					return false;
				}
			}

			private float Round(float f)
			{
				return Mathf.Round(f * 100f) / 100f;
			}

			public string CompareTo(AttachmentSummaryPrinter printer, Firearm fa, float otherValue)
			{
				float value = GetValue(fa);
				string text = Round(value) + _unit;
				if (Round(value) == Round(otherValue))
				{
					return text;
				}
				bool flag = value > otherValue;
				string text2 = ((_moreIsBetter ? flag : (!flag)) ? printer._goodColor : printer._badColor);
				return "<color=#" + text2 + ">" + text + "</color>";
			}

			public float GetValue(Firearm fa)
			{
				return _fetcher(fa);
			}

			public ComparableStat(Func<Firearm, float> fetcher, string unit, bool moreIsBetter, string translationKey, int translationIndex, Func<bool> validator = null)
			{
				_fetcher = fetcher;
				_translationKey = translationKey;
				_translationIndex = translationIndex;
				_unit = unit;
				_moreIsBetter = moreIsBetter;
				_validator = validator;
			}

			public ComparableStat(Func<Firearm, float> fetcher, string unit, bool moreIsBetter, AttachmentParam param, Func<bool> validator = null)
				: this(fetcher, unit, moreIsBetter, "AttachmentParameters", (int)param, validator)
			{
			}
		}

		[Serializable]
		private readonly struct ComparableConfiguration
		{
			public readonly string ConfigurationName;

			public readonly uint Code;

			public ComparableConfiguration(ItemType weapon, string label, uint code)
			{
				bool flag = AttachmentPreferences.GetSavedPreferenceCode(weapon) == code;
				ConfigurationName = string.Format(flag ? "<b><u>{0}</u></b>" : "{0}", label);
				Code = code;
			}
		}

		private const string InventoryTranslationKey = "InventoryGUI";

		private const float InchesToCm = 2.54f;

		private const float KilogramsToLbs = 2.20462f;

		private const float DegreesToMOAs = 60f;

		private static readonly ComparableStat[] StatsToCompare = new ComparableStat[21]
		{
			new ComparableStat((Firearm fa) => GetStatSafe(fa, (IHitregModule x) => x.DisplayDamage), "", moreIsBetter: true, AttachmentParam.DamageMultiplier),
			new ComparableStat((Firearm fa) => GetStatSafe(fa, (IHitregModule x) => x.DisplayPenetration * 100f), "%", moreIsBetter: true, AttachmentParam.PenetrationMultiplier),
			new ComparableStat((Firearm fa) => GetStatSafe(fa, (IActionModule x) => x.DisplayCyclicRate * 60f), "/MIN", moreIsBetter: true, AttachmentParam.FireRateMultiplier),
			new ComparableStat((Firearm fa) => GetStatSafe(fa, (IDisplayableRecoilProviderModule x) => Mathf.Round(x.DisplayHipRecoilDegrees * 60f)), "′", moreIsBetter: false, AttachmentParam.OverallRecoilMultiplier),
			new ComparableStat((Firearm fa) => GetStatSafe(fa, (IDisplayableRecoilProviderModule x) => Mathf.Round(x.DisplayAdsRecoilDegrees * 60f)), "′", moreIsBetter: false, AttachmentParam.AdsRecoilMultiplier),
			new ComparableStat((Firearm fa) => GetStatSafe(fa, (IPrimaryAmmoContainerModule x) => x.AmmoMax), "", moreIsBetter: true, AttachmentParam.MagazineCapacityModifier),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa).BulletDeg, "°", moreIsBetter: false, AttachmentParam.BulletInaccuracyMultiplier, UsesDispersionMode),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa).AdsDeg, "°", moreIsBetter: false, AttachmentParam.AdsInaccuracyMultiplier, UsesDispersionMode),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa, addBulletToRest: true).GetAdsAccurateRange(imperial: false, rounded: true), " m", moreIsBetter: true, AttachmentParam.AdsInaccuracyMultiplier, () => UsesEffectiveRangeMode() && UsesMetric()),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa, addBulletToRest: true).GetAdsAccurateRange(imperial: true, rounded: true), " yd", moreIsBetter: true, AttachmentParam.AdsInaccuracyMultiplier, () => UsesEffectiveRangeMode() && UsesImperial()),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa).HipDeg, "°", moreIsBetter: false, AttachmentParam.HipInaccuracyMultiplier, UsesDispersionMode),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa, addBulletToRest: true).GetHipAccurateRange(imperial: false, rounded: true), " m", moreIsBetter: true, AttachmentParam.HipInaccuracyMultiplier, () => UsesEffectiveRangeMode() && UsesMetric()),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa, addBulletToRest: true).GetHipAccurateRange(imperial: true, rounded: true), " yd", moreIsBetter: true, AttachmentParam.HipInaccuracyMultiplier, () => UsesEffectiveRangeMode() && UsesImperial()),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa).RunningDeg, "°", moreIsBetter: false, AttachmentParam.RunningInaccuracyMultiplier, UsesDispersionMode),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa, addBulletToRest: true).GetRunningAccurateRange(imperial: false, rounded: true), " m", moreIsBetter: true, AttachmentParam.RunningInaccuracyMultiplier, () => UsesEffectiveRangeMode() && UsesMetric()),
			new ComparableStat((Firearm fa) => IDisplayableInaccuracyProviderModule.GetCombinedDisplayInaccuracy(fa, addBulletToRest: true).GetRunningAccurateRange(imperial: true, rounded: true), " yd", moreIsBetter: true, AttachmentParam.RunningInaccuracyMultiplier, () => UsesEffectiveRangeMode() && UsesImperial()),
			new ComparableStat((Firearm fa) => GetStatSafe(fa, (IEquipperModule x) => x.GetDisplayEffectiveEquipTime(fa)), " s", moreIsBetter: false, AttachmentParam.DrawTimeModifier),
			new ComparableStat((Firearm fa) => fa.TotalLengthInches() * 2.54f, " cm", moreIsBetter: false, "InventoryGUI", 6, UsesMetric),
			new ComparableStat((Firearm fa) => fa.TotalLengthInches(), "″", moreIsBetter: false, "InventoryGUI", 6, UsesImperial),
			new ComparableStat((Firearm fa) => fa.TotalWeightKg(), " kg", moreIsBetter: false, "InventoryGUI", 5, UsesMetric),
			new ComparableStat((Firearm fa) => fa.TotalWeightKg() * 2.20462f, " lbs", moreIsBetter: false, "InventoryGUI", 5, UsesImperial)
		};

		private static readonly List<string>[] ComparisonResults = new List<string>[StatsToCompare.Length];

		private static readonly float[] OriginalDataNonAlloc = new float[StatsToCompare.Length];

		private readonly Queue<AttachmentSummaryEntry> _entryPool = new Queue<AttachmentSummaryEntry>();

		private readonly HashSet<AttachmentSummaryEntry> _spawnedEntires = new HashSet<AttachmentSummaryEntry>();

		private readonly HashSet<uint> _displayedCodes = new HashSet<uint>();

		private readonly List<ComparableConfiguration> _displayedConfigurations = new List<ComparableConfiguration>();

		private Firearm _prevFirearm;

		[SerializeField]
		private AttachmentSelectorBase _selectorReference;

		[SerializeField]
		private AttachmentSummaryEntry _tableHeader;

		[SerializeField]
		private AttachmentSummaryEntry _entryTemplate;

		[SerializeField]
		private int _displayedPresets;

		[SerializeField]
		private string _goodColor;

		[SerializeField]
		private string _badColor;

		[SerializeField]
		private Color _oddEntryColor;

		private Firearm Firearm => _selectorReference.SelectedFirearm;

		private static float GetStatSafe<T>(Firearm fa, Func<T, float> selector, float fallback = 0f)
		{
			if (!fa.TryGetModule<T>(out var module))
			{
				return fallback;
			}
			return selector(module);
		}

		private static bool UsesImperial()
		{
			return UserSetting<bool>.Get(UISetting.ImperialUnits);
		}

		private static bool UsesMetric()
		{
			return !UsesImperial();
		}

		private static bool UsesDispersionMode()
		{
			return UserSetting<bool>.Get(UISetting.InaccuracyAsDispersion);
		}

		private static bool UsesEffectiveRangeMode()
		{
			return !UsesDispersionMode();
		}

		private void OnEnable()
		{
			Refresh();
		}

		private void Update()
		{
			if (!(Firearm == _prevFirearm))
			{
				_prevFirearm = Firearm;
				Refresh();
			}
		}

		private void Refresh()
		{
			if (Firearm == null)
			{
				_selectorReference.ToggleSummaryScreen(summary: false);
				return;
			}
			uint currentAttachmentsCode = Firearm.GetCurrentAttachmentsCode();
			PrepareConfigurations(currentAttachmentsCode);
			int count = _displayedConfigurations.Count;
			_tableHeader.Setup(Firearm.Name, count, (int index) => _displayedConfigurations[index].ConfigurationName, isOdd: false);
			for (int num = 0; num < count; num++)
			{
				UpdateComparableData(num);
			}
			bool flag = false;
			int i;
			for (i = 0; i < ComparisonResults.Length; i++)
			{
				if (!StatsToCompare[i].Ignored)
				{
					if (!_entryPool.TryDequeue(out var result))
					{
						result = UnityEngine.Object.Instantiate(_entryTemplate, _entryTemplate.transform.parent);
					}
					result.gameObject.SetActive(value: true);
					result.Setup(StatsToCompare[i].Label, count, (int resultIndex) => ComparisonResults[i][resultIndex], flag);
					_spawnedEntires.Add(result);
					flag = !flag;
				}
			}
			Firearm.ApplyAttachmentsCode(currentAttachmentsCode, reValidate: true);
		}

		private void UpdateComparableData(int indexToCompare)
		{
			Firearm.ApplyAttachmentsCode(_displayedConfigurations[indexToCompare].Code, reValidate: false);
			for (int i = 0; i < StatsToCompare.Length; i++)
			{
				ComparableStat comparableStat = StatsToCompare[i];
				if (!comparableStat.Ignored)
				{
					List<string> list = ComparisonResults[i];
					if (list == null)
					{
						list = new List<string>();
						ComparisonResults[i] = list;
					}
					if (indexToCompare == 0)
					{
						OriginalDataNonAlloc[i] = comparableStat.GetValue(Firearm);
					}
					while (list.Count <= indexToCompare)
					{
						list.Add(string.Empty);
					}
					list[indexToCompare] = comparableStat.CompareTo(this, Firearm, OriginalDataNonAlloc[i]);
				}
			}
		}

		private void PrepareConfigurations(uint initial)
		{
			foreach (AttachmentSummaryEntry spawnedEntire in _spawnedEntires)
			{
				if (!(spawnedEntire == null))
				{
					spawnedEntire.gameObject.SetActive(value: false);
					_entryPool.Enqueue(spawnedEntire);
				}
			}
			_spawnedEntires.Clear();
			_displayedCodes.Clear();
			_displayedConfigurations.Clear();
			AddConfiguration(0u, Translations.Get(AttachmentEditorsTranslation.DefaultAttachments), forceAdd: true);
			if (AttachmentPreferences.GetPreset(Firearm.ItemTypeId) == 0)
			{
				AddConfiguration(initial, Translations.Get(AttachmentEditorsTranslation.Custom), forceAdd: true);
			}
			for (int i = 1; i <= _displayedPresets; i++)
			{
				uint preferenceCodeOfPreset = AttachmentPreferences.GetPreferenceCodeOfPreset(Firearm.ItemTypeId, i);
				AddConfiguration(preferenceCodeOfPreset, string.Format(Translations.Get(AttachmentEditorsTranslation.PresetId), i));
			}
		}

		private void AddConfiguration(uint attachmentCode, string label, bool forceAdd = false)
		{
			uint num = Firearm.ValidateAttachmentsCode(attachmentCode);
			if (_displayedCodes.Add(num) || forceAdd)
			{
				_displayedConfigurations.Add(new ComparableConfiguration(Firearm.ItemTypeId, label, num));
			}
		}
	}
}

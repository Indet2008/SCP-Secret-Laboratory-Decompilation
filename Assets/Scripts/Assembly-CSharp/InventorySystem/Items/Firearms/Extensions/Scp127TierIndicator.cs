using System.Diagnostics;
using AudioPooling;
using InventorySystem.Items.Firearms.Modules.Scp127;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class Scp127TierIndicator : MonoBehaviour, IViewmodelExtension
	{
		private class TierLevel
		{
			private readonly Scp127Tier _tier;

			private readonly int _baseColorHash;

			private readonly int _emissionColorHash;

			private readonly int _sliderHash;

			private const string BaseColorPrefix = "_BaseColor";

			private const string EmissionColorPrefix = "_EmissionColor";

			private const string SliderPrefix = "_Fill";

			private float _lastSlider;

			public TierLevel(Scp127Tier tier)
			{
				_tier = tier;
				_baseColorHash = Shader.PropertyToID("_BaseColor" + tier);
				_emissionColorHash = Shader.PropertyToID("_EmissionColor" + tier);
				_sliderHash = Shader.PropertyToID("_Fill" + tier);
			}

			public void Update(Scp127Tier tier, float nextProgress, float delta, Color glow)
			{
				Color value;
				bool flag;
				float b;
				if (_tier <= tier)
				{
					value = UnlockedColor;
					flag = true;
					b = 1f;
				}
				else if (_tier == tier + 1)
				{
					value = ProgressColor;
					flag = false;
					b = nextProgress;
				}
				else
				{
					value = InactiveColor;
					flag = false;
					b = 0f;
				}
				_lastSlider = Mathf.Lerp(_lastSlider, b, delta);
				_propertyBlock.SetFloat(_sliderHash, _lastSlider);
				_propertyBlock.SetColor(_baseColorHash, value);
				_propertyBlock.SetColor(_emissionColorHash, flag ? glow : Color.black);
			}
		}

		private static readonly Color UnlockedColor = Color.white;

		private static readonly Color ProgressColor = Color.grey;

		private static readonly Color InactiveColor = Color.black;

		private static MaterialPropertyBlock _propertyBlock;

		[SerializeField]
		private Renderer _renderer;

		[SerializeField]
		private AudioClip _levelUpSound;

		[SerializeField]
		private float _lerpSpeed;

		[SerializeField]
		private float _levelUpLength;

		[SerializeField]
		private AnimationCurve _progressCorrectionCurve;

		[GradientUsage(true)]
		[SerializeField]
		private Gradient _levelUpGradient;

		private Firearm _firearm;

		private TierLevel[] _tierLevels;

		private Scp127Tier _lastTier;

		private readonly Stopwatch _levelUpSw = new Stopwatch();

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_firearm = viewmodel.ParentFirearm;
			_lastTier = Scp127TierManagerModule.GetTierForItem(_firearm);
			if (_propertyBlock == null)
			{
				_propertyBlock = new MaterialPropertyBlock();
				_renderer.GetPropertyBlock(_propertyBlock);
			}
			Scp127Tier[] values = EnumUtils<Scp127Tier>.Values;
			_tierLevels = new TierLevel[values.Length];
			for (int i = 0; i < values.Length; i++)
			{
				_tierLevels[i] = new TierLevel(values[i]);
			}
			UpdateMaterial(instant: true);
		}

		private void Update()
		{
			UpdateMaterial(instant: false);
		}

		private void UpdateMaterial(bool instant)
		{
			Scp127TierManagerModule.GetTierAndProgressForItem(_firearm, out var tier, out var progress);
			double num = _levelUpSw.Elapsed.TotalSeconds / (double)_levelUpLength;
			Color glow = _levelUpGradient.Evaluate((float)num);
			float nextProgress = _progressCorrectionCurve.Evaluate(progress);
			float delta = (instant ? 1f : (Time.deltaTime * _lerpSpeed));
			TierLevel[] tierLevels = _tierLevels;
			for (int i = 0; i < tierLevels.Length; i++)
			{
				tierLevels[i].Update(tier, nextProgress, delta, glow);
			}
			if (_lastTier != tier)
			{
				_levelUpSw.Restart();
				AudioSourcePoolManager.Play2DWithParent(_levelUpSound, _firearm.transform, 1f, MixerChannel.NoDucking);
				_lastTier = tier;
			}
			_renderer.SetPropertyBlock(_propertyBlock);
		}
	}
}

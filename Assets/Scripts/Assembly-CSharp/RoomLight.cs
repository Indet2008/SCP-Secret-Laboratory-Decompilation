using System;
using System.Collections.Generic;
using System.Diagnostics;
using ProgressiveCulling;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UserSettings;
using UserSettings.VideoSettings;

public class RoomLight : CullableBehaviour, IBoundsCullable, ICullable
{
	public static readonly Color DefaultWarheadColor = new Color(1f, 0.2f, 0.2f);

	private static readonly int EmissionColor = Shader.PropertyToID("_EmissiveColor");

	private static readonly int BlackoutProperty = Shader.PropertyToID("_BlackoutEmissionMultiplier");

	private static readonly CachedUserSetting<bool> FacilityLightsSetting = new CachedUserSetting<bool>(LightingVideoSetting.RenderLights);

	private static readonly HashSet<RoomLight> RenderedInstances = new HashSet<RoomLight>();

	[SerializeField]
	private int _materialId;

	[SerializeField]
	private Renderer[] _renderers;

	[SerializeField]
	private bool _excludeFromRecoloring;

	[Tooltip("Only used if no light source is detected. Does not need to be accurate, default should be sufficent unless you see objects culling while visible.")]
	[SerializeField]
	private float _lightSize = 3f;

	private Material _copy;

	private Transform _centerTr;

	private int _rendererCount;

	private bool _useEmissionMatProperty;

	private bool _useBlackoutMatProperty;

	private bool _isDirty;

	private bool _cacheSet;

	private bool _warheadInProgress;

	private bool _overrideColorSet;

	private bool _preventSubCulling;

	private bool _targetBlackout;

	private readonly Stopwatch _blackoutAnimProgress = new Stopwatch();

	private Color _overrideColor;

	private Color _initialLightColor;

	private Color _initialMaterialColor;

	internal bool HasLight;

	internal Light LightSource { get; private set; }

	public override bool ShouldBeVisible
	{
		get
		{
			if (!_preventSubCulling)
			{
				return CullingCamera.CheckBoundsVisibility(WorldspaceBounds);
			}
			return true;
		}
	}

	public Bounds WorldspaceBounds
	{
		get
		{
			UpdateCache();
			return new Bounds(_centerTr.position, Vector3.one * _lightSize);
		}
	}

	private void UpdateCache()
	{
		if (_cacheSet)
		{
			return;
		}
		_cacheSet = true;
		_rendererCount = _renderers.Length;
		LightSource = GetComponentInChildren<Light>();
		HasLight = LightSource != null;
		if (!HasLight)
		{
			_centerTr = base.transform;
			return;
		}
		_centerTr = LightSource.transform;
		_initialLightColor = LightSource.color;
		_lightSize = LightSource.range * 2f;
		if (LightSource.TryGetComponent<HDAdditionalLightData>(out var component))
		{
			HDLightType type = component.type;
			if (type == HDLightType.Directional || type == HDLightType.Area)
			{
				_preventSubCulling = true;
			}
		}
	}

	private void OnValidate()
	{
		_cacheSet = false;
	}

	private void Awake()
	{
		UpdateCache();
		if (_centerTr.TryGetComponentInParent<CullableRoom>(out var comp))
		{
			comp.AddChildCullable(this);
		}
		if (_rendererCount > 0)
		{
			_copy = new Material(_renderers[0].sharedMaterials[_materialId]);
			for (int i = 0; i < _rendererCount; i++)
			{
				Material[] sharedMaterials = _renderers[i].sharedMaterials;
				sharedMaterials[_materialId] = _copy;
				_renderers[i].materials = sharedMaterials;
			}
			if (_copy.HasProperty(EmissionColor))
			{
				_useEmissionMatProperty = true;
				_initialMaterialColor = _copy.GetColor(EmissionColor);
			}
			if (_copy.HasProperty(BlackoutProperty))
			{
				_useBlackoutMatProperty = true;
			}
			UpdateWarhead(AlphaWarheadController.InProgress);
		}
	}

	protected override void UpdateVisible()
	{
		base.UpdateVisible();
		if (_isDirty)
		{
			UpdateIntensity();
		}
	}

	private void OnDestroy()
	{
		RenderedInstances.Remove(this);
	}

	private void MarkAsDirty()
	{
		_isDirty = true;
		UpdateIntensity();
	}

	private void UpdateWarhead(bool val)
	{
		_warheadInProgress = val;
		MarkAsDirty();
	}

	private void UpdateIntensity()
	{
		Color matColor;
		Color lightColor;
		if (_overrideColorSet)
		{
			matColor = _overrideColor;
			lightColor = _overrideColor;
		}
		else
		{
			matColor = (_warheadInProgress ? DefaultWarheadColor : _initialMaterialColor);
			lightColor = (_warheadInProgress ? DefaultWarheadColor : _initialLightColor);
		}
		if (!_blackoutAnimProgress.IsRunning)
		{
			_isDirty = false;
			SetColors(lightColor, matColor, (!_targetBlackout) ? 1 : 0);
			return;
		}
		float num = Mathf.Clamp01((float)_blackoutAnimProgress.Elapsed.TotalSeconds);
		float intensity = (_targetBlackout ? FlickerBlackout(num) : FlickerReEnabling(num));
		SetColors(lightColor, matColor, intensity);
		if (!(num < 1f))
		{
			_blackoutAnimProgress.Stop();
		}
	}

	private float FlickerBlackout(float f)
	{
		float num = f * f * f * f;
		return Mathf.Sin(MathF.PI * f * 20f) * (1f - num);
	}

	private float FlickerReEnabling(float f)
	{
		if (Mathf.Approximately(f, 0f))
		{
			return 0f;
		}
		float num = f * f * f;
		return f / (Mathf.Cos(MathF.PI / num) + 2f);
	}

	private void SetColors(Color lightColor, Color matColor, float intensity)
	{
		if (_excludeFromRecoloring)
		{
			return;
		}
		if (_rendererCount > 0)
		{
			if (_useEmissionMatProperty)
			{
				_copy.SetColor(EmissionColor, matColor * intensity);
			}
			if (_useBlackoutMatProperty)
			{
				_copy.SetFloat(BlackoutProperty, intensity);
			}
		}
		if (HasLight)
		{
			LightSource.color = lightColor * intensity;
		}
	}

	internal void SetOverrideColor(Color overrideColor)
	{
		_overrideColorSet = true;
		_overrideColor = overrideColor;
		MarkAsDirty();
	}

	internal void ResetOverrideColor()
	{
		_overrideColorSet = false;
		MarkAsDirty();
	}

	internal void SetBlackout(bool state)
	{
		_targetBlackout = state;
		_blackoutAnimProgress.Restart();
		MarkAsDirty();
	}

	protected override void OnVisibilityChanged(bool isVisible)
	{
		base.gameObject.SetActive(isVisible && FacilityLightsSetting.Value);
		if (isVisible)
		{
			UpdateWarhead(AlphaWarheadController.InProgress);
			RenderedInstances.Add(this);
		}
		else
		{
			RenderedInstances.Remove(this);
		}
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		AlphaWarheadController.OnProgressChanged += OnWarheadChanged;
		UserSetting<bool>.AddListener(LightingVideoSetting.RenderLights, OnRenderLightsSettingChanged);
	}

	private static void OnRenderLightsSettingChanged(bool newSetting)
	{
		foreach (RoomLight renderedInstance in RenderedInstances)
		{
			if (!renderedInstance.IsCulled)
			{
				renderedInstance.gameObject.SetActive(newSetting);
			}
		}
	}

	private static void OnWarheadChanged(bool newProgress)
	{
		foreach (RoomLight renderedInstance in RenderedInstances)
		{
			renderedInstance.UpdateWarhead(newProgress);
		}
	}
}

using System;
using InventorySystem.Items.Firearms.Attachments.Components;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	[PresetPrefabExtension("Holo Sight Renderer", false)]
	public class ViewmodelReflexSightExtension : MonoBehaviour, IViewmodelExtension
	{
		private static readonly int HashTexture = Shader.PropertyToID("_CrosshairTex");

		private static readonly int HashColor = Shader.PropertyToID("_CrosshairColor");

		private static readonly int HashSize = Shader.PropertyToID("_SizeMultiplier");

		private static readonly GameObject[] RelativesNonAlloc = new GameObject[4];

		private static Material _materialInstance;

		private Firearm _firearm;

		private ReflexSightAttachment _sightAtt;

		private Color _targetColor;

		private float? _prevAds;

		private bool _initialized;

		[SerializeField]
		private Renderer _targetRenderer;

		private void LateUpdate()
		{
			if (_firearm.TryGetModule<IAdsModule>(out var module))
			{
				float adsAmount = module.AdsAmount;
				if (!_prevAds.HasValue || _prevAds.Value != adsAmount)
				{
					_materialInstance.SetColor(HashColor, _targetColor * adsAmount);
					_prevAds = adsAmount;
				}
			}
		}

		private void OnEnable()
		{
			if (_initialized)
			{
				UpdateValues();
			}
		}

		private void UpdateValues()
		{
			SetMaterial(_sightAtt.TextureOptions[_sightAtt.CurTextureIndex], ReflexSightAttachment.Sizes[_sightAtt.CurSizeIndex], ReflexSightAttachment.Colors[_sightAtt.CurColorIndex], ReflexSightAttachment.BrightnessLevels[_sightAtt.CurBrightnessIndex]);
		}

		private void SetMaterial(Texture texture, float size, Color color, float brigthness)
		{
			_materialInstance.SetTexture(HashTexture, texture);
			_materialInstance.SetFloat(HashSize, size);
			_targetColor = Color.Lerp(color, Color.white, brigthness);
			_prevAds = null;
		}

		private void FindSightAttachment(AnimatedFirearmViewmodel viewmodel)
		{
			int relativesCount = 0;
			GameObject gameObject = base.gameObject;
			do
			{
				RelativesNonAlloc[relativesCount++] = gameObject;
				gameObject = gameObject.transform.parent.gameObject;
			}
			while (!(gameObject == null) && relativesCount != RelativesNonAlloc.Length);
			for (int i = 0; i < viewmodel.Attachments.Length; i++)
			{
				GameObject[] array = viewmodel.Attachments[i].Group;
				for (int j = 0; j < array.Length; j++)
				{
					if (IsRelated(array[j]))
					{
						_sightAtt = _firearm.Attachments[i] as ReflexSightAttachment;
						return;
					}
				}
			}
			Debug.LogError("No reflex sight attachment found for '" + base.name + "'!");
			bool IsRelated(GameObject other)
			{
				for (int k = 0; k < relativesCount; k++)
				{
					if (other == RelativesNonAlloc[k])
					{
						return true;
					}
				}
				return false;
			}
		}

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_firearm = viewmodel.ParentFirearm;
			if (_materialInstance == null)
			{
				_materialInstance = new Material(_targetRenderer.material);
			}
			_targetRenderer.sharedMaterial = _materialInstance;
			FindSightAttachment(viewmodel);
			UpdateValues();
			ReflexSightAttachment sightAtt = _sightAtt;
			sightAtt.OnValuesChanged = (Action)Delegate.Combine(sightAtt.OnValuesChanged, new Action(UpdateValues));
			_initialized = true;
		}
	}
}

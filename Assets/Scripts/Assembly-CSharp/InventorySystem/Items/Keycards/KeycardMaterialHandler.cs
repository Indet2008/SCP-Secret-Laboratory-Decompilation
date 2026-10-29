using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class KeycardMaterialHandler
	{
		private readonly struct CompositeKey
		{
			public readonly Material Template;

			public readonly Color Tint;

			public readonly Color PermsColor;

			public readonly Vector3 Steps;

			public CompositeKey(Material template, Color tint, Color permsColor, Vector3 steps)
			{
				Template = template;
				Tint = tint;
				PermsColor = permsColor;
				Steps = steps;
			}
		}

		private class CompositeEntry
		{
			public RenderTexture Texture;

			public int Users;
		}

		private static readonly Dictionary<Material, Stack<Material>> Pool = new Dictionary<Material, Stack<Material>>();

		private static readonly Dictionary<CompositeKey, CompositeEntry> Composites = new Dictionary<CompositeKey, CompositeEntry>();

		private static readonly Dictionary<Material, Material> CompositeMaterials = new Dictionary<Material, Material>();

		private static readonly int MainTexId = Shader.PropertyToID("_MainTex");

		private static readonly int MaskId = Shader.PropertyToID("_Mask");

		private static readonly int PermsMaskId = Shader.PropertyToID("_PermsMask");

		private static readonly int TintId = Shader.PropertyToID("_Tint");

		private static readonly int PermsColorId = Shader.PropertyToID("_PermsColor");

		private static readonly int ContainmentStepId = Shader.PropertyToID("_ContainmentStep");

		private static readonly int ArmoryStepId = Shader.PropertyToID("_ArmoryStep");

		private static readonly int AdminStepId = Shader.PropertyToID("_AdminStep");

		private static readonly int PermsTilingId = Shader.PropertyToID("_PermsMapTilling");

		private static readonly int PermsOffsetId = Shader.PropertyToID("_PermsMapOffset");

		private static readonly int PermsRotationId = Shader.PropertyToID("_PermsRotation");

		private static readonly int BaseColorMapId = Shader.PropertyToID("_BaseColorMap");

		private static readonly int MaskMapId = Shader.PropertyToID("_MaskMap");

		private const int CompositeSize = 1024;

		private static Shader _compositeShader;

		private static bool _compositeShaderSearched;

		private readonly Material _template;

		private readonly Material _composite;

		private CompositeKey _currentKey;

		private CompositeEntry _currentEntry;

		public readonly Material Instance;

		// The KeycardTint shader graph did not survive the decompile, so the card materials render with HDRP/Lit.
		// Tint and permission dots are baked into a base color texture instead (see Hidden/KeycardComposite).
		public bool UsesComposite => _composite != null;

		public KeycardMaterialHandler(Renderer rend)
		{
			_template = rend.sharedMaterial;
			if (!Pool.TryGetValue(_template, out var value) || !value.TryPop(out Instance))
			{
				Instance = new Material(_template);
			}
			rend.sharedMaterial = Instance;
			_composite = GetCompositeMaterial(_template);
			if (_composite != null)
			{
				// HDRP reads the keycard mask as its metallic/AO/smoothness map, which darkens the tinted areas.
				Instance.SetTexture(MaskMapId, null);
				Instance.DisableKeyword("_MASKMAP");
				_currentKey = new CompositeKey(_template, Color.white, Color.black, Vector3.one);
				Rebuild();
			}
		}

		public void SetTint(Color tint)
		{
			if (UsesComposite)
			{
				_currentKey = new CompositeKey(_template, tint, _currentKey.PermsColor, _currentKey.Steps);
				Rebuild();
			}
		}

		public void SetPermissions(float containmentStep, float armoryStep, float adminStep, Color color)
		{
			if (UsesComposite)
			{
				_currentKey = new CompositeKey(_template, _currentKey.Tint, color, new Vector3(containmentStep, armoryStep, adminStep));
				Rebuild();
			}
		}

		public void Cleanup()
		{
			ReleaseComposite();
			Instance.CopyPropertiesFromMaterial(_template);
			Pool.GetOrAddNew(_template).Push(Instance);
		}

		private void Rebuild()
		{
			if (Composites.TryGetValue(_currentKey, out var entry))
			{
				if (entry == _currentEntry)
				{
					return;
				}
			}
			else
			{
				entry = new CompositeEntry
				{
					Texture = Render(_currentKey)
				};
				Composites.Add(_currentKey, entry);
			}
			entry.Users++;
			ReleaseComposite();
			_currentEntry = entry;
			Instance.SetTexture(BaseColorMapId, entry.Texture);
		}

		private void ReleaseComposite()
		{
			CompositeEntry currentEntry = _currentEntry;
			if (currentEntry == null)
			{
				return;
			}
			_currentEntry = null;
			currentEntry.Users--;
			if (currentEntry.Users > 0)
			{
				return;
			}
			foreach (KeyValuePair<CompositeKey, CompositeEntry> composite in Composites)
			{
				if (composite.Value == currentEntry)
				{
					Composites.Remove(composite.Key);
					break;
				}
			}
			currentEntry.Texture.Release();
			Object.Destroy(currentEntry.Texture);
		}

		private RenderTexture Render(CompositeKey key)
		{
			RenderTexture renderTexture = new RenderTexture(CompositeSize, CompositeSize, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.sRGB)
			{
				name = "Keycard Composite",
				useMipMap = true,
				autoGenerateMips = true,
				wrapMode = TextureWrapMode.Repeat,
				filterMode = FilterMode.Trilinear,
				anisoLevel = 4
			};
			renderTexture.Create();
			_composite.SetColor(TintId, key.Tint);
			_composite.SetColor(PermsColorId, key.PermsColor);
			_composite.SetFloat(ContainmentStepId, key.Steps.x);
			_composite.SetFloat(ArmoryStepId, key.Steps.y);
			_composite.SetFloat(AdminStepId, key.Steps.z);
			Graphics.Blit(_composite.GetTexture(MainTexId), renderTexture, _composite);
			return renderTexture;
		}

		private static Material GetCompositeMaterial(Material template)
		{
			if (template == null)
			{
				return null;
			}
			if (CompositeMaterials.TryGetValue(template, out var value))
			{
				return value;
			}
			if (!_compositeShaderSearched)
			{
				_compositeShaderSearched = true;
				_compositeShader = Shader.Find("Hidden/KeycardComposite");
				if (_compositeShader == null)
				{
					Debug.LogError("Keycard composite shader 'Hidden/KeycardComposite' was not found; keycards will not show tints or permissions.");
				}
			}
			if (_compositeShader == null || !KeycardCompositeSettings.TryGet(template, out var entry) || entry.Albedo == null || entry.Mask == null || entry.PermsMask == null)
			{
				CompositeMaterials.Add(template, null);
				return null;
			}
			Material material = new Material(_compositeShader)
			{
				name = template.name + " (Composite)"
			};
			material.SetTexture(MainTexId, entry.Albedo);
			material.SetTexture(MaskId, entry.Mask);
			material.SetTexture(PermsMaskId, entry.PermsMask);
			material.SetVector(PermsTilingId, entry.PermsTiling);
			material.SetVector(PermsOffsetId, entry.PermsOffset);
			material.SetFloat(PermsRotationId, entry.PermsRotation);
			CompositeMaterials.Add(template, material);
			return material;
		}
	}
}

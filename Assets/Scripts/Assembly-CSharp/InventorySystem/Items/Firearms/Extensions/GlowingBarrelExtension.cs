using System;
using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class GlowingBarrelExtension : OverheatExtensionBase
	{
		[Serializable]
		private struct AffectedMaterial
		{
			public Renderer[] Renderers;
		}

		private static readonly Dictionary<Material, Queue<Material>> MaterialPool = new Dictionary<Material, Queue<Material>>();

		private static readonly int TemperatureHash = Shader.PropertyToID("_Temperature");

		[SerializeField]
		private AffectedMaterial[] _materialsToCopy;

		private Material[] _materialTemplates;

		private Material[] _materialInstances;

		private int _materialCount;

		protected override void OnTemperatureChanged(float temp)
		{
			for (int i = 0; i < _materialCount; i++)
			{
				_materialInstances[i].SetFloat(TemperatureHash, temp);
			}
		}

		public override void OnDestroyExtension()
		{
			base.OnDestroyExtension();
			for (int i = 0; i < _materialCount; i++)
			{
				Material key = _materialTemplates[i];
				Material item = _materialInstances[i];
				MaterialPool.GetOrAddNew(key).Enqueue(item);
			}
		}

		private void Start()
		{
			_materialCount = _materialsToCopy.Length;
			_materialTemplates = new Material[_materialCount];
			_materialInstances = new Material[_materialCount];
			for (int i = 0; i < _materialCount; i++)
			{
				AffectedMaterial affectedMaterial = _materialsToCopy[i];
				Material sharedMaterial = affectedMaterial.Renderers[0].sharedMaterial;
				Material material = ((!MaterialPool.TryGetValue(sharedMaterial, out var value) || !value.TryDequeue(out var result)) ? new Material(sharedMaterial) : result);
				_materialTemplates[i] = sharedMaterial;
				_materialInstances[i] = material;
				for (int j = 0; j < affectedMaterial.Renderers.Length; j++)
				{
					affectedMaterial.Renderers[j].sharedMaterial = material;
				}
			}
		}
	}
}

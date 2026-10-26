using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class KeycardMaterialHandler
	{
		private static readonly Dictionary<Material, Stack<Material>> Pool = new Dictionary<Material, Stack<Material>>();

		private readonly Material _template;

		public readonly Material Instance;

		public KeycardMaterialHandler(Renderer rend)
		{
			_template = rend.sharedMaterial;
			if (!Pool.TryGetValue(_template, out var value) || !value.TryPop(out Instance))
			{
				Instance = new Material(_template);
			}
			rend.sharedMaterial = Instance;
		}

		public void Cleanup()
		{
			Instance.CopyPropertiesFromMaterial(_template);
			Pool.GetOrAddNew(_template).Push(Instance);
		}
	}
}

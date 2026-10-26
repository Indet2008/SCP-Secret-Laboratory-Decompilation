using System;
using UnityEngine;

namespace MapGeneration.Holidays
{
	public class HolidayMaterialReplacer : MonoBehaviour
	{
		[Serializable]
		private struct MaterialReplacement : IHolidayFetchableData<Material>
		{
			[field: SerializeField]
			public HolidayType Holiday { get; private set; }

			[field: SerializeField]
			public Material Result { get; private set; }
		}

		[SerializeField]
		private Renderer _renderer;

		[SerializeField]
		private MaterialReplacement[] _materials;

		protected virtual void SetMaterial(Material material)
		{
			_renderer.material = material;
		}

		private void Start()
		{
			if (_materials.TryGetResult<MaterialReplacement, Material>(out var result))
			{
				SetMaterial(result);
			}
		}
	}
}

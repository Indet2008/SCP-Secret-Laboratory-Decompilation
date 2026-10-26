using System;
using UnityEngine;

namespace MapGeneration.Holidays
{
	public abstract class VariantsModuleBase<T> : MonoBehaviour
	{
		[Serializable]
		private struct Variant : IHolidayFetchableData<T>
		{
			[field: SerializeField]
			public HolidayType Holiday { get; private set; }

			[field: SerializeField]
			public T Result { get; private set; }
		}

		[SerializeField]
		private Variant[] _variants;

		public bool TryGetVariant(out T variant)
		{
			return _variants.TryGetResult<Variant, T>(out variant);
		}
	}
}

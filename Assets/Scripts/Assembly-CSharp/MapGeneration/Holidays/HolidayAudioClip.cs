using System;
using UnityEngine;

namespace MapGeneration.Holidays
{
	[CreateAssetMenu(fileName = "MyHolidayAudioClip", menuName = "Northwood/SFX/Holiday Audio Clip")]
	public class HolidayAudioClip : ScriptableObject
	{
		[Serializable]
		private struct ClipReplacement : IHolidayFetchableData<AudioClip>
		{
			[field: SerializeField]
			public HolidayType Holiday { get; private set; }

			[field: SerializeField]
			public AudioClip Result { get; private set; }
		}

		[field: SerializeField]
		public AudioClip DefaultClip { get; private set; }

		[field: SerializeField]
		private ClipReplacement[] Variants { get; set; }

		public AudioClip GetClip()
		{
			if (Variants.TryGetResult<ClipReplacement, AudioClip>(out var result))
			{
				return result;
			}
			return DefaultClip;
		}
	}
}

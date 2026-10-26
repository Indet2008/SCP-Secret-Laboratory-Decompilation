using System;
using UnityEngine.Audio;

namespace AudioPooling
{
	[Serializable]
	public struct ChannelPreset
	{
		public MixerChannel Type;

		public AudioMixerGroup Group;
	}
}

using System.Collections.Generic;
using AudioPooling;

namespace FacilitySoundtrack.ChaseThemes
{
	public interface IChaseThemeProvider
	{
		List<DesiredChaseClip> ClipsToPlay { get; }

		float DominanceScale { get; }

		int Priority { get; }

		bool TryStartChase();

		AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers);

		void OnChaseStopped();

		bool UpdateChase();
	}
}

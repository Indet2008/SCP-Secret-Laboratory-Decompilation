namespace Cassie
{
	public class CassieAnnouncement
	{
		private readonly float _glitchScale;

		public CassieTtsPayload Payload;

		public float Priority;

		public virtual bool ReadyToPlay => true;

		public virtual float GlitchScale => _glitchScale * (float)((!AlphaWarheadController.Detonated) ? 1 : 2);

		public virtual float PostAnnouncementCooldown
		{
			get
			{
				if (!Payload.PlayBackground)
				{
					return 1f;
				}
				return 3.1f;
			}
		}

		public CassieAnnouncement(CassieTtsPayload payload, float priority = 0f, float glitchScale = 1f)
		{
			Payload = payload;
			Priority = priority;
			_glitchScale = glitchScale;
		}

		public virtual void OnStartedPlaying()
		{
			string text = CassieGlitchifier.Glitchify(Payload.Content, GlitchScale);
			Payload = new CassieTtsPayload(Payload, text.ToUpperInvariant());
		}

		public virtual void UpdateQueued()
		{
		}

		public virtual void UpdatePlayed()
		{
		}

		public virtual void OnFinishedPlaying()
		{
		}

		public virtual void OnCancelled()
		{
		}
	}
}

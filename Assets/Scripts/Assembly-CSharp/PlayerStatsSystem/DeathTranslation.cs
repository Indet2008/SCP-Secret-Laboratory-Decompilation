namespace PlayerStatsSystem
{
	public struct DeathTranslation
	{
		private readonly int _ragdollTranId;

		private readonly int _deathTranId;

		public readonly byte Id;

		public readonly string LogLabel;

		public readonly string RagdollTranslation => TranslationReader.Get("DeathReasons", _ragdollTranId, LogLabel);

		public readonly string DeathscreenTranslation => TranslationReader.Get("DeathReasons", _deathTranId, LogLabel);

		public DeathTranslation(byte id, int ragdoll, int deathscreen, string backup)
		{
			Id = id;
			_ragdollTranId = ragdoll - 1;
			_deathTranId = deathscreen - 1;
			LogLabel = backup;
			DeathTranslations.TranslationsById[id] = this;
		}
	}
}

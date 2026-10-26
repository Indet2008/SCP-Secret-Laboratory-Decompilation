using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127BadAimVoiceTrigger : Scp127VoiceTriggerBase
	{
		[SerializeField]
		private Scp127VoiceLineCollection _voiceLine;

		private int _missedAmmo;

		private Scp127MagazineModule _magazineModule;

		private Scp127ActionModule _actionModule;

		private const float MissThreshold = 0.8f;

		protected override void OnInit()
		{
			base.OnInit();
			base.Firearm.TryGetModules<Scp127MagazineModule, Scp127ActionModule, IHitregModule>(out _magazineModule, out _actionModule, out var m);
			m.ServerOnFired += OnFired;
		}

		public override bool ContainsAudioClip(AudioClip clip)
		{
			return _voiceLine.Contains(clip);
		}

		private void OnDamaged(Firearm scp127)
		{
			if (!(scp127 != base.Firearm))
			{
				_missedAmmo = 0;
			}
		}

		private void OnFired()
		{
			_missedAmmo++;
			if (_actionModule.AmmoStored <= 0)
			{
				float num = 0.8f * (float)_magazineModule.AmmoMax;
				if (!((float)_missedAmmo < num))
				{
					_missedAmmo = 0;
					ServerPlayVoiceLineFromCollection(_voiceLine);
				}
			}
		}

		protected override void RegisterEvents()
		{
			base.RegisterEvents();
			Scp127TierManagerModule.ServerOnDamaged += OnDamaged;
		}

		protected override void UnregisterEvents()
		{
			base.UnregisterEvents();
			Scp127TierManagerModule.ServerOnDamaged -= OnDamaged;
		}
	}
}

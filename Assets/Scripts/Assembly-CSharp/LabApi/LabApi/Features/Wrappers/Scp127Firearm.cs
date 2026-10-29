namespace LabApi.Features.Wrappers
{
	public class Scp127Firearm : global::LabApi.Features.Wrappers.FirearmItem
	{
		private global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127TierManagerModule _tierModule;

		private global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceLineManagerModule _voiceModule;

		public override bool OpenBolt => false;

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> Friends
		{
			get
			{
				if (!global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceLineManagerModule.FriendshipMemory.TryGetValue(base.Serial, out var value))
				{
					yield break;
				}
				foreach (uint item in value)
				{
					yield return global::LabApi.Features.Wrappers.Player.Get(item);
				}
			}
		}

		public global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127Tier Tier
		{
			get
			{
				if (_tierModule == null)
				{
					return global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127Tier.Tier1;
				}
				return _tierModule.CurTier;
			}
			set
			{
				if (_tierModule == null)
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set Tier, Scp127TierManagerModule is null");
				}
				else
				{
					_tierModule.CurTier = value;
				}
			}
		}

		public float Experience
		{
			get
			{
				if (_tierModule == null)
				{
					return 0f;
				}
				return _tierModule.ServerExp;
			}
			set
			{
				if (_tierModule == null)
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set Experience, Scp127TierManagerModule is null");
				}
				else
				{
					_tierModule.ServerExp = value;
				}
			}
		}

		public override int ChamberedAmmo
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127ActionModule scp127ActionModule)
				{
					return scp127ActionModule.AmmoStored;
				}
				return 0;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127ActionModule scp127ActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set ChamberedAmmo as the action module is null.");
					return;
				}
				scp127ActionModule.ChamberSize = value;
				scp127ActionModule.ServerResync();
			}
		}

		public override int ChamberMax
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127ActionModule scp127ActionModule)
				{
					return scp127ActionModule.ChamberSize;
				}
				return 0;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127ActionModule scp127ActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set ChamberMax as the action module is null.");
				}
				else
				{
					scp127ActionModule.ChamberSize = value;
				}
			}
		}

		public override bool MagazineInserted
		{
			get
			{
				return true;
			}
			set
			{
				if (base.MagazineControllerModule is global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127MagazineModule)
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set MagazineInserted as SCP-127's magazine is not detachable.");
				}
			}
		}

		public override int StoredAmmo
		{
			get
			{
				return base.StoredAmmo;
			}
			set
			{
				base.StoredAmmo = value;
			}
		}

		internal Scp127Firearm(global::InventorySystem.Items.Firearms.Firearm firearm)
			: base(firearm)
		{
		}

		public void PlayVoiceline(global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceLinesTranslation voiceline, global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceTriggerBase.VoiceLinePriority priority = global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceTriggerBase.VoiceLinePriority.Normal)
		{
			global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceTriggerBase trigger;
			global::UnityEngine.AudioClip clip;
			if (_voiceModule == null)
			{
				global::LabApi.Features.Console.Logger.Error("Unable to play voiceline, Scp127VoiceLineManagerModule is null");
			}
			else if (!_voiceModule.TryFindVoiceLine(voiceline, out trigger, out clip))
			{
				global::LabApi.Features.Console.Logger.Error($"Unable to play voiceline {voiceline} as it wasn't found");
			}
			else
			{
				_voiceModule.ServerSendVoiceLine(trigger, null, clip, (byte)priority);
			}
		}

		protected override void CacheModules()
		{
			base.CacheModules();
			global::InventorySystem.Items.Firearms.Modules.ModuleBase[] modules = base.Modules;
			foreach (global::InventorySystem.Items.Firearms.Modules.ModuleBase moduleBase in modules)
			{
				if (moduleBase is global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127TierManagerModule tierModule)
				{
					_tierModule = tierModule;
				}
				else if (moduleBase is global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceLineManagerModule voiceModule)
				{
					_voiceModule = voiceModule;
				}
			}
		}
	}
}

using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class AudioManagerModule : MicroHidModuleBase
	{
		private static readonly Dictionary<ushort, AudioController> Instances = new Dictionary<ushort, AudioController>();

		private static AudioController _globalAudioControllerTemplate;

		private static readonly Action<CycleController> UpdateInstanceCached = UpdateInstance;

		[SerializeField]
		private AudioController _audioControllerPrefab;

		public static AudioController GetController(ushort serial)
		{
			if (!Instances.TryGetValue(serial, out var value))
			{
				value = UnityEngine.Object.Instantiate(_globalAudioControllerTemplate);
				value.Serial = serial;
				Instances[serial] = value;
			}
			return value;
		}

		public static void RegisterDestroyed(AudioController destroyed)
		{
			Instances.Remove(destroyed.Serial);
		}

		private static void UpdateInstance(CycleController cycleController)
		{
			MicroHidPhase phase = cycleController.Phase;
			AudioController value;
			if (phase != MicroHidPhase.Standby)
			{
				GetController(cycleController.Serial).UpdateAudio(phase);
			}
			else if (Instances.TryGetValue(cycleController.Serial, out value))
			{
				value.UpdateAudio(phase);
			}
		}

		internal override void TemplateUpdate()
		{
			base.TemplateUpdate();
			CycleSyncModule.ForEachController(UpdateInstanceCached);
		}

		internal override void OnTemplateReloaded(ModularAutosyncItem template, bool wasEverLoaded)
		{
			base.OnTemplateReloaded(template, wasEverLoaded);
			_globalAudioControllerTemplate = _audioControllerPrefab;
		}
	}
}

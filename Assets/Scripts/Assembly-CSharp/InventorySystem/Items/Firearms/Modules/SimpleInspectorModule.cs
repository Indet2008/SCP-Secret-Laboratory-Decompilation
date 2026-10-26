using System.Collections.Generic;
using AudioPooling;
using InventorySystem.Items.Firearms.Modules.Misc;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class SimpleInspectorModule : ModuleBase, ITriggerPressPreventerModule, ISwayModifierModule, IInspectorModule
	{
		private static readonly HashSet<ushort> SpectatorInspectingFirearms = new HashSet<ushort>();

		private const float MinimalIdleTime = 0.15f;

		private const float MaxTransitionTime = 0.365f;

		private const float SwayAdjustSpeed = 5f;

		private const float ClipStoppingSpeed = 10f;

		private float _idleElapsed;

		private bool _isInspecting;

		private bool _eventListenerSet;

		private readonly List<AudioPoolSession> _capturedClips = new List<AudioPoolSession>();

		[Tooltip("Layer that contains the inspect animation. It must contain an idle state with 'Idle' tag, to which the animation returns when ends.")]
		[SerializeField]
		private AnimatorLayerMask _inspectLayer;

		[Tooltip("Scale of hip-fire bobbing when inspecting.")]
		[SerializeField]
		private float _bobbingScale = 1f;

		[Tooltip("Scale of runnin sway when inspecting")]
		[SerializeField]
		private float _walkSwayScale = 1f;

		[Tooltip("Scale of runnin sway when inspecting")]
		[SerializeField]
		private float _jumpSwayScale = 1f;

		[Tooltip("List of clips produced by audio manager that will be automatically stopped when the inspection is interrupted.")]
		[SerializeField]
		private AudioClip[] _clipsToStopOnInterrupt;

		private bool ValidateStart
		{
			get
			{
				ModuleBase[] modules = base.Firearm.Modules;
				foreach (ModuleBase moduleBase in modules)
				{
					if (moduleBase is IInspectPreventerModule inspectPreventerModule)
					{
						if (!inspectPreventerModule.InspectionAllowed)
						{
							return false;
						}
					}
					else if (moduleBase is IBusyIndicatorModule { IsBusy: not false })
					{
						return false;
					}
				}
				return true;
			}
		}

		private bool ValidateUpdate
		{
			get
			{
				if (!ValidateStart)
				{
					return false;
				}
				if (_idleElapsed < 0.365f)
				{
					return true;
				}
				int[] layers = _inspectLayer.Layers;
				foreach (int layer in layers)
				{
					if (base.Firearm.AnimGetCurStateInfo(layer).tagHash == FirearmAnimatorHashes.Idle)
					{
						return false;
					}
				}
				return true;
			}
		}

		public bool ClientBlockTrigger { get; private set; }

		public float WalkSwayScale { get; private set; }

		public float JumpSwayScale { get; private set; }

		public float BobbingSwayScale { get; private set; }

		public bool DisplayInspecting => _isInspecting;

		private void SetInspecting(bool val)
		{
			bool isInspecting = _isInspecting;
			_isInspecting = val;
			_idleElapsed = 0f;
			if (_isInspecting)
			{
				if (!isInspecting)
				{
					_capturedClips.Clear();
					base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.StartInspect, checkIfExists: true);
				}
			}
			else
			{
				ReleaseTriggerLock();
			}
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.Inspect, val);
			if (NetworkServer.active)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteBool(val);
				});
			}
		}

		private void UpdateSwayScale()
		{
			float b;
			float b2;
			float b3;
			if (_isInspecting)
			{
				b = _walkSwayScale;
				b2 = _jumpSwayScale;
				b3 = _bobbingScale;
			}
			else
			{
				b = 1f;
				b2 = 1f;
				b3 = 1f;
			}
			float t = 5f * Time.deltaTime;
			WalkSwayScale = Mathf.Lerp(WalkSwayScale, b, t);
			JumpSwayScale = Mathf.Lerp(JumpSwayScale, b2, t);
			BobbingSwayScale = Mathf.Lerp(BobbingSwayScale, b3, t);
		}

		private void InterceptNewSound(ItemIdentifier id, PlayerRoleBase role, PooledAudioSource src)
		{
			if (_isInspecting && base.Firearm.ItemSerial == id.SerialNumber && base.Firearm.ItemTypeId == id.TypeId && _clipsToStopOnInterrupt.Contains(src.Source.clip))
			{
				_capturedClips.Add(new AudioPoolSession(src));
			}
		}

		private void StopInspectSounds()
		{
			bool flag = false;
			foreach (AudioPoolSession capturedClip in _capturedClips)
			{
				if (capturedClip.SameSession && !(capturedClip.Source.volume <= 0f))
				{
					flag = true;
					capturedClip.Source.volume -= Time.deltaTime * 10f;
				}
			}
			if (!flag)
			{
				_capturedClips.Clear();
			}
		}

		private void OnDestroy()
		{
			if (_eventListenerSet)
			{
				_eventListenerSet = false;
				AudioModule.OnSoundPlayed -= InterceptNewSound;
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			UpdateSwayScale();
			if (_isInspecting)
			{
				if (!ValidateUpdate)
				{
					SetInspecting(val: false);
				}
			}
			else if (_capturedClips.Count > 0)
			{
				StopInspectSounds();
			}
			if (ValidateStart)
			{
				_idleElapsed += Time.deltaTime;
			}
			else
			{
				_idleElapsed = 0f;
			}
			if (base.IsControllable && !_isInspecting && !(_idleElapsed < 0.15f) && GetActionDown(ActionName.InspectItem) && !base.ItemUsageBlocked)
			{
				SendCmd();
			}
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			_idleElapsed = 0f;
			ReleaseTriggerLock();
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			SetInspecting(val: false);
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SpectatorInspectingFirearms.Clear();
		}

		internal override void SpectatorInit()
		{
			base.SpectatorInit();
			if (SpectatorInspectingFirearms.Contains(base.Firearm.ItemSerial))
			{
				_isInspecting = true;
				base.Firearm.AnimSetBool(FirearmAnimatorHashes.Inspect, b: true);
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			if (!_eventListenerSet)
			{
				AudioModule.OnSoundPlayed += InterceptNewSound;
				_eventListenerSet = true;
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (ValidateStart)
			{
				PlayerInspectingItemEventArgs e = new PlayerInspectingItemEventArgs(base.Firearm.Owner, base.Firearm);
				PlayerEvents.OnInspectingItem(e);
				if (e.IsAllowed)
				{
					SetInspecting(val: true);
					PlayerEvents.OnInspectedItem(new PlayerInspectedItemEventArgs(base.Firearm.Owner, base.Firearm));
				}
			}
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			bool flag = reader.ReadBool();
			if (_isInspecting != flag)
			{
				SetInspecting(!_isInspecting);
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			if (reader.ReadBool())
			{
				SpectatorInspectingFirearms.Add(serial);
			}
			else
			{
				SpectatorInspectingFirearms.Remove(serial);
			}
		}

		[ExposedFirearmEvent]
		public void BlockTrigger()
		{
			if (base.IsLocalPlayer && (!base.Firearm.TryGetModule<IActionModule>(out var module) || !module.IsLoaded))
			{
				ClientBlockTrigger = true;
			}
		}

		[ExposedFirearmEvent]
		public void ReleaseTriggerLock()
		{
			ClientBlockTrigger = false;
		}
	}
}

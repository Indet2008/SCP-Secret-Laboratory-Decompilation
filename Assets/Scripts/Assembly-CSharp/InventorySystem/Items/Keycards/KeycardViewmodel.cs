using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class KeycardViewmodel : StandardAnimatedViemodel
	{
		private static readonly List<Renderer> GetCompNonAlloc = new List<Renderer>();

		private static readonly int UseHash = Animator.StringToHash("Use");

		private static readonly int IdleHash = Animator.StringToHash("Idle");

		private static readonly int StartInspectHash = Animator.StringToHash("InspectStart");

		private static readonly int AllowInspectHash = Animator.StringToHash("InspectValid");

		private bool _wasInspecting;

		[SerializeField]
		private Transform _keycardGfxSpawn;

		[SerializeField]
		private KeycardGfx _spawnedGfx;

		[SerializeField]
		private AudioSource _equipSoundSource;

		[SerializeField]
		private AudioSource _inspectSource;

		public bool IsIdle
		{
			get
			{
				if (AnimatorStateInfo(0).tagHash == IdleHash)
				{
					return !AnimatorInTransition(0);
				}
				return false;
			}
		}

		public override void InitAny()
		{
			base.InitAny();
			KeycardItem.OnKeycardUsed += OnAnyKeycardUsed;
			if (!base.ItemId.TryGetTemplate<KeycardItem>(out var item))
			{
				return;
			}
			if (_spawnedGfx != null)
			{
				KeycardDetailSynchronizer.RegisterReceiver(_spawnedGfx);
				return;
			}
			_spawnedGfx = Object.Instantiate(item.KeycardGfx, _keycardGfxSpawn);
			_spawnedGfx.transform.ResetTransform();
			GetCompNonAlloc.Clear();
			_spawnedGfx.GetComponentsInChildren(includeInactive: true, GetCompNonAlloc);
			int layer = base.gameObject.layer;
			foreach (Renderer item2 in GetCompNonAlloc)
			{
				item2.gameObject.layer = layer;
			}
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			if (wasEquipped)
			{
				_equipSoundSource.Stop();
			}
			AnimatorForceUpdate(base.SkipEquipTime);
			UpdateInspecting(skipAnimator: true);
		}

		private void Update()
		{
			UpdateInspecting(skipAnimator: false);
		}

		private void UpdateInspecting(bool skipAnimator)
		{
			bool flag = KeycardItem.StartInspectTimes.TryGetValue(base.ItemId.SerialNumber, out var value);
			if (_wasInspecting == flag)
			{
				return;
			}
			_wasInspecting = flag;
			AnimatorSetBool(AllowInspectHash, flag);
			if (!flag)
			{
				_inspectSource.Stop();
				return;
			}
			AnimatorSetTrigger(StartInspectHash);
			float num = (float)(NetworkTime.time - value);
			bool flag2 = num < _inspectSource.clip.length;
			if (flag2)
			{
				_inspectSource.Play();
			}
			if (skipAnimator)
			{
				if (flag2)
				{
					_inspectSource.time = num;
				}
				AnimatorForceUpdate(num, fastMode: false);
			}
		}

		protected virtual void PlayUseAnimation(bool success)
		{
			AnimatorSetTrigger(UseHash);
		}

		protected virtual void OnDestroy()
		{
			KeycardItem.OnKeycardUsed -= OnAnyKeycardUsed;
		}

		private void OnAnyKeycardUsed(ushort serial, bool success)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				PlayUseAnimation(success);
			}
		}
	}
}

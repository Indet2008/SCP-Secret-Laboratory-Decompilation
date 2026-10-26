using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class EventManagerModule : ModuleBase
	{
		private class AnimatorEventProcessor
		{
			private readonly int[] _layers;

			private readonly Animator _animator;

			private readonly LayerEventProcessor[] _currentLayers;

			private readonly LayerEventProcessor[] _nextLayers;

			private readonly Dictionary<int, float>[] _continuationTimes;

			private readonly EventManagerModule _eventManager;

			public AnimatorEventProcessor(EventManagerModule eventManager, Animator animator)
			{
				_animator = animator;
				_eventManager = eventManager;
				_layers = eventManager.AffectedLayers.Layers;
				int num = _layers.Length;
				_currentLayers = new LayerEventProcessor[num];
				_nextLayers = new LayerEventProcessor[num];
				_continuationTimes = new Dictionary<int, float>[num];
				for (int i = 0; i < num; i++)
				{
					int layerIndex = _layers[i];
					_currentLayers[i] = new LayerEventProcessor(_eventManager, isCurrent: true, layerIndex, animator);
					_nextLayers[i] = new LayerEventProcessor(_eventManager, isCurrent: false, layerIndex, animator);
					_continuationTimes[i] = new Dictionary<int, float>();
				}
			}

			public void ProcessAll()
			{
				for (int i = 0; i < _layers.Length; i++)
				{
					int layerIndex = _layers[i];
					Dictionary<int, float> continuationTimes = _continuationTimes[i];
					_currentLayers[i].Process(_animator.GetCurrentAnimatorStateInfo(layerIndex), continuationTimes);
					_nextLayers[i].Process(_animator.GetNextAnimatorStateInfo(layerIndex), continuationTimes);
				}
			}
		}

		private class LayerEventProcessor
		{
			private readonly EventManagerModule _eventManager;

			private readonly bool _isCurrent;

			private readonly Animator _anim;

			private readonly int _layerIndex;

			private List<int> _prevEvents;

			private int _curHash;

			private float _lastFrame;

			private bool _hasEvents;

			public LayerEventProcessor(EventManagerModule eventManager, bool isCurrent, int layerIndex, Animator anim)
			{
				_eventManager = eventManager;
				_isCurrent = isCurrent;
				_layerIndex = layerIndex;
				_anim = anim;
			}

			public void Process(AnimatorStateInfo stateInfo, Dictionary<int, float> continuationTimes)
			{
				if (_curHash != stateInfo.shortNameHash)
				{
					_curHash = stateInfo.shortNameHash;
					_lastFrame = (_isCurrent ? continuationTimes.GetValueOrDefault(_curHash) : 0f);
					_hasEvents = _eventManager._nameHashesToIndexes.TryGetValue(_curHash, out _prevEvents);
					continuationTimes[_curHash] = 0f;
				}
				if (!_hasEvents || _curHash == 0)
				{
					return;
				}
				float lastFrame = _lastFrame;
				foreach (int prevEvent in _prevEvents)
				{
					FirearmEvent firearmEvent = _eventManager.Events[prevEvent];
					float num = stateInfo.normalizedTime;
					if (stateInfo.loop)
					{
						num -= (float)(int)num;
					}
					_lastFrame = num * firearmEvent.LengthFrames;
					if (lastFrame < firearmEvent.Frame && _lastFrame >= firearmEvent.Frame)
					{
						EventInvocationDetails data = new EventInvocationDetails(stateInfo, _anim, _layerIndex);
						firearmEvent.InvokeSafe(data);
					}
					if (!_isCurrent)
					{
						continuationTimes[_curHash] = _lastFrame;
					}
				}
			}
		}

		private static readonly Dictionary<ItemType, Dictionary<int, List<int>>> FirearmsToNameHashesToIndexes = new Dictionary<ItemType, Dictionary<int, List<int>>>();

		public List<FirearmEvent> Events = new List<FirearmEvent>();

		public AnimatorLayerMask AffectedLayers;

		private Dictionary<int, List<int>> _nameHashesToIndexes;

		private AnimatorEventProcessor _processor;

		public bool SkippingForward { get; private set; }

		public event Action<int> OnEventRelayed;

		public void AddEventsForClip(int hash, List<FirearmEvent> list)
		{
			if (!_nameHashesToIndexes.TryGetValue(hash, out var value))
			{
				return;
			}
			foreach (int item in value)
			{
				list.Add(Events[item]);
			}
		}

		[ExposedFirearmEvent]
		public void RelayEvent(int guid)
		{
			OnEventRelayed?.Invoke(guid);
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			CacheIndexes();
			if (base.IsLocalPlayer)
			{
				_processor = new AnimatorEventProcessor(this, SharedHandsController.Singleton.Hands);
			}
			else if (base.IsServer)
			{
				_processor = new AnimatorEventProcessor(this, base.Firearm.ServerSideAnimator);
			}
		}

		internal override void SpectatorInit()
		{
			base.SpectatorInit();
			SkippingForward = true;
			_processor = new AnimatorEventProcessor(this, SharedHandsController.Singleton.Hands);
			CacheIndexes();
		}

		private void CacheIndexes()
		{
			if (FirearmsToNameHashesToIndexes.TryGetValue(base.Firearm.ItemTypeId, out _nameHashesToIndexes))
			{
				return;
			}
			_nameHashesToIndexes = new Dictionary<int, List<int>>();
			FirearmsToNameHashesToIndexes[base.Firearm.ItemTypeId] = _nameHashesToIndexes;
			for (int i = 0; i < Events.Count; i++)
			{
				_nameHashesToIndexes.GetOrAdd(Events[i].NameHash, () => new List<int>()).Add(i);
			}
		}

		private void LateUpdate()
		{
			if (base.Firearm.IsEquipped)
			{
				_processor?.ProcessAll();
				SkippingForward = false;
			}
		}

		[ContextMenu("Clear event cache")]
		private void ClearCache()
		{
			FirearmsToNameHashesToIndexes.Clear();
			CacheIndexes();
		}
	}
}

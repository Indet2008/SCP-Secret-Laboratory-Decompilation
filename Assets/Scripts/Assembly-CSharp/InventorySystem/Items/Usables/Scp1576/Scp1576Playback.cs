using System;
using System.Collections.Generic;
using GameObjectPools;
using PlayerRoles;
using UnityEngine;
using Utils.NonAllocLINQ;
using VoiceChat;
using VoiceChat.Playbacks;

namespace InventorySystem.Items.Usables.Scp1576
{
	public class Scp1576Playback : SingleBufferPlayback, IGlobalPlayback, IPoolResettable, IPoolSpawnable
	{
		private static readonly Queue<Scp1576Playback> Pool = new Queue<Scp1576Playback>();

		private static readonly Dictionary<Scp1576Source, Dictionary<ReferenceHub, Scp1576Playback>> ActiveInstances = new Dictionary<Scp1576Source, Dictionary<ReferenceHub, Scp1576Playback>>();

		private static bool _anyCreated;

		private static bool _templateCacheSet;

		private static Scp1576Playback _templateCache;

		[SerializeField]
		private bool _playerMode;

		private Transform _tr;

		private Scp1576Source _source;

		private bool _spawned;

		public static Scp1576Playback Template
		{
			get
			{
				if (_templateCacheSet)
				{
					return _templateCache;
				}
				if (!InventoryItemLoader.TryGetItem<Scp1576Item>(ItemType.SCP1576, out var result))
				{
					throw new InvalidOperationException("SCP-1576 template not found!");
				}
				_templateCache = result.PlaybackTemplate;
				_templateCacheSet = true;
				return _templateCache;
			}
		}

		public ReferenceHub Owner { get; set; }

		public virtual bool GlobalChatActive
		{
			get
			{
				if (!_spawned || !_source.HideGlobalIndicator)
				{
					return MaxSamples > 0;
				}
				return false;
			}
		}

		public virtual Color GlobalChatColor => Owner.serverRoles.GetVoiceColor();

		public virtual string GlobalChatName => Owner.nicknameSync.DisplayName;

		public virtual float GlobalChatLoudness => base.Loudness;

		public GlobalChatIconType GlobalChatIcon => GlobalChatIconType.Avatar;

		public void SpawnObject()
		{
			if (_playerMode && base.transform.parent.TryGetComponent<HumanRole>(out var component) && component.TryGetOwner(out var hub))
			{
				Owner = hub;
				GlobalChatIndicatorManager.Subscribe(this, Owner);
			}
		}

		public void ResetObject()
		{
			if (_playerMode)
			{
				GlobalChatIndicatorManager.Unsubscribe(this);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_tr = base.transform;
		}

		private void OnDestroy()
		{
			if (_anyCreated)
			{
				Pool.Clear();
				ActiveInstances.Clear();
				_anyCreated = false;
			}
		}

		private void LateUpdate()
		{
			if (_spawned)
			{
				_tr.position = _source.Position;
			}
		}

		public static void DistributeSamples(ReferenceHub speaker, float[] samples, int len)
		{
			foreach (Scp1576Source instance in Scp1576Source.Instances)
			{
				GetOrAdd(speaker, instance).WriteBuffer(samples, len);
			}
		}

		private static Scp1576Playback GetOrAdd(ReferenceHub player, Scp1576Source source)
		{
			if (ActiveInstances.TryGetValue(source, out var value) && value.TryGetValue(player, out var value2))
			{
				return value2;
			}
			if (!Pool.TryDequeue(out value2))
			{
				value2 = UnityEngine.Object.Instantiate(Template);
				_anyCreated = true;
			}
			value2._spawned = true;
			value2.Owner = player;
			value2._source = source;
			ActiveInstances.GetOrAdd(source, () => new Dictionary<ReferenceHub, Scp1576Playback>())[player] = value2;
			GlobalChatIndicatorManager.Subscribe(value2, player);
			return value2;
		}

		private static void ReturnToPool(Scp1576Playback playback)
		{
			if (ActiveInstances.TryGetValue(playback._source, out var value))
			{
				value.Remove(playback.Owner);
			}
			Pool.Enqueue(playback);
			playback._spawned = false;
			GlobalChatIndicatorManager.Unsubscribe(playback);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				ActiveInstances.ForEachValue((Dictionary<ReferenceHub, Scp1576Playback> x) =>
				{
					if (x.TryGetValue(hub, out var value))
					{
						x.Remove(hub);
						ReturnToPool(value);
					}
				});
			};
			Scp1576Source.OnRemoved = (Action<Scp1576Source>)Delegate.Combine(Scp1576Source.OnRemoved, (Action<Scp1576Source>)((Scp1576Source src) =>
			{
				if (ActiveInstances.TryGetValue(src, out var value))
				{
					ActiveInstances.Remove(src);
					value.ForEachValue(ReturnToPool);
				}
			}));
		}
	}
}

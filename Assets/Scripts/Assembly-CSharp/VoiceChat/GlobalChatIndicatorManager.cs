using System.Collections.Generic;
using UnityEngine;
using VoiceChat.Playbacks;

namespace VoiceChat
{
	public class GlobalChatIndicatorManager : MonoBehaviour
	{
		[SerializeField]
		private GlobalChatIndicator _template;

		[SerializeField]
		private RectTransform _root;

		private readonly Queue<GlobalChatIndicator> _pool = new Queue<GlobalChatIndicator>();

		private readonly Dictionary<IGlobalPlayback, GlobalChatIndicator> _instances = new Dictionary<IGlobalPlayback, GlobalChatIndicator>();

		private static GlobalChatIndicatorManager _singleton;

		private static bool _singletonSet;

		private void Awake()
		{
			_singleton = this;
			_singletonSet = true;
		}

		private void OnDestroy()
		{
			_singletonSet = false;
		}

		private void LateUpdate()
		{
			foreach (KeyValuePair<IGlobalPlayback, GlobalChatIndicator> instance in _instances)
			{
				instance.Value.Refresh();
			}
		}

		private void SpawnIndicator(IGlobalPlayback igp, ReferenceHub ply)
		{
			if (!_pool.TryDequeue(out var result))
			{
				result = Object.Instantiate(_template);
			}
			Transform obj = result.transform;
			obj.SetParent(_root);
			obj.localScale = Vector3.one;
			obj.SetAsLastSibling();
			result.Setup(igp, ply);
			_instances[igp] = result;
		}

		private void ReturnIndicator(IGlobalPlayback igp)
		{
			if (_instances.TryGetValue(igp, out var value))
			{
				value.gameObject.SetActive(value: false);
				_pool.Enqueue(value);
				_instances.Remove(igp);
			}
		}

		public static void Subscribe(IGlobalPlayback igp, ReferenceHub player)
		{
			_singleton.SpawnIndicator(igp, player);
		}

		public static void Unsubscribe(IGlobalPlayback igp)
		{
			if (_singletonSet)
			{
				_singleton.ReturnIndicator(igp);
			}
		}
	}
}

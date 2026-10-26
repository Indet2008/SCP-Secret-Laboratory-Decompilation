using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine;

namespace AnimatorLayerManagement
{
	public class AnimatorLayerManager : MonoBehaviour
	{
		public const string LayerFormat = "{0} - (RefId={1})";

		public const string RegexPattern = "^(.+)\\s-\\s\\(RefId=(\\d+)\\)$";

		private static readonly Regex RegexUnpacker = new Regex("^(.+)\\s-\\s\\(RefId=(\\d+)\\)$");

		[SerializeField]
		private bool _rebuildOnAwake;

		[SerializeField]
		private List<RefIdIndexPair> _pairs;

		private readonly Dictionary<int, int> _lookupCache = new Dictionary<int, int>();

		private Animator _animCache;

		private bool _animFound;

		private Animator Anim
		{
			get
			{
				if (_animFound)
				{
					return _animCache;
				}
				_animCache = GetComponent<Animator>();
				_animFound = true;
				return _animCache;
			}
		}

		private void Awake()
		{
			if (_rebuildOnAwake)
			{
				RebuildPairCache();
			}
		}

		public void RebuildPairCache()
		{
			_lookupCache.Clear();
			int layerCount = Anim.layerCount;
			if (_pairs == null)
			{
				_pairs = new List<RefIdIndexPair>(layerCount);
			}
			else
			{
				_pairs.Clear();
				_pairs.EnsureCapacity(layerCount);
			}
			for (int i = 0; i < layerCount; i++)
			{
				if (TryUnpackFormat(Anim.GetLayerName(i), out var _, out var refId))
				{
					_pairs.Add(new RefIdIndexPair(refId, i));
				}
			}
		}

		public int GetLayerIndex(LayerRefId refId)
		{
			if (_lookupCache.TryGetValue(refId.Value, out var value))
			{
				return value;
			}
			for (int i = 0; i < _pairs.Count; i++)
			{
				RefIdIndexPair refIdIndexPair = _pairs[i];
				if (refIdIndexPair.RefId.Value == refId.Value)
				{
					_lookupCache[refId.Value] = refIdIndexPair.LayerIndex;
					return refIdIndexPair.LayerIndex;
				}
			}
			throw new InvalidOperationException(string.Format("{0} with value {1} not detected on the animator controller.", "LayerRefId", refId.Value));
		}

		public float GetLayerWeight(LayerRefId refId)
		{
			return Anim.GetLayerWeight(GetLayerIndex(refId));
		}

		public void SetLayerWeight(LayerRefId refId, float weight)
		{
			Anim.SetLayerWeight(GetLayerIndex(refId), weight);
		}

		public static bool TryUnpackFormat(string layerName, out string originalName, out LayerRefId refId)
		{
			Match match = RegexUnpacker.Match(layerName);
			if (!match.Success)
			{
				originalName = null;
				refId = default;
				return false;
			}
			originalName = match.Groups[1].Value;
			if (int.TryParse(match.Groups[2].Value, out var result))
			{
				refId = new LayerRefId(result);
				return true;
			}
			refId = default;
			return false;
		}

		public static string PackFormat(string originalName, LayerRefId refId)
		{
			return $"{originalName} - (RefId={refId.Value})";
		}
	}
}

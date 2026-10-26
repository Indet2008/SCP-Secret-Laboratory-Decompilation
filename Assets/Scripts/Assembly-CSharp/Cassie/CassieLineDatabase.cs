using System;
using System.Collections.Generic;
using UnityEngine;

namespace Cassie
{
	[CreateAssetMenu(fileName = "New CASSIE Clip Database", menuName = "ScriptableObject/CASSIE Clip Database")]
	public class CassieLineDatabase : ScriptableObject
	{
		private static readonly Dictionary<char, List<CassieLine>> LinesByFirstCharCache = new Dictionary<char, List<CassieLine>>();

		private static bool _cacheSet;

		[field: SerializeField]
		public CassieLine[] AllLines { get; private set; }

		public void ValidateCache(bool forceReload = false)
		{
			if (_cacheSet && !forceReload)
			{
				return;
			}
			foreach (KeyValuePair<char, List<CassieLine>> item in LinesByFirstCharCache)
			{
				item.Value.Clear();
			}
			CassieLine[] allLines = AllLines;
			foreach (CassieLine cassieLine in allLines)
			{
				char key = cassieLine.ApiName[0];
				LinesByFirstCharCache.GetOrAddNew(key).Add(cassieLine);
			}
			_cacheSet = true;
		}

		public bool TryGetLine(ReadOnlySpan<char> word, out CassieLine line)
		{
			ValidateCache();
			if (word.Length == 0 || !LinesByFirstCharCache.TryGetValue(word[0], out var value))
			{
				line = null;
				return false;
			}
			foreach (CassieLine item in value)
			{
				if (word.SequenceEqual(item.ApiName.AsSpan()))
				{
					line = item;
					return true;
				}
			}
			line = null;
			return false;
		}
	}
}

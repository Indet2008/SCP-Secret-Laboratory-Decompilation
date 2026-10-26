using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using TMPro;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchHitRegLog : MonoBehaviour
	{
		private const int QueueLength = 30;

		private const string HitColor = "#fc6203";

		private const string MissColor = "#a8a8a8";

		private const string HeadshotColor = "#f72c25";

		private const char NoInfoChar = '-';

		private static readonly Dictionary<char, string> LogTypeToColor = new Dictionary<char, string>
		{
			{ 'O', "#a8a8a8" },
			{ 'X', "#fc6203" },
			{ 'H', "#f72c25" }
		};

		[SerializeField]
		private TextMeshProUGUI _text;

		private readonly Queue<char> _hitLogQueue = new Queue<char>(30);

		public static OverwatchHitRegLog Instance { get; private set; }

		public void AddEntry(char next)
		{
			if (_hitLogQueue.Count + 1 > 30)
			{
				_hitLogQueue.Dequeue();
			}
			_hitLogQueue.Enqueue(next);
			UpdateText();
		}

		public void ClearEntries()
		{
			_hitLogQueue.Clear();
			UpdateText();
		}

		private void UpdateText()
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			for (int i = 0; i < 30 - _hitLogQueue.Count; i++)
			{
				stringBuilder.Append('-');
			}
			foreach (char item in _hitLogQueue)
			{
				if (LogTypeToColor.TryGetValue(item, out var value))
				{
					stringBuilder.Append("<color=" + value + ">");
				}
				else
				{
					stringBuilder.Append("<color=#FFFFFF>");
				}
				stringBuilder.Append(item);
				stringBuilder.Append("</color>");
			}
			_text.SetText(stringBuilder);
			StringBuilderPool.Shared.Return(stringBuilder);
		}

		private void Awake()
		{
			Instance = this;
			if (!ServerStatic.IsDedicated)
			{
				SpectatorTargetTracker.OnTargetChanged += OnTargetChanged;
			}
		}

		private void OnDestroy()
		{
			if (!ServerStatic.IsDedicated)
			{
				SpectatorTargetTracker.OnTargetChanged -= OnTargetChanged;
			}
		}

		private void OnTargetChanged()
		{
			ClearEntries();
		}
	}
}

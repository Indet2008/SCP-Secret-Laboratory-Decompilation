using System;
using UnityEngine;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSTabDetector : MonoBehaviour
	{
		private static bool _active;

		public static bool IsOpen
		{
			get
			{
				return _active;
			}
			private set
			{
				if (_active != value)
				{
					_active = value;
					OnStatusChanged?.Invoke();
				}
			}
		}

		public static event Action OnStatusChanged;

		private void OnEnable()
		{
			IsOpen = true;
		}

		private void OnDisable()
		{
			IsOpen = false;
		}
	}
}

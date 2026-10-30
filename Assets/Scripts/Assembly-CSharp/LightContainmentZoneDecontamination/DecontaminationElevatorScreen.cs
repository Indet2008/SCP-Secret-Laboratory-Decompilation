using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace LightContainmentZoneDecontamination
{
	public class DecontaminationElevatorScreen : MonoBehaviour
	{
		private static readonly HashSet<DecontaminationElevatorScreen> Instances = new HashSet<DecontaminationElevatorScreen>();

		private static string _lastText = string.Empty;

		[SerializeField]
		private TMP_Text _text;

		public static void SetText(string text)
		{
			foreach (DecontaminationElevatorScreen instance in Instances)
			{
				instance._text.SetText(text);
			}
		}

		public static void SetAllTexts(string text)
		{
			_lastText = text ?? string.Empty;
			foreach (DecontaminationElevatorScreen instance in Instances)
			{
				if (instance != null && instance._text != null)
				{
					instance._text.text = _lastText;
				}
			}
		}

		private void Awake()
		{
			Instances.Add(this);
			if (_text != null && !string.IsNullOrEmpty(_lastText))
			{
				_text.text = _lastText;
			}
		}

		private void OnDestroy()
		{
			Instances.Remove(this);
		}
	}
}

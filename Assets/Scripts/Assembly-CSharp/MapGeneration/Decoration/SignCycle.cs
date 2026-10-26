using System;
using TMPro;
using UnityEngine;

namespace MapGeneration.Decoration
{
	public class SignCycle : MonoBehaviour
	{
		[Serializable]
		private struct CycleData
		{
			public float Duration;

			public string Text;
		}

		[SerializeField]
		private CycleData[] _cycles;

		[SerializeField]
		private TMP_Text _targetText;

		private int _currentIndex;

		private float _timePassed;

		private void Update()
		{
			CycleData cycleData = _cycles[_currentIndex];
			_timePassed += Time.deltaTime;
			if (!(_timePassed < cycleData.Duration))
			{
				_timePassed = 0f;
				if (++_currentIndex >= _cycles.Length)
				{
					_currentIndex = 0;
				}
				_targetText.text = _cycles[_currentIndex].Text;
			}
		}
	}
}

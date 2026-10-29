using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class BackgroundColorChanging : MonoBehaviour
	{
		public Image Background;

		public Color ColorIni = Color.white;

		public Color ColorFin = new Color(1f, 0f, 0f, 1f);

		public float Chance = 0.8f;

		private int _framesActive;

		private void Start()
		{
			Background.color = ColorIni;
		}

		// Random flicker: switches to ColorFin for a couple of frames.
		private void Update()
		{
			if (_framesActive >= 2)
			{
				_framesActive = 0;
				Background.color = ColorIni;
			}
			if (_framesActive != 0)
			{
				_framesActive++;
			}
			else if (Random.value > Chance)
			{
				_framesActive = 1;
				Background.color = ColorFin;
			}
		}
	}
}

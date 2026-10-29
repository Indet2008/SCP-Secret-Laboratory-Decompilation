using UnityEngine;

namespace OperationalGuide
{
	public class ToggleGameobject : MonoBehaviour
	{
		public GameObject[] TogglableObjects;

		public bool DefaultState;

		private bool _toggle;

		public void Toggle()
		{
			_toggle = !_toggle;
			GameObject[] togglableObjects = TogglableObjects;
			for (int i = 0; i < togglableObjects.Length; i++)
			{
				togglableObjects[i].SetActive(_toggle);
			}
		}

		private void Awake()
		{
			_toggle = DefaultState;
			GameObject[] togglableObjects = TogglableObjects;
			for (int i = 0; i < togglableObjects.Length; i++)
			{
				togglableObjects[i].SetActive(_toggle);
			}
		}
	}
}

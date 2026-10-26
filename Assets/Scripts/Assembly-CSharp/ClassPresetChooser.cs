using System;
using System.Collections.Generic;
using UnityEngine;

public class ClassPresetChooser : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.RawImage[] startItems;

	public global::UnityEngine.UI.RawImage avatar;

	public global::TMPro.TextMeshProUGUI addInfo;


	[Serializable]
	public class PickerPreset
	{
		public string classID;

		public Texture icon;

		public int health;

		public float wSpeed;

		public float rSpeed;

		public float stamina;

		public Texture[] startingItems;

		public string en_additionalInfo;

		public string pl_additionalInfo;
	}

	public GameObject bottomMenuItem;

	public Transform bottomMenuHolder;

	public PickerPreset[] presets;

	private string curKey;

	private List<PickerPreset> curPresets = new List<PickerPreset>();

	private void Update()
	{
	}
}

using System;
using System.Collections.Generic;
using UnityEngine;

public class ClassPresetChooser : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.Slider health;

	public global::UnityEngine.UI.Slider wSpeed;

	public global::UnityEngine.UI.Slider rSpeed;

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

	public void RefreshBottomItems(string key)
	{
		curKey = key;
		int num = 0;
		for (int i = 0; i < presets.Length; i++)
		{
			if (presets[i].classID == key)
			{
				num++;
				curPresets.Add(presets[i]);
			}
		}
		foreach (Transform item in bottomMenuHolder)
		{
			UnityEngine.Object.Destroy(item.gameObject);
		}
		for (int j = 0; j < num; j++)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(bottomMenuItem, bottomMenuHolder);
			gameObject.GetComponent<BottomPickerItem>().SetupButton(key, j);
			gameObject.GetComponentInChildren<global::UnityEngine.UI.Text>().text = "ABCDEFGHIJKL"[j].ToString();
		}
	}

	private void Update()
	{
		if (curPresets.Count <= 0)
		{
			return;
		}
		PickerPreset pickerPreset = curPresets[PlayerPrefsSl.Get(curKey, 0)];
		health.value = pickerPreset.health;
		wSpeed.value = pickerPreset.wSpeed;
		rSpeed.value = pickerPreset.rSpeed;
		avatar.texture = pickerPreset.icon;
		for (int i = 0; i < startItems.Length; i++)
		{
			if (i < pickerPreset.startingItems.Length)
			{
				startItems[i].color = Color.white;
				startItems[i].texture = pickerPreset.startingItems[i];
			}
			else
			{
				startItems[i].color = Color.clear;
			}
		}
	}
}

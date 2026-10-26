using System;
using System.Collections.Generic;
using MEC;
using Mirror;
using NorthwoodLib;
using TMPro;
using ToggleableMenus;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class GameMenu : SimpleToggleableMenu
{
	public static GameMenu singleton;

	public GameObject[] minors;

	public Graphic[] colorableElements;

	public TextMeshProUGUI infoText;

	public GameObject hideHUDText;

	private bool _pastebinDisplayed;

	public override bool CanToggle => true;

	public override bool LockMovement
	{
		get
		{
			GameObject currentSelectedGameObject = EventSystem.current.currentSelectedGameObject;
			if (currentSelectedGameObject != null && currentSelectedGameObject.TryGetComponent<TMP_InputField>(out var component))
			{
				return component.isFocused;
			}
			return false;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		singleton = this;
	}

	private void Update()
	{
		if (!HideHUDController.IsHUDVisible)
		{
			hideHUDText.GetComponent<TextMeshProUGUI>().text = "Warning: HUD is hidden\n" + $"Press <b>{NewInput.GetKey(ActionName.HideGUI)}</b> to enable HUD";
		}
	}

	private IEnumerator<float> _ShowServerInfo(string id)
	{
		infoText.text = "";
		if (id.Contains('/'))
		{
			infoText.text = "The URL isn't directing to pastebin site. Please contact server owner.";
			yield break;
		}
		using HttpCoroutine http = HttpQuery.GetCoroutine("https://pastebin.com/raw/" + id);
		yield return http.Wait();
		try
		{
			http.CheckResult();
			string text = http.GetText();
			if (text.Contains("<title>Pastebin.com - Locked Paste</title>", StringComparison.OrdinalIgnoreCase))
			{
				infoText.text = "The provided paste is locked via password and cannot be displayed. Please contact the server owner.";
				yield break;
			}
			if (text.Length > 5000)
			{
				text = text.TruncateToLast(5000, '\n');
				text = text + "...\n<i><color=#87CEFA><u><link=\"https://pastebin.com/" + id + "\">(Click here for full content)</link></u></color></i>";
			}
			infoText.text = text;
			_pastebinDisplayed = true;
		}
		catch (Exception ex)
		{
			infoText.text = "Error getting server info: " + ex.Message;
		}
	}

	protected override void OnToggled()
	{
		base.OnToggled();
		GameObject[] array = minors;
		foreach (GameObject gameObject in array)
		{
			if (gameObject.activeSelf)
			{
				gameObject.SetActive(value: false);
			}
		}
	}

	public void SelectMinor(int id)
	{
		GameObject[] array = minors;
		foreach (GameObject gameObject in array)
		{
			if (gameObject.activeSelf)
			{
				gameObject.SetActive(value: false);
			}
		}
		minors[id].SetActive(value: true);
		if (id == 2 && !_pastebinDisplayed && ReferenceHub.TryGetHostHub(out var hub))
		{
			Timing.RunCoroutine(_ShowServerInfo(hub.characterClassManager.Pastebin), Segment.FixedUpdate);
		}
	}

	public void Disconnect()
	{
		if (NetworkServer.active)
		{
			NetworkManager.singleton.StopHost();
		}
		else
		{
			NetworkManager.singleton.StopClient();
		}
	}

	public void Exit()
	{
		IsEnabled = false;
	}
}

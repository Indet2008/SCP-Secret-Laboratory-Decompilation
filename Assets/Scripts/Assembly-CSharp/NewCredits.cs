using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Ported from the SL 12 CE client; the server build only kept the field layout.
public class NewCredits : MonoBehaviour
{
	public GameObject root;

	public GameObject canvas;

	public bool StartScroll;

	public float Speed;

	private const float OriginalSpeed = 1.45f;

	private const float FastSpeed = 6f;

	private bool _paused;

	public RectTransform Content;

	public RectTransform PrefCategory;

	public RectTransform PrefElementWithRole;

	public RectTransform PrefElement;

	public AudioSource CreditsMusic;

	private bool _loaded;

	private int _scrollDelay;

	private float _height;

	private RectTransform[] _contentChildren;

	private VerticalLayoutGroup layoutGroup;

	private MainMenuSoundtrackController menuSoundtrack;

	public NewCredits()
	{
		Speed = OriginalSpeed;
		_scrollDelay = 100;
	}

	private void OnEnable()
	{
		if (Content != null)
		{
			layoutGroup = Content.GetComponent<VerticalLayoutGroup>();
		}
	}

	public void OnButtonClick()
	{
		EnsureLoaded();
		if (menuSoundtrack == null)
		{
			menuSoundtrack = FindAnyObjectByType<MainMenuSoundtrackController>();
		}
		if (canvas != null)
		{
			canvas.SetActive(false);
		}
		Initialize();
		StartScroll = true;
		_scrollDelay = 100;
		if (root != null)
		{
			root.SetActive(true);
		}
		if (menuSoundtrack != null && CreditsMusic != null)
		{
			menuSoundtrack.SoundtrackState = MainMenuSoundtrackController.MenuSoundtrackState.Muted;
			CreditsMusic.Play();
		}
	}

	public void OnBackButtonClick()
	{
		Close();
	}

	private void Close()
	{
		if (canvas != null)
		{
			canvas.SetActive(true);
		}
		if (root != null)
		{
			root.SetActive(false);
		}
		StartScroll = false;
		if (menuSoundtrack != null && CreditsMusic != null)
		{
			menuSoundtrack.SoundtrackState = MainMenuSoundtrackController.MenuSoundtrackState.MenuJustLoaded;
			CreditsMusic.Stop();
		}
	}

	private void Update()
	{
		Speed = Input.GetKey(KeyCode.RightArrow) ? FastSpeed : OriginalSpeed;
		if (Input.GetKey(KeyCode.LeftArrow))
		{
			Speed = -Speed;
		}
		if (Input.GetKeyDown(KeyCode.DownArrow))
		{
			_paused = !_paused;
		}
		if (root != null && root.activeSelf && Input.GetKeyDown(KeyCode.Escape))
		{
			Close();
		}
	}

	private void FixedUpdate()
	{
		if (root == null || !root.activeSelf || !StartScroll || Content == null)
		{
			return;
		}
		if (_scrollDelay > 0)
		{
			_scrollDelay--;
			return;
		}
		if (layoutGroup != null && layoutGroup.enabled)
		{
			_height = Screen.height + Content.rect.height;
			layoutGroup.enabled = false;
		}
		if (_paused)
		{
			return;
		}
		if (ScrollAndCanEnd())
		{
			Close();
			return;
		}
		if (_contentChildren == null)
		{
			return;
		}
		foreach (RectTransform child in _contentChildren)
		{
			if (child == null)
			{
				continue;
			}
			bool visible = child.position.y > 0f && child.position.y <= Screen.height;
			if (child.gameObject.activeSelf != visible)
			{
				child.gameObject.SetActive(visible);
			}
		}
	}

	private bool ScrollAndCanEnd()
	{
		if (Content.localPosition.y >= _height)
		{
			return true;
		}
		if (Speed <= 0f && Content.localPosition.y <= 0f)
		{
			return false;
		}
		Content.Translate(Vector3.up * Speed);
		Vector3 lp = Content.localPosition;
		Content.localPosition = new Vector3(lp.x, Mathf.Clamp(lp.y, 0f, _height), lp.z);
		return false;
	}

	private void Initialize()
	{
		StartScroll = false;
		if (Content != null)
		{
			Content.localPosition = new Vector3(Content.localPosition.x, 0f, 0f);
		}
		if (layoutGroup != null)
		{
			layoutGroup.enabled = true;
		}
		if (_contentChildren == null)
		{
			return;
		}
		foreach (RectTransform child in _contentChildren)
		{
			if (child != null && !child.gameObject.activeSelf)
			{
				child.gameObject.SetActive(true);
			}
		}
	}

	private void EnsureLoaded()
	{
		if (_loaded)
		{
			return;
		}
		_loaded = true;
		try
		{
			Load();
		}
		catch (System.Exception e)
		{
			// CreditsData reads CreditsCache.json and Translations/ from the working directory.
			Debug.LogException(e);
			_contentChildren = new RectTransform[0];
		}
	}

	private void Load()
	{
		List<RectTransform> list = new List<RectTransform>();
		if (CreditsData.Data != null && Content != null)
		{
			foreach (CreditsCategory category in CreditsData.Data)
			{
				if (category.Records == null || category.Records.Length == 0)
				{
					continue;
				}
				RectTransform cat = Instantiate(PrefCategory, Content, true);
				cat.GetComponent<TextMeshProUGUI>().SetText(category.Header);
				cat.localScale = Vector3.one;
				list.Add(cat);
				foreach (CreditsEntry entry in category.Records)
				{
					if (!string.IsNullOrEmpty(entry.Title))
					{
						RectTransform el = Instantiate(PrefElementWithRole, Content, true);
						el.localScale = Vector3.one;
						NewCreditsElement comp = el.GetComponent<NewCreditsElement>();
						string displayName = entry.Name == CreditsData.CurrentNicknamePlaceholder ? (Welcome.CurrentNickname ?? "You") : entry.Name;
						comp.Name.SetText(displayName);
						comp.Role.SetText(entry.Title);
						comp.Background.color = entry.Color;
						list.Add(el);
					}
					else
					{
						string displayName = entry.Name ?? string.Empty;
						if (entry.Multi)
						{
							displayName = displayName.Replace("\n", " ");
						}
						RectTransform el = Instantiate(PrefElement, Content, true);
						el.localScale = Vector3.one;
						el.GetComponent<TextMeshProUGUI>().SetText(displayName);
						list.Add(el);
					}
				}
			}
		}
		_contentChildren = list.ToArray();
	}
}

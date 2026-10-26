using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

// Plays the shared UI sounds through ButtonAudioSource; rebuilt from the v14 field layout.
public class ButtonAudio : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerClickHandler
{
	[SerializeField]
	private bool _playHover;

	[SerializeField]
	private bool _playClick;

	private Selectable _selectable;

	private bool CanPlay
	{
		get
		{
			if (!isActiveAndEnabled)
			{
				return false;
			}
			if (_selectable == null)
			{
				_selectable = GetComponent<Selectable>();
			}
			return _selectable == null || _selectable.IsInteractable();
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (_playHover && CanPlay)
		{
			ButtonAudioSource.PlayHover();
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (_playClick && CanPlay)
		{
			ButtonAudioSource.PlayClick();
		}
	}
}

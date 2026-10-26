using UnityEngine;
using UnityEngine.EventSystems;

// Client-only (bodies stripped from the server build): drives the "Enable" hover animation of a social media tile.
public class SocialMediaButton : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	public RectTransform Parent;

	private Animator _animator;

	private static readonly int _enable = Animator.StringToHash("Enable");

	private void Start()
	{
		_animator = GetComponent<Animator>();
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (_animator != null)
		{
			_animator.SetBool(_enable, value: true);
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (_animator != null)
		{
			_animator.SetBool(_enable, value: false);
		}
	}
}

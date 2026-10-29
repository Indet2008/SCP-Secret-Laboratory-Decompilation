using CustomPlayerEffects;
using Interactables;
using Interactables.Verification;
using PlayerRoles;
using TMPro;
using UnityEngine;

public class Scp559InteractionText : MonoBehaviour
{
	[SerializeField]
	private CanvasGroup _group;

	[SerializeField]
	private TextMeshProUGUI _text;

	// Shown to a human looking at a cake with slices left, unless they already have the effect.
	private bool Visible
	{
		get
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			if (!hub.GetRoleId().IsHuman())
			{
				return false;
			}
			if (hub.playerEffectsController.GetEffect<Scp559Effect>().IsEnabled)
			{
				return false;
			}
			RaycastHit lastRaycastHit = CenterScreenRaycast.LastRaycastHit;
			if (lastRaycastHit.collider == null)
			{
				return false;
			}
			if (!lastRaycastHit.collider.gameObject.TryGetComponent<InteractableCollider>(out var component))
			{
				return false;
			}
			if (!(component.Target is Scp559Cake scp559Cake) || scp559Cake.Network_remainingSlices <= 0)
			{
				return false;
			}
			return StandardDistanceVerification.Default.ClientCanInteract(component, lastRaycastHit);
		}
	}

	private void Awake()
	{
		TranslationReader.OnTranslationsRefreshed += OnTranslationsRefreshed;
		OnTranslationsRefreshed();
	}

	private void OnDestroy()
	{
		TranslationReader.OnTranslationsRefreshed -= OnTranslationsRefreshed;
	}

	private void OnTranslationsRefreshed()
	{
		_text.text = string.Format(TranslationReader.Get("Facility", 48, "Press {0} to blow out the candles."), new ReadableKeyCode(NewInput.GetKey(ActionName.Interact)));
	}

	private void Update()
	{
		_group.alpha = Mathf.Clamp01(_group.alpha + (float)(Visible ? 3 : (-3)) * Time.deltaTime);
	}
}

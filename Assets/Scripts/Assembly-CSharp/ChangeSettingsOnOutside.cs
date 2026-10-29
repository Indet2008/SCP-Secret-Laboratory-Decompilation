using CustomRendering;
using UnityEngine;

// Restored from the client build (IL2CPP): on the surface the fog stops covering the skybox and,
// if enabled, the camera clears to the skybox instead of a solid color.
public class ChangeSettingsOnOutside : MonoBehaviour
{
	public bool changeClearFlags;

	private Camera _myCamera;

	private void Update()
	{
		if (!ReferenceHub.TryGetLocalHub(out _) || Outside.Singleton == null || FogController.Singleton == null)
		{
			return;
		}
		if (transform.root.TryGetComponent<ReferenceHub>(out var owner) && !owner.netIdentity.isLocalPlayer)
		{
			Object.Destroy(this);
			return;
		}
		Outside.OnSetOutside += Singleton_OnSetOutside;
		_myCamera = GetComponent<Camera>();
		Singleton_OnSetOutside(Outside.Singleton.IsFogEnabled);
		enabled = false;
	}

	private void OnDestroy()
	{
		Outside.OnSetOutside -= Singleton_OnSetOutside;
	}

	private void Singleton_OnSetOutside(bool isOutside)
	{
		if (FogController.Singleton != null && FogController.Singleton.FogEffect != null)
		{
			FogController.Singleton.FogEffect.CoverSkybox = isOutside ? 0f : 1f;
		}
		if (changeClearFlags && _myCamera != null)
		{
			_myCamera.clearFlags = isOutside ? CameraClearFlags.Skybox : CameraClearFlags.Color;
		}
	}
}

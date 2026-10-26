using GameObjectPools;
using UnityEngine;
using UnityEngine.Rendering;

public class SpectatorHidden : MonoBehaviour, IPoolResettable
{
	public Renderer AttachedRenderer { get; private set; }

	private void Awake()
	{
		AttachedRenderer = GetComponent<Renderer>();
	}

	public void ResetObject()
	{
		AttachedRenderer.shadowCastingMode = ShadowCastingMode.On;
	}
}

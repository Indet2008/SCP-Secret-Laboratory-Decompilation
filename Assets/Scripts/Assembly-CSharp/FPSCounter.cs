using UnityEngine;

public class FPSCounter : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.Text FpsText;


	private void Start()
	{
		base.enabled = false;
	}

	private void Update()
	{
	}

	private void FixedUpdate()
	{
	}
}

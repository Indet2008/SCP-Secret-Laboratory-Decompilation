using UnityEngine;

public class LightBlink : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public float noshadowIntensMultiplier;

	public float minFlickerTimeRange;

	public float maxFlickerTimeRange;

	public float turnOnSpeed;

	public float maxIntensityDecreaseMultiplier;

	[global::UnityEngine.Header("Used to flicker multiple lights at the same time.")]
	[global::UnityEngine.Header("Leave empty to just use the attached light.")]
	public global::UnityEngine.Rendering.HighDefinition.HDAdditionalLightData[] lightGroup;


}

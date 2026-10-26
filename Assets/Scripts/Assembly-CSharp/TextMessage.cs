using UnityEngine;

public class TextMessage : MonoBehaviour
{
	public float spacing = 15.5f;

	public float xOffset = 3f;

	public float lerpSpeed = 3f;

	public float position;

	public float remainingLife;

	private Vector3 GetPosition()
	{
		return new Vector3(xOffset, spacing * position, 0f);
	}

	private void Start()
	{
	}

	private void Update()
	{
		remainingLife -= Time.deltaTime;
	}
}

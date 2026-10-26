using GameObjectPools;
using UnityEngine;

public class BreathingScript : MonoBehaviour, IPoolResettable
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private float _breatheDelay;

	[global::UnityEngine.SerializeField]
	private float _breatheDuration;

	[global::UnityEngine.SerializeField]
	private float _sprintBreatheDelay;

	[global::UnityEngine.SerializeField]
	private float _sprintBreatheDuration;


	public void ResetObject()
	{
	}
}

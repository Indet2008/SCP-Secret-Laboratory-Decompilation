using System;
using Mirror;
using UnityEngine;

public class StaticUnityMethods : MonoBehaviour
{
	public static bool IsPlaying
	{
		get
		{
			if (ReferenceHub.TryGetLocalHub(out var _))
			{
				if (!NetworkClient.active)
				{
					return NetworkServer.active;
				}
				return true;
			}
			return false;
		}
	}

	public static event Action OnUpdate;

	public static event Action OnLateUpdate;

	public static event Action OnFixedUpdate;

	public static event Action OnGui;

	private void Update()
	{
		OnUpdate?.Invoke();
	}

	private void FixedUpdate()
	{
		OnFixedUpdate?.Invoke();
	}

	private void LateUpdate()
	{
		OnLateUpdate?.Invoke();
	}

	private void OnGUI()
	{
		OnGui?.Invoke();
	}
}

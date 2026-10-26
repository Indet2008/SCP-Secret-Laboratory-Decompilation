using System;
using NorthwoodLib;
using UnityEngine;

public class MainThreadDispatcher : MonoBehaviour
{
	public enum DispatchTime
	{
		Update = 0,
		LateUpdate = 1,
		FixedUpdate = 2
	}

	private static readonly ActionDispatcher UpdateDispatcher = new ActionDispatcher();

	private static readonly ActionDispatcher LateUpdateDispatcher = new ActionDispatcher();

	private static readonly ActionDispatcher FixedUpdateDispatcher = new ActionDispatcher();

	public static void Dispatch(Action action, DispatchTime dispatchTime = DispatchTime.Update)
	{
		switch (dispatchTime)
		{
		case DispatchTime.Update:
			UpdateDispatcher.Dispatch(action);
			break;
		case DispatchTime.LateUpdate:
			LateUpdateDispatcher.Dispatch(action);
			break;
		case DispatchTime.FixedUpdate:
			FixedUpdateDispatcher.Dispatch(action);
			break;
		}
	}

	private void Update()
	{
		UpdateDispatcher.Invoke();
	}

	private void LateUpdate()
	{
		LateUpdateDispatcher.Invoke();
	}

	private void FixedUpdate()
	{
		FixedUpdateDispatcher.Invoke();
	}
}

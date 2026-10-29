using System;
using UnityEngine;
using UnityEngine.UI;

public class FPSCounter : MonoBehaviour
{
	private double _framerate;

	private double _frametime;

	private ushort _time;

	public Text FpsText;

	private void Start()
	{
		if (ServerStatic.IsDedicated)
		{
			base.enabled = false;
		}
	}

	private void Update()
	{
		float deltaTime = Time.deltaTime;
		_framerate = Math.Round(1f / deltaTime, 1);
		_frametime = Math.Round(deltaTime * 1000f, 1);
	}

	private void FixedUpdate()
	{
		if (_time++ == 24)
		{
			_time = 0;
			FpsText.text = "Framerate: " + _framerate + "   " + _frametime + "ms";
		}
	}
}

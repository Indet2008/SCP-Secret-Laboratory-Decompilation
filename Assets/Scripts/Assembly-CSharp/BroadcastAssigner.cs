using TMPro;
using UnityEngine;

public class BroadcastAssigner : MonoBehaviour
{
	public TMP_Text Display;

	private static BroadcastAssigner _singleton;

	private float _timeLeft;

	private bool _showing;

	public static void ClearCurrent()
	{
		if (_singleton != null)
		{
			_singleton._timeLeft = 0f;
		}
	}

	private void Start()
	{
		_singleton = this;
		Hide();
	}

	private void Update()
	{
		if (_showing)
		{
			_timeLeft -= Time.deltaTime;
			if (_timeLeft > 0f)
			{
				return;
			}
			_showing = false;
		}
		if (Broadcast.Messages.Count == 0)
		{
			Hide();
			return;
		}
		BroadcastMessage broadcastMessage = Broadcast.Messages.Dequeue();
		if (broadcastMessage != null && !(Display == null))
		{
			_showing = true;
			_timeLeft = broadcastMessage.Time;
			Display.text = broadcastMessage.Text;
			Display.overflowMode = (broadcastMessage.Truncated ? TextOverflowModes.Truncate : TextOverflowModes.Overflow);
			Display.enabled = true;
		}
	}

	private void Hide()
	{
		if (Display != null && Display.enabled)
		{
			Display.enabled = false;
			Display.text = string.Empty;
		}
	}
}
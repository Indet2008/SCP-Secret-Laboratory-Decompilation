using System.Text;
using Mirror;
using UnityEngine;

public class AlphaWarheadOutsitePanel : NetworkBehaviour
{
	// Client-only display logic restored from the client build (IL2CPP): drives every AlphaWarheadScreen.
	private enum UpdateType
	{
		Empty = 0,
		Zero = 1,
		Wait = 2,
		Ready = 3,
		Disabled = 4,
		Time = 5,
		Skip = 6
	}

	private const string TextZero = "<color=orange><size=2700>00:00.00</size></color>";

	private const int MinutePosition = 25;

	private const int SecondPosition = 28;

	private const int MillisecondPosition = 31;

	private const float RefreshInterval = 0.5f;

	private const float InevitableTime = 10f;

	private static bool _loaded;

	private static float _refreshTimer;

	private static UpdateType _lastTextType = UpdateType.Empty;

	private static int _lastDisplayedTime = -1;

	private static readonly StringBuilder CurrentTime = new StringBuilder(TextZero);

	private static string _textDisabled = "<color=red><size=1800>DISABLED</size></color>";

	private static string _textWait = "<color=red><size=2000>PLEASE WAIT</size></color>";

	private static string _textReady = "<color=green><size=1800>READY</size></color>";

	public Animator panelButtonCoverAnim;

	private static readonly int Enabled = Animator.StringToHash("enabled");

	public static AlphaWarheadNukesitePanel nukeside => AlphaWarheadNukesitePanel.Singleton;

	private void Update()
	{
		if (nukeside == null)
		{
			return;
		}
		base.transform.localPosition = new Vector3(0f, 0f, 9f);
		panelButtonCoverAnim.SetBool(Enabled, AlphaWarheadActivationPanel.IsUnlocked);
	}

	// Called every frame by AlphaWarheadController so the nuke-room screens update even when this surface panel is not active.
	public static void ClientUpdateDisplays()
	{
		if (!_loaded)
		{
			_loaded = true;
			_textDisabled = TranslationReader.Get("Nuke", 0, _textDisabled);
			_textWait = TranslationReader.Get("Nuke", 1, _textWait);
			_textReady = TranslationReader.Get("Nuke", 2, _textReady);
		}
		if (AlphaWarheadController.InProgress || _refreshTimer == 0f)
		{
			UpdateDisplays();
		}
		_refreshTimer += Time.deltaTime;
		if (_refreshTimer > RefreshInterval)
		{
			_refreshTimer = 0f;
		}
	}

	private static void UpdateDisplays()
	{
		UpdateType updateType = CheckUpdateType();
		if (updateType == UpdateType.Skip || (updateType == _lastTextType && updateType != UpdateType.Time))
		{
			return;
		}
		_lastTextType = updateType;
		float timeUntilDetonation = AlphaWarheadController.TimeUntilDetonation;
		bool showInevitableWarn = AlphaWarheadController.InProgress && timeUntilDetonation <= InevitableTime && timeUntilDetonation > 0f;
		string text = updateType switch
		{
			UpdateType.Empty => string.Empty,
			UpdateType.Zero => TextZero,
			UpdateType.Wait => _textWait,
			UpdateType.Ready => _textReady,
			UpdateType.Disabled => _textDisabled,
			UpdateType.Time => CurrentTime.ToString(),
			_ => "Undefined"
		};
		AlphaWarheadScreen.SetScreen(text, showInevitableWarn);
	}

	private static UpdateType CheckUpdateType()
	{
		if (AlphaWarheadController.InProgress)
		{
			float timeUntilDetonation = AlphaWarheadController.TimeUntilDetonation;
			if (timeUntilDetonation <= 0f)
			{
				// Blinking 00:00.00 after detonation.
				return ((int)(Time.realtimeSinceStartup * 2f) & 1) != 0 ? UpdateType.Zero : UpdateType.Empty;
			}
			int centiseconds = (int)(timeUntilDetonation * 100f);
			if (centiseconds == _lastDisplayedTime)
			{
				return UpdateType.Skip;
			}
			_lastDisplayedTime = centiseconds;
			int minutes = centiseconds / 6000;
			int rest = centiseconds - minutes * 6000;
			int seconds = rest / 100;
			SetDigits(MinutePosition, minutes);
			SetDigits(SecondPosition, seconds);
			SetDigits(MillisecondPosition, rest - seconds * 100);
			return UpdateType.Time;
		}
		if (nukeside == null || !nukeside.Networkenabled)
		{
			return UpdateType.Disabled;
		}
		AlphaWarheadController singleton = AlphaWarheadController.Singleton;
		if (singleton != null && singleton.CooldownEndTime > NetworkTime.time)
		{
			return UpdateType.Wait;
		}
		return UpdateType.Ready;
	}

	private static void SetDigits(int position, int value)
	{
		CurrentTime[position] = (char)(48 + value / 10);
		CurrentTime[position + 1] = (char)(48 + value % 10);
	}

	public override bool Weaved()
	{
		return true;
	}
}

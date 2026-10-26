using System;
using Achievements;
using TMPro;
using UnityEngine;

public class AchievementDebugButton : MonoBehaviour
{
	[SerializeField]
	private TMP_Text _stateText;

	[SerializeField]
	private TMP_Text _nameText;

	public AchievementName TargetAchievement { get; set; }

	private Achievement Achievement
	{
		get
		{
			if (!AchievementManager.Achievements.TryGetValue(TargetAchievement, out var value))
			{
				throw new NullReferenceException($"Could not find achievement by name {TargetAchievement}.");
			}
			return value;
		}
	}

	private bool IsUnlocked
	{
		get
		{
			Achievement achievement = Achievement;
			if (AchievementDebugMenu.QueuedAchievements.Contains(achievement))
			{
				return false;
			}
			return true;
		}
	}

	public void AddToQueue()
	{
		if (IsUnlocked)
		{
			AchievementDebugMenu.QueuedAchievements.Enqueue(Achievement);
			UpdateState();
		}
	}

	private void Start()
	{
		_nameText.text = TargetAchievement.ToString();
		UpdateState();
	}

	private void OnEnable()
	{
		UpdateState();
	}

	private void OnDisable()
	{
		UpdateState();
	}

	private void UpdateState()
	{
		bool isUnlocked = IsUnlocked;
		_stateText.text = (isUnlocked ? "✔" : "X");
		_stateText.color = (isUnlocked ? Color.green : Color.red);
	}
}

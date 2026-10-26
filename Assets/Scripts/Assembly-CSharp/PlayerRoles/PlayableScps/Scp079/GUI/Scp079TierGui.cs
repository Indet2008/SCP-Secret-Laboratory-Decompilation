using System;
using System.Text;
using NorthwoodLib.Pools;
using PlayerRoles.Subroutines;
using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079TierGui : Scp079BarBaseGui
	{
		[SerializeField]
		private TextMeshProUGUI _textTier;

		private bool _uiDirty;

		private Scp079TierManager _tierManager;

		private string _tierFormat;

		private string _expFormat;

		private string _maxTierText;

		private string _levelUpNotification;

		private string _cachedText;

		private float _cachedFill;

		public const string NewLineFormat = "\n  - ";

		protected override string Text => _cachedText;

		protected override float FillAmount => _cachedFill;

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			_tierFormat = Translations.Get(Scp079HudTranslation.AccessTier);
			_expFormat = Translations.Get(Scp079HudTranslation.Experience);
			_maxTierText = Translations.Get(Scp079HudTranslation.MaxTierReached);
			_levelUpNotification = Translations.Get(Scp079HudTranslation.AccessTierUnlocked);
			role.SubroutineModule.TryGetSubroutine<Scp079TierManager>(out _tierManager);
			Scp079TierManager tierManager = _tierManager;
			tierManager.OnExpChanged = (Action)Delegate.Combine(tierManager.OnExpChanged, new Action(SetDirty));
			Scp079TierManager tierManager2 = _tierManager;
			tierManager2.OnLevelledUp = (Action)Delegate.Combine(tierManager2.OnLevelledUp, new Action(OnLevelledUp));
			_uiDirty = true;
		}

		private void OnDestroy()
		{
			Scp079TierManager tierManager = _tierManager;
			tierManager.OnExpChanged = (Action)Delegate.Remove(tierManager.OnExpChanged, new Action(SetDirty));
			Scp079TierManager tierManager2 = _tierManager;
			tierManager2.OnLevelledUp = (Action)Delegate.Remove(tierManager2.OnLevelledUp, new Action(OnLevelledUp));
		}

		protected override void Update()
		{
			base.Update();
			if (_uiDirty)
			{
				_textTier.text = string.Format(_tierFormat, _tierManager.AccessTierLevel);
				if (_tierManager.NextLevelThreshold <= 0)
				{
					_cachedFill = 1f;
					_cachedText = _maxTierText;
				}
				else
				{
					_cachedFill = (float)_tierManager.RelativeExp / (float)_tierManager.NextLevelThreshold;
					_cachedText = string.Format(_expFormat, _tierManager.RelativeExp, _tierManager.NextLevelThreshold);
				}
				_uiDirty = false;
			}
		}

		private void SetDirty()
		{
			_uiDirty = true;
		}

		private void OnLevelledUp()
		{
			SetDirty();
			bool flag = false;
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.AppendFormat(_levelUpNotification, _tierManager.AccessTierLevel);
			SubroutineBase[] allSubroutines = base.Role.SubroutineModule.AllSubroutines;
			for (int i = 0; i < allSubroutines.Length; i++)
			{
				if (allSubroutines[i] is IScp079LevelUpNotifier scp079LevelUpNotifier)
				{
					if (!flag)
					{
						stringBuilder.Append("\n  - ");
					}
					flag = !scp079LevelUpNotifier.WriteLevelUpNotification(stringBuilder, _tierManager.AccessTierIndex);
				}
			}
			string text = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			if (flag)
			{
				text = text.Remove(text.Length - "\n  - ".Length);
			}
			Scp079NotificationManager.AddNotification(new Scp079AccentedNotification(text));
		}
	}
}

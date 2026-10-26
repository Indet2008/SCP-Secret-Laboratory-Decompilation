using System.Diagnostics;
using MapGeneration.Distributors;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079GeneratorWarningGui : Scp079GuiElementBase
	{
		[SerializeField]
		private AudioClip _warningSound;

		[SerializeField]
		private float _headerCooldown;

		private int _lastAmount;

		private string _headerText;

		private readonly Stopwatch _headerStopwatchTimer = Stopwatch.StartNew();

		private const string HeaderFormat = "<color=red>{0}</color>";

		private void Awake()
		{
			_headerText = Translations.Get(Scp079HudTranslation.YouAreBeingAttacked);
		}

		private void Update()
		{
			int num = 0;
			bool flag = _headerStopwatchTimer.Elapsed.TotalSeconds < (double)_headerCooldown;
			bool flag2 = flag && !Scp079Role.LocalInstanceActive;
			foreach (Scp079Generator allGenerator in Scp079Recontainer.AllGenerators)
			{
				if (allGenerator.Activating && Scp079GeneratorNotification.TrackedGens.Add(allGenerator))
				{
					num++;
					if (_lastAmount == 0 && !flag)
					{
						Scp079NotificationManager.AddNotification($"<color=red>{_headerText}</color>");
						_headerStopwatchTimer.Restart();
					}
					Scp079NotificationManager.AddNotification(new Scp079GeneratorNotification(allGenerator, flag2));
				}
			}
			if (num > _lastAmount && !flag2)
			{
				PlaySound(_warningSound);
			}
			_lastAmount = num;
		}
	}
}

using System;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class AnimCullingStatsCommand : ICommand
	{
		private readonly struct AnimSample
		{
			public readonly int Updates;

			public readonly int TotalModels;

			public int Percent => Mathf.RoundToInt((float)(100 * Updates) / (float)TotalModels);

			public override string ToString()
			{
				return $"{Updates}/{TotalModels} ({Percent}%)";
			}

			public AnimSample(int updates, int totalModels)
			{
				Updates = updates;
				TotalModels = totalModels;
			}
		}

		private static readonly AnimSample[] Samples = new AnimSample[100];

		private static bool _isEnabled;

		private static int _animUpdates;

		private static int _totalMeasurements;

		private static AnimSample _lastSample;

		public string Command { get; } = "animcullingstats";

		public string[] Aliases { get; } = new string[2] { "animcullingdebug", "animdebug" };

		public string Description { get; } = "Displays current animation culling stats.";

		private static bool Enabled
		{
			get
			{
				return _isEnabled;
			}
			set
			{
				if (value != Enabled)
				{
					_isEnabled = value;
					if (value)
					{
						_animUpdates = 0;
						StaticUnityMethods.OnGui += OnGUI;
						StaticUnityMethods.OnUpdate += OnUpdate;
						CullingSubcontroller.OnAnyAnimatorUpdated += OnAnyAnimatorUpdated;
					}
					else
					{
						_totalMeasurements = 0;
						StaticUnityMethods.OnGui -= OnGUI;
						StaticUnityMethods.OnUpdate -= OnUpdate;
						CullingSubcontroller.OnAnyAnimatorUpdated -= OnAnyAnimatorUpdated;
					}
				}
			}
		}

		private static void OnGUI()
		{
			int num = 0;
			int num2 = 0;
			int num3 = Mathf.Min(_totalMeasurements, Samples.Length);
			for (int i = 0; i < num3; i++)
			{
				AnimSample animSample = Samples[i];
				num += animSample.Updates;
				num2 += animSample.TotalModels;
			}
			AnimSample animSample2 = new AnimSample(num, num2);
			GUILayout.BeginArea(new Rect(new Vector2(10f, 10f), new Vector2(250f, 999f)));
			GUILayout.Label("Animation Culling Stats:");
			GUILayout.Label("Last frame: " + _lastSample);
			GUILayout.Label($"Last {num3} frames: " + animSample2);
			GUILayout.EndArea();
		}

		private static void OnAnyAnimatorUpdated()
		{
			_animUpdates++;
		}

		private static void OnUpdate()
		{
			if (!StaticUnityMethods.IsPlaying)
			{
				Enabled = false;
				return;
			}
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is IFpcRole fpcRole && fpcRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel && animatedCharacterModel.TryGetSubcontroller<CullingSubcontroller>(out var _))
				{
					num++;
				}
			}
			AnimSample animSample = new AnimSample(_animUpdates, num);
			int num2 = _totalMeasurements % Samples.Length;
			Samples[num2] = animSample;
			_animUpdates = 0;
			_totalMeasurements++;
			_lastSample = animSample;
		}

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			bool flag = !Enabled;
			if (flag && (!ReferenceHub.TryGetLocalHub(out var hub) || !hub.queryProcessor.GameplayData))
			{
				response = "Gameplay data permission (in Remote Admin) is required to enable animation culling stats.";
				return false;
			}
			Enabled = flag;
			response = "Animation culling stats " + (Enabled ? "enabled" : "hidden") + ".";
			return true;
		}
	}
}

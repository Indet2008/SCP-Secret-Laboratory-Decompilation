namespace LabApi.Features.Wrappers
{
	public static class Warhead
	{
		public readonly struct DetonationScenario
		{
			public readonly int TimeToDetonate;

			public readonly int AdditionalTime;

			public readonly WarheadScenarioType Type;

			public readonly byte Id;

			public int TotalTime => TimeToDetonate + AdditionalTime;

			internal DetonationScenario(AlphaWarheadController.DetonationScenario detonationScenario, byte id, WarheadScenarioType type)
			{
				TimeToDetonate = detonationScenario.TimeToDetonate;
				AdditionalTime = (int)detonationScenario.AdditionalTime;
				Type = type;
				Id = id;
			}
		}

		public static AlphaWarheadController? BaseController => AlphaWarheadController.Singleton;

		public static AlphaWarheadNukesitePanel? BaseNukesitePanel => AlphaWarheadNukesitePanel.Singleton;

		public static AlphaWarheadOutsitePanel? BaseOutsidePanel { get; private set; }

		public static global::System.Collections.Generic.HashSet<BlastDoor> BlastDoors => BlastDoor.Instances;

		public static bool Exists => BaseController != null;

		public static bool LeverStatus
		{
			get
			{
				return BaseNukesitePanel?.enabled ?? false;
			}
			set
			{
				if (BaseNukesitePanel != null)
				{
					BaseNukesitePanel.Networkenabled = value;
				}
			}
		}

		public static bool IsAuthorized
		{
			get
			{
				return AlphaWarheadActivationPanel.IsUnlocked;
			}
			set
			{
				AlphaWarheadActivationPanel.IsUnlocked = value;
			}
		}

		public static bool IsLocked
		{
			get
			{
				return BaseController?.IsLocked ?? false;
			}
			set
			{
				if (BaseController != null)
				{
					BaseController.IsLocked = value;
				}
			}
		}

		public static bool IsDetonated => AlphaWarheadController.Detonated;

		public static bool IsDetonationInProgress => AlphaWarheadController.InProgress;

		public static float DetonationTime
		{
			get
			{
				return AlphaWarheadController.TimeUntilDetonation;
			}
			set
			{
				BaseController?.ForceTime(value);
			}
		}

		public static double CooldownTime
		{
			get
			{
				return global::System.Math.Max(0.0, (BaseController?.CooldownEndTime - global::Mirror.NetworkTime.time).GetValueOrDefault());
			}
			set
			{
				if (BaseController != null)
				{
					BaseController.NetworkCooldownEndTime = global::Mirror.NetworkTime.time + value;
				}
			}
		}

		public static bool ForceCountdownToggle
		{
			get
			{
				return DeadmanSwitch.ForceCountdownToggle;
			}
			set
			{
				DeadmanSwitch.ForceCountdownToggle = value;
			}
		}

		public static float DeadManSwitchRemaining
		{
			get
			{
				return DeadmanSwitch.CountdownTimeLeft;
			}
			set
			{
				DeadmanSwitch.CountdownTimeLeft = value;
			}
		}

		public static float DeadManSwitchMaxTime
		{
			get
			{
				return DeadmanSwitch.CountdownMaxTime;
			}
			set
			{
				DeadmanSwitch.CountdownMaxTime = value;
			}
		}

		public static global::LabApi.Features.Wrappers.Warhead.DetonationScenario Scenario
		{
			get
			{
				if (BaseController == null)
				{
					return default;
				}
				return ScenarioType switch
				{
					WarheadScenarioType.Start => StartScenarios[BaseController.Info.ScenarioId], 
					WarheadScenarioType.Resume => ResumeScenarios[BaseController.Info.ScenarioId], 
					WarheadScenarioType.DeadmanSwitch => DeadmanSwitchScenario, 
					_ => default, 
				};
			}
			set
			{
				if (BaseController == null)
				{
					return;
				}
				if (value.Equals(null))
				{
					int duration = global::GameCore.ConfigFile.ServerConfig.GetInt("warhead_tminus_start_duration", 90);
					var anon = global::System.Linq.Enumerable.FirstOrDefault(global::System.Linq.Enumerable.Select(StartScenarios, (global::LabApi.Features.Wrappers.Warhead.DetonationScenario val, int index) => new { val, index }), x => x.val.TimeToDetonate == duration);
					byte scenarioId = (anon.Equals(null) ? BaseController.DefaultScenarioId : ((byte)anon.index));
					AlphaWarheadController? baseController = BaseController;
					AlphaWarheadSyncInfo info = BaseController.Info;
					info.ScenarioType = WarheadScenarioType.Start;
					info.ScenarioId = scenarioId;
					baseController.NetworkInfo = info;
				}
				else
				{
					AlphaWarheadController? baseController2 = BaseController;
					AlphaWarheadSyncInfo info = BaseController.Info;
					info.ScenarioType = value.Type;
					info.ScenarioId = value.Id;
					baseController2.NetworkInfo = info;
				}
			}
		}

		public static WarheadScenarioType ScenarioType => BaseController?.Info.ScenarioType ?? WarheadScenarioType.Start;

		public static global::System.Collections.Generic.IReadOnlyList<global::LabApi.Features.Wrappers.Warhead.DetonationScenario> StartScenarios { get; private set; } = global::System.Array.Empty<global::LabApi.Features.Wrappers.Warhead.DetonationScenario>();

		public static global::System.Collections.Generic.IReadOnlyList<global::LabApi.Features.Wrappers.Warhead.DetonationScenario> ResumeScenarios { get; private set; } = global::System.Array.Empty<global::LabApi.Features.Wrappers.Warhead.DetonationScenario>();

		public static global::LabApi.Features.Wrappers.Warhead.DetonationScenario DeadmanSwitchScenario { get; private set; } = default;

		public static void Start(bool isAutomatic = false, bool suppressSubtitles = false, global::LabApi.Features.Wrappers.Player? activator = null)
		{
			BaseController?.InstantPrepare();
			BaseController?.StartDetonation(isAutomatic, suppressSubtitles, activator?.ReferenceHub);
		}

		public static void Stop(global::LabApi.Features.Wrappers.Player? activator = null)
		{
			BaseController?.CancelDetonation(activator?.ReferenceHub);
		}

		public static void Detonate()
		{
			DetonationTime = 0f;
		}

		public static void OpenBlastDoors()
		{
			foreach (BlastDoor instance in BlastDoor.Instances)
			{
				instance.ServerSetTargetState(isOpen: true);
			}
		}

		public static void CloseBlastDoors()
		{
			foreach (BlastDoor instance in BlastDoor.Instances)
			{
				instance.ServerSetTargetState(isOpen: false);
			}
		}

		public static void Shake()
		{
			BaseController?.RpcShake(achieve: false);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::LabApi.Events.Handlers.ServerEvents.WaitingForPlayers += OnWaitingForPlayers;
		}

		private static void OnWaitingForPlayers()
		{
			BaseOutsidePanel = global::UnityEngine.Object.FindObjectOfType<AlphaWarheadOutsitePanel>();
			StartScenarios = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Select(BaseController.StartScenarios, (AlphaWarheadController.DetonationScenario x, int i) => new global::LabApi.Features.Wrappers.Warhead.DetonationScenario(x, (byte)i, WarheadScenarioType.Start)));
			ResumeScenarios = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Select(BaseController.ResumeScenarios, (AlphaWarheadController.DetonationScenario x, int i) => new global::LabApi.Features.Wrappers.Warhead.DetonationScenario(x, (byte)i, WarheadScenarioType.Resume)));
			DeadmanSwitchScenario = new global::LabApi.Features.Wrappers.Warhead.DetonationScenario(BaseController.DeadmanSwitchScenario, 0, WarheadScenarioType.DeadmanSwitch);
		}

		private static void OnMapDestroyed()
		{
			BaseOutsidePanel = null;
		}
	}
}

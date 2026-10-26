using System.Collections.Generic;
using Achievements.Handlers;
using InventorySystem;
using Mirror;
using UnityEngine;

namespace Achievements
{
	public static class AchievementManager
	{
		public struct AchievementMessage : NetworkMessage
		{
			public byte AchievementId;
		}

		public static readonly AchievementHandlerBase[] Handlers = new AchievementHandlerBase[31]
		{
			new GeneralDamageHandler(),
			new EscapeHandler(),
			new ItemPickupHandler(),
			new BePoliteBeEfficientHandler(),
			new RespawnHandler(),
			new Scp914UpgradeHandler(),
			new TurnThemAllHandler(),
			new GeneralKillsHandler(),
			new IntercomHandler(),
			new ChangeInCommandHandler(),
			new HeWillBeBackHandler(),
			new IllPassThanksHandler(),
			new MelancholyOfDecayHandler(),
			new ProceedWithCautionHandler(),
			new SecureContainProtectHandler(),
			new DontBlinkHandler(),
			new OvertimeHandler(),
			new RuleBreakerHandler(),
			new CompleteTheMissionHandler(),
			new ArmyOfOneHandler(),
			new LMGGHandler(),
			new OnSpeakingTerms(),
			new HatsOffToYouHandler(),
			new GeneralUseItemHandler(),
			new SignalLostHandler(),
			new JustResourcesHandler(),
			new HawkeyeHandler(),
			new ThinkFastHandler(),
			new TrilateralTerminationHandler(),
			new MutuallyAssuredDestructionHandler(),
			new ToothAndNailHandler()
		};

		public static readonly Dictionary<AchievementName, Achievement> Achievements = new Dictionary<AchievementName, Achievement>
		{
			[AchievementName.TurnThemAll] = new Achievement("turnthemall", 559416662751707317L, byServer: true),
			[AchievementName.Pacified] = new Achievement("unvoluntaryragequit", 559416663020142679L, byServer: true),
			[AchievementName.MelancholyOfDecay] = new Achievement("newb", 559417282514780170L, byServer: true),
			[AchievementName.DontBlink] = new Achievement("firsttime", 559417282594471936L, byServer: true),
			[AchievementName.LightsOut] = new Achievement("arescue", 559417357718781955L, byServer: true),
			[AchievementName.ItsAlwaysLeft] = new Achievement("awayout", 559417906258247700L, byServer: true),
			[AchievementName.AccessGranted] = new Achievement("betrayal", 559417906199265281L, byServer: true),
			[AchievementName.DeltaCommand] = new Achievement("chaos", 559418104510152720L, byServer: true),
			[AchievementName.ProceedWithCaution] = new Achievement("electrocuted", 559418104552095768L, byServer: true),
			[AchievementName.Friendship] = new Achievement("friendship", 564138635457331343L, byServer: true),
			[AchievementName.ForScience] = new Achievement("forscience", 564138635566514176L, byServer: true),
			[AchievementName.IsThisThingOn] = new Achievement("isthisthingon", 564138635448942717L, byServer: true),
			[AchievementName.FireInTheHole] = new Achievement("iwanttobearocket", 564138635402936330L, byServer: true),
			[AchievementName.HeWillBeBack] = new Achievement("larryisyourfriend", 564138674611290119L, byServer: true),
			[AchievementName.BePoliteBeEfficient] = new Achievement("pewpew", 564138635105140767L, byServer: true),
			[AchievementName.ExecutiveAccess] = new Achievement("power", 564139505062379520L, byServer: true),
			[AchievementName.SecureContainProtect] = new Achievement("securecontainprotect", 564139504848601118L, byServer: true),
			[AchievementName.TMinus] = new Achievement("tminus", 564139505112580131L),
			[AchievementName.ChangeInCommand] = new Achievement("tableshaveturned", 564139505834000508L, byServer: true),
			[AchievementName.ThatCanBeUseful] = new Achievement("thatcanbeusefull", 564139505045733386L, byServer: true),
			[AchievementName.JustResources] = new Achievement("justresources", "dboys_killed", 909163354143211570L, 50, byServer: true),
			[AchievementName.ThatWasClose] = new Achievement("thatwasclose", 564140195134439474L, byServer: true),
			[AchievementName.SomethingDoneRight] = new Achievement("timetodoitmyself", 564140195465658378L, byServer: true),
			[AchievementName.WalkItOff] = new Achievement("gravity", 564140195017129984L, byServer: true),
			[AchievementName.AnomalouslyEfficient] = new Achievement("wowreally", 564140195382034434L, byServer: true),
			[AchievementName.MicrowaveMeal] = new Achievement("zap", 564140195000090635L, byServer: true),
			[AchievementName.EscapeArtist] = new Achievement("escapeartist", 564140574047731713L, byServer: true),
			[AchievementName.Escape207] = new Achievement("escape207", 638780450600386580L, byServer: true),
			[AchievementName.CrisisAverted] = new Achievement("crisisaverted", 638780450612969483L, byServer: true),
			[AchievementName.DidntEvenFeelThat] = new Achievement("didntevenfeelthat", 638780488433139752L, byServer: true),
			[AchievementName.IllPassThanks] = new Achievement("illpassthanks", 638780450311110658L, byServer: true),
			[AchievementName.Overcurrent] = new Achievement("attemptedrecharge", 638780450776809472L, byServer: true),
			[AchievementName.PropertyOfChaos] = new Achievement("propertyofchaos", 638780450667626506L, byServer: true),
			[AchievementName.Overtime] = new Achievement("overtime", 0L, byServer: true),
			[AchievementName.RuleBreaker] = new Achievement("rulebreaker", 0L, byServer: true),
			[AchievementName.CompleteTheMission] = new Achievement("completethemission", 0L, byServer: true),
			[AchievementName.ArmyOfOne] = new Achievement("armyofone", 0L, byServer: true),
			[AchievementName.LMGG] = new Achievement("lmgg", 0L, byServer: true),
			[AchievementName.OnSpeakingTerms] = new Achievement("onspeakingterms", 0L, byServer: true),
			[AchievementName.HatsOffToYou] = new Achievement("hatsofftoyou", 0L, byServer: true),
			[AchievementName.AmnesticAmbush] = new Achievement("amnesticambush", 0L, byServer: true),
			[AchievementName.AfterlifeCommunicator] = new Achievement("afterlifecommunicator", 0L, byServer: true),
			[AchievementName.SignalLost] = new Achievement("signallost", 0L, byServer: true),
			[AchievementName.Hawkeye] = new Achievement("hawkeye", 0L, byServer: true),
			[AchievementName.ThinkFast] = new Achievement("thinkfast", 0L, byServer: true),
			[AchievementName.TrilateralTermination] = new Achievement("trilateraltermination", 0L, byServer: true),
			[AchievementName.MutuallyAssuredDestruction] = new Achievement("mutuallyassureddestruction", 0L, byServer: true),
			[AchievementName.UndeadSpaceProgram] = new Achievement("undeadspaceprogram", 0L, byServer: true),
			[AchievementName.ArizonaRanger] = new Achievement("arizonaranger", 0L, byServer: true),
			[AchievementName.Matador] = new Achievement("matador", 0L, byServer: true),
			[AchievementName.ToothAndNail] = new Achievement("toothandnail", 0L, byServer: true)
		};

		public static bool AchievementsDisabled { get; set; } = false;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnLocalClientStarted += LocalPlayerStarted;
			AchievementHandlerBase[] handlers = Handlers;
			for (int i = 0; i < handlers.Length; i++)
			{
				handlers[i].OnInitialize();
			}
		}

		private static void LocalPlayerStarted()
		{
			NetworkClient.ReplaceHandler<AchievementMessage>(ClientMessageReceived);
			AchievementHandlerBase[] handlers = Handlers;
			for (int i = 0; i < handlers.Length; i++)
			{
				handlers[i].OnRoundStarted();
			}
		}

		private static void ClientMessageReceived(AchievementMessage msg)
		{
			if (Achievements.TryGetValue((AchievementName)msg.AchievementId, out var value) && value.ActivatedByServer)
			{
				value.Achieve();
			}
		}
	}
}

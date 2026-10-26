namespace RemoteAdmin
{
	public class PlayerCommandSender : CommandSender
	{
		public readonly ReferenceHub ReferenceHub;

		public override string SenderId => ReferenceHub.authManager.UserId;

		public int PlayerId => ReferenceHub.PlayerId;

		public override string Nickname => ReferenceHub.nicknameSync.MyNick;

		public override ulong Permissions => ReferenceHub.serverRoles.Permissions;

		public override byte KickPower
		{
			get
			{
				if (!ReferenceHub.authManager.RemoteAdminGlobalAccess)
				{
					return ReferenceHub.serverRoles.KickPower;
				}
				return byte.MaxValue;
			}
		}

		public override bool FullPermissions => false;

		public override string LogName => Nickname + " (" + ReferenceHub.authManager.UserId + ")";

		public PlayerCommandSender(ReferenceHub hub)
		{
			ReferenceHub = hub;
		}

		public override void RaReply(string text, bool success, bool logToConsole, string overrideDisplay)
		{
			ReferenceHub.queryProcessor.SendToClient(text, success, logToConsole, overrideDisplay);
		}

		public override void Print(string text)
		{
			ReferenceHub.queryProcessor.SendToClient(text, isSuccess: true, logInConsole: true, "");
		}

		public override bool Available()
		{
			return true;
		}
	}
}

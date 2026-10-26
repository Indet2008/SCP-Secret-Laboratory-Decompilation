namespace Query
{
	public class QueryCommandSender : CommandSender
	{
		private readonly QueryUser _qu;

		public override string SenderId => _qu.SenderID;

		public override string Nickname => _qu.SenderID;

		public override ulong Permissions => _qu.QueryPermissions;

		public override byte KickPower => _qu.QueryKickPower;

		public override bool FullPermissions
		{
			get
			{
				if (_qu.QueryPermissions == ulong.MaxValue)
				{
					return KickPower == byte.MaxValue;
				}
				return false;
			}
		}

		internal QueryCommandSender(QueryUser usr)
		{
			_qu = usr;
		}

		public override void Print(string text)
		{
			_qu.Send(text, QueryMessage.ClientReceivedContentType.ConsoleString);
		}

		public override void RaReply(string text, bool success, bool logToConsole, string overrideDisplay)
		{
			if (!_qu.ClientFlags.HasFlagFast(QueryHandshake.ClientFlags.SuppressRaResponses))
			{
				if (_qu.ClientFlags.HasFlagFast(QueryHandshake.ClientFlags.RemoteAdminMetadata))
				{
					_qu.Send(new RemoteAdminResponse(text, success, logToConsole, overrideDisplay).Serialize(), QueryMessage.ClientReceivedContentType.RemoteAdminSerializedResponse);
				}
				else if (success)
				{
					_qu.Send(text, QueryMessage.ClientReceivedContentType.RemoteAdminPlaintextResponse);
				}
				else
				{
					_qu.Send(text, QueryMessage.ClientReceivedContentType.RemoteAdminUnsuccessfulPlaintextResponse);
				}
			}
		}

		public override bool Available()
		{
			return _qu.Connected;
		}

		public void Disconnect()
		{
			_qu.Disconnect();
		}
	}
}

using System.Collections.Generic;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class GetSpecificPortMappingEntryRequestMessage : RequestMessageBase
	{
		private readonly int _externalPort;

		private readonly NetworkProtocolType _networkProtocolType;

		public GetSpecificPortMappingEntryRequestMessage(NetworkProtocolType networkProtocolType, int externalPort)
		{
			_networkProtocolType = networkProtocolType;
			_externalPort = externalPort;
		}

		public override IDictionary<string, object> ToXml()
		{
			return new Dictionary<string, object>
			{
				{
					"NewRemoteHost",
					string.Empty
				},
				{ "NewExternalPort", _externalPort },
				{
					"NewProtocol",
					(_networkProtocolType == NetworkProtocolType.Tcp) ? "TCP" : "UDP"
				}
			};
		}
	}
}

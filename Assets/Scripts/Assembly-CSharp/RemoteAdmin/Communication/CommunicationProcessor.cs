using System.Collections.Generic;
using RemoteAdmin.Interfaces;

namespace RemoteAdmin.Communication
{
	public class CommunicationProcessor
	{
		public static readonly Dictionary<int, IServerCommunication> ServerCommunication = new Dictionary<int, IServerCommunication>
		{
			{
				0,
				new RaPlayerList()
			},
			{
				1,
				new RaPlayer()
			},
			{
				3,
				new RaPlayerAuth()
			},
			{
				5,
				new RaGlobalBan()
			},
			{
				7,
				new RaServerStatus()
			},
			{
				8,
				new RaTeamStatus()
			},
			{
				9,
				new RaDummyActions()
			}
		};

		public static readonly Dictionary<int, IClientCommunication> ClientCommunication = new Dictionary<int, IClientCommunication>
		{
			{
				0,
				new RaPlayerList()
			},
			{
				1,
				new RaPlayer()
			},
			{
				2,
				new RaPlayerQR()
			},
			{
				6,
				new RaClipboard()
			},
			{
				7,
				new RaServerStatus()
			},
			{
				8,
				new RaTeamStatus()
			},
			{
				9,
				new RaDummyActions()
			}
		};

		public static T RequestServerChannel<T>() where T : IServerCommunication
		{
			foreach (IServerCommunication value in ServerCommunication.Values)
			{
				if (value is T)
				{
					return (T)value;
				}
			}
			return default(T);
		}

		public static T RequestClientChannel<T>() where T : IClientCommunication
		{
			foreach (IClientCommunication value in ClientCommunication.Values)
			{
				if (value is T)
				{
					return (T)value;
				}
			}
			return default(T);
		}
	}
}
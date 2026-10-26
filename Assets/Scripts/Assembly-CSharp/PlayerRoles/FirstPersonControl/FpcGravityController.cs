using System.Collections.Generic;
using CentralAuth;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcGravityController
	{
		private static readonly Dictionary<ReferenceHub, Vector3> SyncedValues = new Dictionary<ReferenceHub, Vector3>();

		public static Vector3 DefaultGravity { get; } = new Vector3(0f, -19.6f, 0f);

		public Vector3 Gravity
		{
			get
			{
				return GetGravity(Hub);
			}
			set
			{
				if (!NetworkServer.active || Motor.Hub == null)
				{
					SyncedValues[Hub] = value;
				}
				else
				{
					ServerSetGravity(Hub, value);
				}
			}
		}

		public FpcMotor Motor { get; set; }

		public ReferenceHub Hub => Motor.Hub;

		public static Vector3 GetGravity(ReferenceHub hub)
		{
			return SyncedValues.GetValueOrDefault(hub, DefaultGravity);
		}

		public static void ServerSetGravity(ReferenceHub hub, Vector3 gravity)
		{
			SyncedValues[hub] = gravity;
			new SyncedGravityMessages.GravityMessage(gravity, hub).SendToHubsConditionally((ReferenceHub n) => n.authManager.InstanceMode == ClientInstanceMode.ReadyClient);
		}

		public FpcGravityController(FpcMotor fpcMotor)
		{
			Motor = fpcMotor;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandler;
			ReferenceHub.OnPlayerAdded += OnPlayerAdded;
		}

		private static void RegisterHandler()
		{
			NetworkClient.ReplaceHandler((SyncedGravityMessages.GravityMessage msg) =>
			{
				if (!(msg.TargetHub == null))
				{
					SyncedValues[msg.TargetHub] = msg.Gravity;
				}
			});
		}

		private static void OnPlayerAdded(ReferenceHub hub)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (SyncedValues.TryGetValue(allHub, out var value))
				{
					hub.connectionToClient.Send(new SyncedGravityMessages.GravityMessage(value, allHub));
				}
			}
		}
	}
}

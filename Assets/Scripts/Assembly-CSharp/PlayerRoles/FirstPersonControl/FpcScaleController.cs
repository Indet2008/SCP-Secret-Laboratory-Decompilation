using System.Collections.Generic;
using CentralAuth;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcScaleController
	{
		private static readonly Dictionary<ReferenceHub, Vector3> SyncedValues = new Dictionary<ReferenceHub, Vector3>();

		public Vector3 Scale
		{
			get
			{
				if (SyncedValues.TryGetValue(Hub, out var value))
				{
					return value;
				}
				return Vector3.one;
			}
			set
			{
				Transform transform = Hub.transform;
				Vector3 localScale = (SyncedValues[Hub] = value);
				transform.localScale = localScale;
				if (NetworkServer.active && !(Motor.Hub == null))
				{
					new SyncedScaleMessages.ScaleMessage(value, Hub).SendToHubsConditionally((ReferenceHub n) => n.authManager.InstanceMode == ClientInstanceMode.ReadyClient);
				}
			}
		}

		public FpcMotor Motor { get; set; }

		public ReferenceHub Hub => Motor.Hub;

		public FpcScaleController(FpcMotor fpcMotor)
		{
			Motor = fpcMotor;
			if (SyncedValues.TryGetValue(Hub, out var value))
			{
				Scale = value;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandler;
			ReferenceHub.OnPlayerAdded += OnPlayerAdded;
		}

		private static void RegisterHandler()
		{
			NetworkClient.ReplaceHandler((SyncedScaleMessages.ScaleMessage msg) =>
			{
				if (!(msg.TargetHub == null))
				{
					if (msg.TargetHub.roleManager.CurrentRole is IFpcRole fpcRole)
					{
						fpcRole.FpcModule.Motor.ScaleController.Scale = msg.Scale;
					}
					else
					{
						SyncedValues[msg.TargetHub] = msg.Scale;
					}
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
				if (allHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					hub.connectionToClient.Send(new SyncedScaleMessages.ScaleMessage(fpcRole.FpcModule.Motor.ScaleController.Scale, allHub));
				}
			}
		}
	}
}

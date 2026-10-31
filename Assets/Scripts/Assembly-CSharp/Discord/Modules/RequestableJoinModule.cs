using System;
using System.Text;
using Discord.Basic;
using Mirror.LiteNetLib4Mirror;
using TMPro;
using UnityEngine;

namespace Discord.Modules
{
	public class RequestableJoinModule : DiscordModuleBase
	{
		private static readonly int Requested = Animator.StringToHash("Requested");

		private const string RequestedAnimKey = "Requested";

		[SerializeField]
		private Animator _joinAnimator;

		[SerializeField]
		private TMP_Text _joinText;

		private DiscordUser _joinRequest;

		public override bool IsEnabled
		{
			get
			{
				return base.IsEnabled;
			}
			set
			{
				base.IsEnabled = value;
			}
		}

		public bool RequestAvailable { get; set; }

		public void SendResponse(Reply reply)
		{
			if (RequestAvailable)
			{
				if (string.IsNullOrEmpty(_joinRequest.username))
				{
					Debug.Log(string.Format("Discord: Sent {0} as the response to join request.", reply));
				}
				else
				{
					string text = string.Format("Discord: Sent {0} as the response to {1}'s join request.", reply, _joinRequest.username);
					Debug.Log(text);
					GameCore.Console.AddLog(text, Color.gray, nospace: true);
				}
				_joinAnimator.SetBool("Requested", value: false);
				CallbackController.Respond(_joinRequest.userId, reply);
				RequestAvailable = false;
			}
		}

		protected override void OnUpdateModule()
		{
			if (IsEnabled && Input.GetKey(KeyCode.LeftControl) && _joinAnimator.GetBool(Requested))
			{
				if (Input.GetKeyDown(KeyCode.Y))
				{
					SendResponse(Reply.Yes);
				}
				else if (Input.GetKeyDown(KeyCode.N))
				{
					SendResponse(Reply.No);
				}
			}
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			CallbackController.Callbacks.requestCallback -= OnReceivedRequest;
			CallbackController.Callbacks.joinCallback -= OnRequestAccepted;
		}

		private void OnReceivedRequest(ref DiscordUser request)
		{
			if (IsEnabled)
			{
				string text = "Discord: Join request " + request.username + "#" + request.discriminator + ": " + request.userId;
				Debug.Log(text);
				GameCore.Console.AddLog(text, Color.gray, nospace: true);
				_joinText.text = "<b><color=#7289DA>" + request.username + "<color=#99AAB5>#</color>" + request.discriminator + "</color></b> would like to join your match!";
				_joinAnimator.SetBool("Requested", value: true);
				_joinRequest = request;
				RequestAvailable = true;
			}
		}

		private void OnRequestAccepted(string secret)
		{
			Debug.Log("Discord: Joining (" + secret + ")");
			string[] array = Encoding.UTF8.GetString(Convert.FromBase64String(secret)).Split(':');
			if (array.Length != 3)
			{
				return;
			}
			ushort.TryParse(array[1], out var result);
			if (array[2] != GameCore.Version.VersionString)
			{
				GameCore.Console.AddLog("Discord: Could not join the server - version mismatch. Required version: " + array[2], Color.red, nospace: true);
				return;
			}
			LiteNetLib4MirrorTransport.Singleton.clientAddress = array[0];
			LiteNetLib4MirrorTransport.Singleton.port = result;
			CustomNetworkManager.LastIp = array[0] + ":" + result;
			CustomLiteNetLib4MirrorTransport.SetReconnectionParameters(extended: false);
			CustomNetworkManager typedSingleton = CustomNetworkManager.TypedSingleton;
			typedSingleton.ShowLoadingScreen(0);
			typedSingleton.StartClient();
		}

		private void Start()
		{
			CallbackController.Callbacks.requestCallback += OnReceivedRequest;
			CallbackController.Callbacks.joinCallback += OnRequestAccepted;
		}

		private void Update()
		{
			UpdateModule();
		}
	}
}

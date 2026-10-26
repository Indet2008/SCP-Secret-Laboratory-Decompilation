namespace Discord.Modules
{
	public class RequestableJoinModule : global::Discord.Modules.DiscordModuleBase
	{
		private static readonly int Requested;

		private const string RequestedAnimKey = "Requested";

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Animator _joinAnimator;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _joinText;

		private global::Discord.Basic.DiscordUser _joinRequest;

		public override bool IsEnabled
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		public bool RequestAvailable
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		public void SendResponse(global::Discord.Reply reply)
		{
		}

		protected override void OnUpdateModule()
		{
		}

		protected override void OnDestroy()
		{
		}

		private void OnReceivedRequest(ref global::Discord.Basic.DiscordUser request)
		{
		}

		private void OnRequestAccepted(string secret)
		{
		}

		private void Start()
		{
		}

		private void Update()
		{
		}

		public RequestableJoinModule()
		{
		}
	}
}

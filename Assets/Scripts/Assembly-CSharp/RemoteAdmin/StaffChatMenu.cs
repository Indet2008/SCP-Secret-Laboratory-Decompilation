namespace RemoteAdmin
{
	public class StaffChatMenu : global::UnityEngine.MonoBehaviour
	{
		private readonly struct MessageContent
		{
			private readonly string _content;

			private readonly global::System.DateTime _timestamp;

			public readonly bool SystemMessage;

			public MessageContent(string content, global::System.DateTime timestamp, bool systemMessage = false)
			{ this = default;
			}

			public string FormatContent()
			{
				return default;
			}
		}

		private const int MaxInstantiatedMessages = 100;

		private const string DefaultGroupHexColor = "fff";

		private static readonly global::UnityEngine.Color SystemMessageColor;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _chatBox;

		[global::UnityEngine.SerializeField]
		private global::RemoteAdmin.StaffChatMessage _messagePrefab;

		[global::UnityEngine.SerializeField]
		private global::RemoteAdmin.Menus.RaCommandMenu _commandMenu;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_InputField _input;

		private static bool _isInstantiated;

		private static global::RemoteAdmin.StaffChatMenu _singleton;

		private static readonly global::System.Collections.Generic.List<global::RemoteAdmin.StaffChatMenu.MessageContent> NotInstantiatedMessages;

		private static readonly global::System.Collections.Generic.Queue<global::RemoteAdmin.StaffChatMenu.MessageContent> MessageHistory;

		private static string _oldAddress;

		private static ushort _oldPort;

		private static global::RemoteAdmin.StaffChatMenu Singleton
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		public void ClearAllMessages()
		{
		}

		private void Update()
		{
		}

		private void Start()
		{
		}

		private void OnDestroy()
		{
		}

		private void OnEnable()
		{
		}

		private void AddMessage(global::RemoteAdmin.StaffChatMenu.MessageContent messageContent)
		{
		}

		public static void TryAddMessage(uint sender, string content)
		{
		}

		private static global::RemoteAdmin.StaffChatMenu.MessageContent FormatMessage(uint sender, string content)
		{
			return default;
		}

		private static void SaveMessage(global::RemoteAdmin.StaffChatMenu.MessageContent messageContent)
		{
		}

		public StaffChatMenu()
		{
		}
	}
}

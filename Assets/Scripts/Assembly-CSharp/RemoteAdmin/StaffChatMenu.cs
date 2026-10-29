using System;
using System.Collections.Generic;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using RemoteAdmin.Menus;
using TMPro;
using UnityEngine;

namespace RemoteAdmin
{
	public class StaffChatMenu : MonoBehaviour
	{
		private readonly struct MessageContent
		{
			private readonly string _content;

			private readonly DateTime _timestamp;

			public readonly bool SystemMessage;

			public MessageContent(string content, DateTime timestamp, bool systemMessage = false)
			{
				_content = content;
				_timestamp = timestamp;
				SystemMessage = systemMessage;
			}

			public string FormatContent()
			{
				if (_timestamp == DateTime.MinValue)
				{
					return _content;
				}
				return "[" + _timestamp.ToString("T") + "] " + _content;
			}
		}

		private const int MaxInstantiatedMessages = 100;

		private const string DefaultGroupHexColor = "fff";

		private static readonly Color SystemMessageColor = new Color(0.219f, 0.0619f, 0.0619f, 1f);

		[SerializeField]
		private RectTransform _chatBox;

		[SerializeField]
		private StaffChatMessage _messagePrefab;

		[SerializeField]
		private RaCommandMenu _commandMenu;

		[SerializeField]
		private TMP_InputField _input;

		private static bool _isInstantiated;

		private static StaffChatMenu _singleton;

		private static readonly List<MessageContent> NotInstantiatedMessages = new List<MessageContent>();

		private static readonly Queue<MessageContent> MessageHistory = new Queue<MessageContent>();

		private static string _oldAddress;

		private static ushort _oldPort;

		private static StaffChatMenu Singleton
		{
			get
			{
				return _singleton;
			}
			set
			{
				_singleton = value;
				_isInstantiated = _singleton != null;
			}
		}

		public void ClearAllMessages()
		{
			MessageHistory.Clear();
			for (int i = 0; i < _chatBox.childCount; i++)
			{
				UnityEngine.Object.Destroy(_chatBox.GetChild(i).gameObject);
			}
		}

		private void Update()
		{
			if ((Input.GetKeyDown(KeyCode.Return) || Input.GetKeyDown(KeyCode.KeypadEnter)) && _input.text.Length > 0)
			{
				_commandMenu.SendCommand("@", string.Empty);
				_input.text = string.Empty;
			}
		}

		private void Start()
		{
			Singleton = this;
			LiteNetLib4MirrorTransport singleton = LiteNetLib4MirrorTransport.Singleton;
			string clientAddress = singleton.clientAddress;
			ushort port = singleton.port;
			if (MessageHistory.Count > 0 && clientAddress == _oldAddress && port == _oldPort)
			{
				MessageContent[] array = MessageHistory.ToArray();
				MessageHistory.Clear();
				MessageContent[] array2 = array;
				foreach (MessageContent messageContent in array2)
				{
					AddMessage(messageContent);
				}
			}
			else
			{
				_oldAddress = clientAddress;
				_oldPort = port;
				MessageHistory.Clear();
			}
			if (NotInstantiatedMessages.Count > 0)
			{
				foreach (MessageContent notInstantiatedMessage in NotInstantiatedMessages)
				{
					AddMessage(notInstantiatedMessage);
				}
			}
			NotInstantiatedMessages.Clear();
		}

		private void OnDestroy()
		{
			NotInstantiatedMessages.Clear();
			Singleton = null;
		}

		private void OnEnable()
		{
			StaffChatNotification.UnreadMessagesCount = 0;
		}

		private void AddMessage(MessageContent messageContent)
		{
			StaffChatMessage staffChatMessage = UnityEngine.Object.Instantiate(_messagePrefab, _chatBox);
			if (messageContent.SystemMessage)
			{
				staffChatMessage.Color = SystemMessageColor;
			}
			SaveMessage(messageContent);
			if (_chatBox.childCount > 100)
			{
				UnityEngine.Object.Destroy(_chatBox.GetChild(0).gameObject);
			}
			staffChatMessage.Content = messageContent.FormatContent();
			if (!base.isActiveAndEnabled)
			{
				StaffChatNotification.UnreadMessagesCount++;
			}
		}

		public static void TryAddMessage(uint sender, string content)
		{
			if (_isInstantiated)
			{
				Singleton.AddMessage(FormatMessage(sender, content));
			}
			else if (NetworkClient.active)
			{
				NotInstantiatedMessages.Add(FormatMessage(sender, content));
				StaffChatNotification.UnreadMessagesCount++;
			}
		}

		private static MessageContent FormatMessage(uint sender, string content)
		{
			if (!ReferenceHub.TryGetHubNetID(sender, out var hub))
			{
				return new MessageContent(content, DateTime.MinValue, systemMessage: true);
			}
			string text = hub.serverRoles.CurrentColor?.ColorHex;
			if (string.IsNullOrEmpty(text))
			{
				text = "fff";
			}
			return new MessageContent(string.Format("<b><color=#{0}>{1} ({2})</color></b>: {3}", text, hub.nicknameSync.MyNick, hub.PlayerId, content), DateTime.Now);
		}

		private static void SaveMessage(MessageContent messageContent)
		{
			MessageHistory.Enqueue(messageContent);
			while (MessageHistory.Count > 100)
			{
				MessageHistory.Dequeue();
			}
		}
	}
}

using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace RemoteAdmin
{
	public class StaffChatNotification : MonoBehaviour
	{
		private const byte MaxUnreadNotifications = 9;

		private static readonly HashSet<StaffChatNotification> Notifications = new HashSet<StaffChatNotification>();

		private static byte _unreadMessagesCount;

		[SerializeField]
		private TextMeshProUGUI _notificationText;

		public static byte UnreadMessagesCount
		{
			get
			{
				return _unreadMessagesCount;
			}
			set
			{
				_unreadMessagesCount = value;
				RefreshUnreadCount(clamped: true);
			}
		}

		private void Start()
		{
			Notifications.Add(this);
			RefreshUnreadCount(clamped: true);
		}

		private void Update()
		{
			if (_unreadMessagesCount != 0 && SubmenuSelector.Singleton != null && SubmenuSelector.Singleton.SelectedMenu != null && SubmenuSelector.Singleton.SelectedMenu.Title == "Staff Chat" && SubmenuSelector.Singleton.SelectedMenu.Panel != null && SubmenuSelector.Singleton.SelectedMenu.Panel.activeInHierarchy)
			{
				DisableNotifications();
			}
		}

		private void OnDestroy()
		{
			Notifications.Remove(this);
		}

		private static void DisableNotifications()
		{
			UnreadMessagesCount = 0;
		}

		private static void RefreshUnreadCount(bool clamped)
		{
			foreach (StaffChatNotification notification in Notifications)
			{
				if (!(notification == null))
				{
					notification.gameObject.SetActive(_unreadMessagesCount != 0);
					if (notification._notificationText != null)
					{
						notification._notificationText.text = ((clamped && _unreadMessagesCount > MaxUnreadNotifications) ? (MaxUnreadNotifications + "+") : _unreadMessagesCount.ToString());
						notification._notificationText.enabled = _unreadMessagesCount != 0;
					}
				}
			}
		}
	}
}

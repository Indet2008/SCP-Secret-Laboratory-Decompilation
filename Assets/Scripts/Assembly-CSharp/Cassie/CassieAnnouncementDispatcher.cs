using System.Collections.Generic;
using Mirror;
using RoundRestarting;
using UnityEngine;
using Utils.Networking;
using Utils.NonAllocLINQ;

namespace Cassie
{
	public static class CassieAnnouncementDispatcher
	{
		private static readonly List<CassieAnnouncement> ReorganizerNonAlloc = new List<CassieAnnouncement>();

		private static readonly List<CassieAnnouncement> AllAnnouncements = new List<CassieAnnouncement>();

		public static IReadOnlyList<CassieAnnouncement> AllAnnouncementsPreview => AllAnnouncements;

		public static CassieAnnouncement CurrentAnnouncement { get; private set; }

		public static double AnnouncementFinishTime { get; private set; }

		public static double NextAnnouncementTime { get; private set; }

		public static bool AddToQueue(this CassieAnnouncement announcement)
		{
			return AllAnnouncements.AddIfNotContains(announcement);
		}

		public static bool Cancel(this CassieAnnouncement announcement)
		{
			int num = AllAnnouncements.IndexOf(announcement);
			if (num < 0)
			{
				return false;
			}
			AllAnnouncements[num].OnCancelled();
			AllAnnouncements.RemoveAt(num);
			return true;
		}

		public static void ClearAll()
		{
			while (AllAnnouncements.Count > 0)
			{
				List<CassieAnnouncement> allAnnouncements = AllAnnouncements;
				allAnnouncements[allAnnouncements.Count - 1].Cancel();
			}
			if (CurrentAnnouncement != null)
			{
				CurrentAnnouncement = null;
				AnnouncementFinishTime = 0.0;
				NextAnnouncementTime = 0.0;
			}
			new CassieTtsPayload(string.Empty, string.Empty, playBackground: false).SendToAuthenticated();
		}

		public static int GetAbsolutePositionInQueue(this CassieAnnouncement announcement)
		{
			int num = 0;
			bool flag = false;
			foreach (CassieAnnouncement allAnnouncement in AllAnnouncements)
			{
				if (allAnnouncement.Priority > announcement.Priority)
				{
					num++;
				}
				if (Mathf.Approximately(allAnnouncement.Priority, announcement.Priority) && !flag)
				{
					if (announcement == allAnnouncement)
					{
						flag = true;
					}
					else
					{
						num++;
					}
				}
			}
			return num;
		}

		public static int GetPositionWithinPriority(this CassieAnnouncement announcement)
		{
			int num = 0;
			foreach (CassieAnnouncement allAnnouncement in AllAnnouncements)
			{
				if (Mathf.Approximately(allAnnouncement.Priority, announcement.Priority))
				{
					if (announcement == allAnnouncement)
					{
						return num;
					}
					num++;
				}
			}
			return num;
		}

		public static void SetPositionWithinPriority(this CassieAnnouncement announcement, int position)
		{
			ReorganizerNonAlloc.Clear();
			for (int i = 0; i < AllAnnouncements.Count; i++)
			{
				CassieAnnouncement cassieAnnouncement = AllAnnouncements[i];
				if (Mathf.Approximately(cassieAnnouncement.Priority, announcement.Priority))
				{
					AllAnnouncements.RemoveAt(i);
					if (cassieAnnouncement != announcement)
					{
						ReorganizerNonAlloc.Add(cassieAnnouncement);
					}
					i--;
				}
			}
			int index = Mathf.Clamp(position, 0, ReorganizerNonAlloc.Count);
			ReorganizerNonAlloc.Insert(index, announcement);
			AllAnnouncements.AddRange(ReorganizerNonAlloc);
		}

		private static void UpdateQueue()
		{
			if (!NetworkServer.active || !StaticUnityMethods.IsPlaying)
			{
				return;
			}
			CassieAnnouncement cassieAnnouncement = null;
			foreach (CassieAnnouncement allAnnouncement in AllAnnouncements)
			{
				allAnnouncement.UpdateQueued();
				if (cassieAnnouncement == null || allAnnouncement.Priority > cassieAnnouncement.Priority)
				{
					cassieAnnouncement = allAnnouncement;
				}
			}
			if (NetworkTime.time < NextAnnouncementTime)
			{
				UpdateCurrentAnnouncement();
			}
			else if (cassieAnnouncement != null)
			{
				AllAnnouncements.Remove(cassieAnnouncement);
				PlayNewAnnouncement(cassieAnnouncement);
			}
		}

		private static void UpdateCurrentAnnouncement()
		{
			if (NetworkTime.time < AnnouncementFinishTime)
			{
				CurrentAnnouncement?.UpdatePlayed();
			}
			else if (CurrentAnnouncement != null)
			{
				CurrentAnnouncement.OnFinishedPlaying();
				CurrentAnnouncement = null;
			}
		}

		private static void PlayNewAnnouncement(CassieAnnouncement annc)
		{
			CurrentAnnouncement = annc;
			CurrentAnnouncement.OnStartedPlaying();
			CassieTtsPayload payload = CurrentAnnouncement.Payload;
			float postAnnouncementCooldown = CurrentAnnouncement.PostAnnouncementCooldown;
			if (CassieTtsAnnouncer.TryPlay(payload, out var totalDuration))
			{
				AnnouncementFinishTime = NetworkTime.time + (double)totalDuration;
				NextAnnouncementTime = AnnouncementFinishTime + (double)postAnnouncementCooldown;
				payload.SendToAuthenticated();
			}
		}

		private static void ClientHandleMessage(CassieTtsPayload tts)
		{
			if (StaticUnityMethods.IsPlaying && !NetworkServer.active)
			{
				CassieTtsAnnouncer.TryPlay(tts, out var _);
			}
		}

		private static void Reset()
		{
			AllAnnouncements.Clear();
			CurrentAnnouncement = null;
			NextAnnouncementTime = 0.0;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnUpdate += UpdateQueue;
			CassieTtsAnnouncer.OnSingletonSet += Reset;
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<CassieTtsPayload>(ClientHandleMessage);
			};
			RoundRestart.OnRestartTriggered += ClearAll;
		}
	}
}

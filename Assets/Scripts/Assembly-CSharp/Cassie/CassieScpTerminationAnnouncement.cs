using System;
using System.Collections.Generic;
using System.Text;
using Footprinting;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerStatsSystem;
using Subtitles;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace Cassie
{
	public class CassieScpTerminationAnnouncement : CassieAnnouncement
	{
		private const float WaitForOtherScpsDuration = 1f;

		private const float AnnouncementPriority = -1f;

		private readonly List<Footprint> _victims;

		private readonly string _announcementTts;

		private readonly SubtitlePart[] _subtitles;

		private float _remainingWait;

		public IReadOnlyList<Footprint> Victims => _victims;

		public override bool ReadyToPlay => _remainingWait <= 0f;

		public static event Action<CassieScpTerminationAnnouncement> OnAnnouncementFinishedPlaying;

		public CassieScpTerminationAnnouncement(Footprint victim, string tts, SubtitlePart[] subtitles)
			: base(default, -1f)
		{
			_victims = new List<Footprint> { victim };
			_announcementTts = tts;
			_subtitles = subtitles ?? Array.Empty<SubtitlePart>();
			_remainingWait = 1f;
		}

		public override void UpdateQueued()
		{
			base.UpdateQueued();
			if (_remainingWait > 0f)
			{
				_remainingWait -= Time.deltaTime;
			}
		}

		public override void OnStartedPlaying()
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			List<SubtitlePart> list = new List<SubtitlePart>();
			for (int i = 0; i < Victims.Count; i++)
			{
				ConvertSCP(Victims[i].Role, out var withoutSpace, out var withSpace);
				if (i == 0)
				{
					stringBuilder.Append("SCP ");
					stringBuilder.Append(withSpace);
				}
				else
				{
					stringBuilder.Append(". SCP ");
					stringBuilder.Append(withSpace);
				}
				list.Add(new SubtitlePart(SubtitleType.SCP, withoutSpace));
			}
			stringBuilder.Append(_announcementTts);
			list.AddRange(_subtitles);
			Payload = new CassieTtsPayload(StringBuilderPool.Shared.ToStringReturn(stringBuilder), list.ToArray());
			base.OnStartedPlaying();
		}

		public override void OnFinishedPlaying()
		{
			base.OnFinishedPlaying();
			OnAnnouncementFinishedPlaying?.Invoke(this);
		}

		public static void ConvertSCP(RoleTypeId role, out string withoutSpace, out string withSpace)
		{
			if (!role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				withoutSpace = string.Empty;
				withSpace = string.Empty;
			}
			else
			{
				ConvertSCP(result.RoleName, out withoutSpace, out withSpace);
			}
		}

		public static void ConvertSCP(string roleName, out string withoutSpace, out string withSpace)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			string[] array = roleName.Split('-');
			if (array.Length < 2)
			{
				Debug.LogError("Cassie role cannot be split by '-'. Possibly missing translation.");
				withoutSpace = "404";
				withSpace = "4 0 4";
				return;
			}
			withoutSpace = array[1];
			string text = withoutSpace;
			foreach (char value in text)
			{
				stringBuilder.Append(value);
				stringBuilder.Append(' ');
			}
			withSpace = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		public static void AnnounceScpTermination(ReferenceHub scp, DamageHandlerBase hit)
		{
			if (!scp.IsSCP(includeZombies: false) && (!scp.IsFlamingo() || ReferenceHub.AllHubs.Count((ReferenceHub hub) => hub.IsFlamingo()) > 1))
			{
				return;
			}
			string announcement = hit.CassieDeathAnnouncement.Announcement;
			SubtitlePart[] subtitleParts = hit.CassieDeathAnnouncement.SubtitleParts;
			if (string.IsNullOrEmpty(announcement))
			{
				return;
			}
			foreach (CassieAnnouncement item in CassieAnnouncementDispatcher.AllAnnouncementsPreview)
			{
				if (item is CassieScpTerminationAnnouncement cassieScpTerminationAnnouncement && !(cassieScpTerminationAnnouncement._announcementTts != announcement) && SubtitlePart.CheckEqualValues(cassieScpTerminationAnnouncement._subtitles, subtitleParts))
				{
					cassieScpTerminationAnnouncement._victims.Add(new Footprint(scp));
					cassieScpTerminationAnnouncement._remainingWait = 1f;
					return;
				}
			}
			CassieQueuingScpTerminationEventArgs e = new CassieQueuingScpTerminationEventArgs(scp, announcement, subtitleParts, hit);
			ServerEvents.OnCassieQueuingScpTermination(e);
			if (e.IsAllowed)
			{
				announcement = e.Announcement;
				subtitleParts = e.SubtitleParts;
				new CassieScpTerminationAnnouncement(new Footprint(scp), announcement, subtitleParts).AddToQueue();
				ServerEvents.OnCassieQueuedScpTermination(new CassieQueuedScpTerminationEventArgs(scp, announcement, subtitleParts, hit));
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerStats.OnAnyPlayerDied += AnnounceScpTermination;
		}
	}
}

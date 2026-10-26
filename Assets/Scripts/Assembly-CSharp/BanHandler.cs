using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using GameCore;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using NorthwoodLib.Pools;

public static class BanHandler
{
	public enum BanType
	{
		NULL = -1,
		UserId = 0,
		IP = 1
	}

	public static BanType GetBanType(int type)
	{
		if (type > EnumUtils<BanType>.Values.ToArray().Cast<int>().Max() || type < EnumUtils<BanType>.Values.ToArray().Cast<int>().Min())
		{
			return BanType.UserId;
		}
		return (BanType)type;
	}

	public static void Init()
	{
		try
		{
			if (!File.Exists(GetPath(BanType.UserId)))
			{
				File.Create(GetPath(BanType.UserId)).Close();
			}
			else
			{
				FileManager.RemoveEmptyLines(GetPath(BanType.UserId));
			}
			if (!File.Exists(GetPath(BanType.IP)))
			{
				File.Create(GetPath(BanType.IP)).Close();
			}
			else
			{
				FileManager.RemoveEmptyLines(GetPath(BanType.IP));
			}
		}
		catch
		{
			ServerConsole.AddLog("Can't create ban files!");
		}
		ValidateBans();
	}

	public static bool IssueBan(BanDetails ban, BanType banType, bool forced = false)
	{
		try
		{
			if (banType == BanType.IP && ban.Id.Equals("localClient", StringComparison.OrdinalIgnoreCase))
			{
				return false;
			}
			ban.OriginalName = ban.OriginalName.Replace(";", ":");
			ban.Issuer = ban.Issuer.Replace(";", ":");
			ban.Reason = ban.Reason.Replace(";", ":");
			Misc.ReplaceUnsafeCharacters(ref ban.OriginalName);
			Misc.ReplaceUnsafeCharacters(ref ban.Issuer);
			List<BanDetails> bans = GetBans(banType);
			if (!bans.Any((BanDetails b) => b.Id == ban.Id))
			{
				BanIssuingEventArgs e = new BanIssuingEventArgs(banType, ban);
				ServerEvents.OnBanIssuing(e);
				if (!forced && !e.IsAllowed)
				{
					return false;
				}
				banType = e.BanType;
				ban = e.BanDetails;
				FileManager.AppendFile(ban.ToString(), GetPath(banType));
				FileManager.RemoveEmptyLines(GetPath(banType));
				ServerEvents.OnBanIssued(new BanIssuedEventArgs(banType, ban));
			}
			else
			{
				BanDetails oldBanDetails = bans.First((BanDetails old) => string.Equals(old.Id, ban.Id, StringComparison.OrdinalIgnoreCase));
				BanUpdatingEventArgs e2 = new BanUpdatingEventArgs(banType, ban, oldBanDetails);
				ServerEvents.OnBanUpdating(e2);
				if (!forced && !e2.IsAllowed)
				{
					return false;
				}
				RemoveBan(ban.Id, banType, forced: true);
				banType = e2.BanType;
				ban = e2.BanDetails;
				IssueBan(ban, banType, forced: true);
				ServerEvents.OnBanUpdated(new BanUpdatedEventArgs(banType, ban, oldBanDetails));
			}
			return true;
		}
		catch
		{
			return false;
		}
	}

	public static void ValidateBans()
	{
		ServerConsole.AddLog("Validating bans...");
		ValidateBans(BanType.UserId);
		ValidateBans(BanType.IP);
		ServerConsole.AddLog("Bans has been validated.");
	}

	public static void ValidateBans(BanType banType)
	{
		List<string> list = FileManager.ReadAllLinesList(GetPath(banType));
		List<int> list2 = ListPool<int>.Shared.Rent();
		for (int num = list.Count - 1; num >= 0; num--)
		{
			string ban = list[num];
			if (ProcessBanItem(ban, banType) == null || !CheckExpiration(ProcessBanItem(ban, banType), BanType.NULL))
			{
				list2.Add(num);
			}
		}
		List<int> list3 = ListPool<int>.Shared.Rent();
		foreach (int item in list2)
		{
			if (!list3.Contains(item))
			{
				list3.Add(item);
			}
		}
		ListPool<int>.Shared.Return(list2);
		foreach (int item2 in list3.OrderByDescending((int index) => index))
		{
			list.RemoveAt(item2);
		}
		ListPool<int>.Shared.Return(list3);
		if (FileManager.ReadAllLines(GetPath(banType)) != list.ToArray())
		{
			FileManager.WriteToFile(list.ToArray(), GetPath(banType));
		}
	}

	public static bool CheckExpiration(BanDetails ban, BanType banType)
	{
		if (ban == null)
		{
			return false;
		}
		if (TimeBehaviour.ValidateTimestamp(ban.Expires, TimeBehaviour.CurrentTimestamp(), 0L))
		{
			return true;
		}
		if (banType >= BanType.UserId)
		{
			RemoveBan(ban.Id, banType, forced: true);
		}
		return false;
	}

	public static BanDetails ReturnChecks(BanDetails ban, BanType banType)
	{
		if (!CheckExpiration(ban, banType))
		{
			return null;
		}
		return ban;
	}

	public static void RemoveBan(string id, BanType banType, bool forced = false)
	{
		BanRevokingEventArgs e = new BanRevokingEventArgs(banType, GetBan(id, banType));
		ServerEvents.OnBanRevoking(e);
		if (forced || e.IsAllowed)
		{
			id = id.Replace(";", ":").Replace(Environment.NewLine, "").Replace("\n", "");
			FileManager.WriteToFile((from l in FileManager.ReadAllLines(GetPath(banType))
				where ProcessBanItem(l, banType) != null && ProcessBanItem(l, banType).Id != id
				select l).ToArray(), GetPath(banType));
			ServerEvents.OnBanRevoked(new BanRevokedEventArgs(banType, e.BanDetails));
		}
	}

	public static List<BanDetails> GetBans(BanType banType)
	{
		return (from b in FileManager.ReadAllLines(GetPath(banType))
			select ProcessBanItem(b, banType) into b
			where b != null
			select b).ToList();
	}

	public static BanDetails GetBan(string id, BanType banType)
	{
		return GetBans(banType).FirstOrDefault((BanDetails s) => string.Equals(s.Id, id, StringComparison.OrdinalIgnoreCase));
	}

	public static KeyValuePair<BanDetails, BanDetails> QueryBan(string userId, string ip)
	{
		string ban = null;
		string ban2 = null;
		if (!string.IsNullOrEmpty(userId))
		{
			userId = userId.Replace(";", ":").Replace(Environment.NewLine, "").Replace("\n", "");
			ban = FileManager.ReadAllLines(GetPath(BanType.UserId)).FirstOrDefault((string b) => ProcessBanItem(b, BanType.UserId)?.Id == userId);
		}
		if (!string.IsNullOrEmpty(ip))
		{
			ip = ip.Replace(";", ":").Replace(Environment.NewLine, "").Replace("\n", "");
			ban2 = FileManager.ReadAllLines(GetPath(BanType.IP)).FirstOrDefault((string b) => ProcessBanItem(b, BanType.IP)?.Id == ip);
		}
		return new KeyValuePair<BanDetails, BanDetails>(ReturnChecks(ProcessBanItem(ban, BanType.UserId), BanType.UserId), ReturnChecks(ProcessBanItem(ban2, BanType.IP), BanType.IP));
	}

	public static BanDetails ProcessBanItem(string ban, BanType banType)
	{
		if (string.IsNullOrEmpty(ban) || !ban.Contains(";"))
		{
			return null;
		}
		string[] array = ban.Split(';');
		if (array.Length != 6)
		{
			return null;
		}
		if (banType == BanType.UserId && !array[1].Contains("@"))
		{
			array[1] = array[1].Trim() + "@steam";
		}
		return new BanDetails
		{
			OriginalName = array[0],
			Id = array[1].Trim(),
			Expires = Convert.ToInt64(array[2].Trim()),
			Reason = array[3],
			Issuer = array[4],
			IssuanceTime = Convert.ToInt64(array[5].Trim())
		};
	}

	public static string GetPath(BanType banType)
	{
		if (banType != BanType.UserId && banType == BanType.IP)
		{
			return ConfigSharing.Paths[0] + "IpBans.txt";
		}
		return ConfigSharing.Paths[0] + "UserIdBans.txt";
	}
}

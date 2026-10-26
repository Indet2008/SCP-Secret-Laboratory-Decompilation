using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using GameCore;

namespace PlayerRoles.RoleAssign
{
	public class ScpTicketsLoader : IDisposable
	{
		private class TicketEntry
		{
			public string UserId;

			public int Tickets;

			public long LastUpdate;
		}

		private static readonly List<TicketEntry> AllEntries = new List<TicketEntry>(65535);

		private static readonly Dictionary<ReferenceHub, TicketEntry> EntriesByUser = new Dictionary<ReferenceHub, TicketEntry>();

		private static readonly Dictionary<int, List<ReferenceHub>> PlayersByIdHash = new Dictionary<int, List<ReferenceHub>>();

		private static bool _isBusy;

		private const string Filename = "ScpTickets.txt";

		private const int ExpectedCapacity = 65535;

		private const int ExpirationTime = 1296000;

		private const char Separator = ';';

		private static string FilePath => ConfigSharing.Paths[6] + "ScpTickets.txt";

		private static long UnixTimeNow => DateTimeOffset.Now.ToUnixTimeSeconds();

		public ScpTicketsLoader()
		{
			if (_isBusy)
			{
				throw new InvalidOperationException("Unable to load SCP ticket entries. Another ScpTicketsLoader is active or undisposed.");
			}
			_isBusy = true;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				string userId = allHub.authManager.UserId;
				if (!string.IsNullOrEmpty(userId))
				{
					PlayersByIdHash.GetOrAdd(userId.GetHashCode(), () => new List<ReferenceHub>()).Add(allHub);
				}
			}
			LoadEntries();
		}

		public int GetTickets(ReferenceHub hub, int defaultNumber, bool ignoreOptOut = false)
		{
			if (!ignoreOptOut && ScpPlayerPicker.IsOptedOutOfScp(hub))
			{
				return 0;
			}
			if (!EntriesByUser.TryGetValue(hub, out var value))
			{
				return defaultNumber;
			}
			return value.Tickets;
		}

		public void ModifyTickets(ReferenceHub hub, int newNumber)
		{
			if (EntriesByUser.TryGetValue(hub, out var value))
			{
				value.LastUpdate = UnixTimeNow;
				value.Tickets = newNumber;
				return;
			}
			TicketEntry ticketEntry = new TicketEntry
			{
				UserId = hub.authManager.UserId,
				LastUpdate = UnixTimeNow,
				Tickets = newNumber
			};
			AllEntries.Add(ticketEntry);
			EntriesByUser.Add(hub, ticketEntry);
		}

		public void Dispose()
		{
			SaveEntries();
			AllEntries.Clear();
			EntriesByUser.Clear();
			PlayersByIdHash.Clear();
			_isBusy = false;
		}

		private static void SaveEntries()
		{
			FileManager.WriteToFile(AllEntries.Select(SerializeEntry), FilePath);
		}

		private static void LoadEntries()
		{
			if (!File.Exists(FilePath))
			{
				return;
			}
			long unixTimeNow = UnixTimeNow;
			using FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read, FileShare.Read);
			using StreamReader streamReader = new StreamReader(stream);
			while (true)
			{
				string text = streamReader.ReadLine();
				if (text == null)
				{
					break;
				}
				if (TryDeserialize(text, out var entry) && entry.LastUpdate + 1296000 >= unixTimeNow)
				{
					AddEntry(entry);
				}
			}
		}

		private static void AddEntry(TicketEntry entry)
		{
			AllEntries.Add(entry);
			int hashCode = entry.UserId.GetHashCode();
			if (!PlayersByIdHash.TryGetValue(hashCode, out var value))
			{
				return;
			}
			foreach (ReferenceHub item in value)
			{
				if (!(item.authManager.UserId != entry.UserId))
				{
					EntriesByUser[item] = entry;
				}
			}
		}

		private static string SerializeEntry(TicketEntry entry)
		{
			return entry.UserId + ';' + entry.Tickets + ';' + entry.LastUpdate;
		}

		private static bool TryDeserialize(string text, out TicketEntry entry)
		{
			entry = null;
			if (string.IsNullOrEmpty(text))
			{
				return false;
			}
			string[] array = text.Split(';');
			if (array.Length != 3)
			{
				return false;
			}
			if (!int.TryParse(array[1], out var result))
			{
				return false;
			}
			if (!long.TryParse(array[2], out var result2))
			{
				return false;
			}
			entry = new TicketEntry
			{
				UserId = array[0],
				Tickets = result,
				LastUpdate = result2
			};
			return true;
		}
	}
}

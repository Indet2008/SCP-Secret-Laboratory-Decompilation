using System;
using System.Diagnostics;
using Mirror;
using PlayerRoles;
using Respawning.NamingRules;

namespace Footprinting
{
	public readonly struct Footprint : IEquatable<Footprint>
	{
		public readonly ReferenceHub Hub;

		public readonly bool IsSet;

		public readonly int PlayerId;

		public readonly uint NetId;

		public readonly int LifeIdentifier;

		public readonly RoleTypeId Role;

		public readonly byte Unit;

		public readonly string Nickname;

		public readonly string LogUserID;

		public readonly Stopwatch Stopwatch;

		public readonly bool BypassStaff;

		public readonly string IpAddress;

		private readonly int _serial;

		private static int _serialClock;

		public string UnitName
		{
			get
			{
				if (!Role.TryGetRoleTemplate<HumanRole>(out var result))
				{
					return string.Empty;
				}
				if (!NamingRulesManager.GeneratedNames.TryGetValue(result.Team, out var value))
				{
					return string.Empty;
				}
				int count = value.Count;
				if (Unit >= count)
				{
					return string.Empty;
				}
				return value[Unit];
			}
		}

		public Footprint(ReferenceHub hub)
		{
			IsSet = true;
			Stopwatch = Stopwatch.StartNew();
			bool flag = hub != null;
			Hub = (flag ? hub : null);
			PlayerId = (flag ? hub.PlayerId : 0);
			NetId = (flag ? hub.networkIdentity.netId : 0u);
			Role = (flag ? hub.GetRoleId() : RoleTypeId.None);
			Unit = (byte)((flag && hub.roleManager.CurrentRole is HumanRole humanRole) ? humanRole.UnitNameId : 0);
			LogUserID = (flag ? hub.authManager.UserId : string.Empty);
			Nickname = (flag ? hub.nicknameSync.MyNick : "(null)");
			BypassStaff = flag && hub.authManager.BypassBansFlagSet;
			IpAddress = ((!flag || !NetworkServer.active || hub.connectionToClient == null) ? null : hub.connectionToClient.address);
			LifeIdentifier = (flag ? hub.roleManager.CurrentRole.UniqueLifeIdentifier : 0);
			if (!flag)
			{
				_serial = 0;
				return;
			}
			if (++_serialClock == 0)
			{
				_serialClock++;
			}
			_serial = _serialClock;
		}

		public bool Equals(Footprint other)
		{
			if (IsSet == other.IsSet)
			{
				return _serial == other._serial;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return _serial;
		}
	}
}

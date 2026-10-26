using System;
using Mirror;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079ScannerTeamFilterSelector : Scp079AbilityBase
	{
		[SerializeField]
		private Team[] _availableFilters;

		private bool[] _selectedTeams;

		private Team[] _tempTeams;

		public Team[] SelectedTeams
		{
			get
			{
				if (_tempTeams == null)
				{
					_tempTeams = new Team[_availableFilters.Length];
				}
				int num = 0;
				for (int i = 0; i < _availableFilters.Length; i++)
				{
					if (_selectedTeams[i])
					{
						_tempTeams[num++] = _availableFilters[i];
					}
				}
				Team[] array = new Team[num];
				Array.Copy(_tempTeams, array, num);
				return array;
			}
		}

		public bool AnySelected
		{
			get
			{
				bool[] selectedTeams = _selectedTeams;
				for (int i = 0; i < selectedTeams.Length; i++)
				{
					if (selectedTeams[i])
					{
						return true;
					}
				}
				return false;
			}
		}

		private int GetTeamIndex(Team team)
		{
			for (int i = 0; i < _availableFilters.Length; i++)
			{
				if (_availableFilters[i] == team)
				{
					return i;
				}
			}
			throw new ArgumentOutOfRangeException($"Team {team} is not a whitelisted breach scanner team");
		}

		private void ResetArray()
		{
			int num = _availableFilters.Length;
			if (_selectedTeams == null)
			{
				_selectedTeams = new bool[num];
			}
			for (int i = 0; i < num; i++)
			{
				_selectedTeams[i] = true;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			ResetArray();
		}

		public bool GetTeamStatus(Team team)
		{
			return _selectedTeams[GetTeamIndex(team)];
		}

		public void SetTeamStatus(Team team, bool status)
		{
			_selectedTeams[GetTeamIndex(team)] = status;
			ClientSendCmd();
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteBoolArray(_selectedTeams);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			reader.ReadBoolArray(_selectedTeams);
			ServerSendRpc(toAll: true);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBoolArray(_selectedTeams);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (!base.Role.IsLocalPlayer)
			{
				reader.ReadBoolArray(_selectedTeams);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			ResetArray();
		}
	}
}

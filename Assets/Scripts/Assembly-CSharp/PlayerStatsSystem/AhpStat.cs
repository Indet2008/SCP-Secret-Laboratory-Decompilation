using System.Collections.Generic;
using System.Linq;
using Mirror;
using NorthwoodLib.Pools;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class AhpStat : SyncedStatBase
	{
		public const float DefaultMax = 75f;

		public const float DefaultEfficacy = 0.7f;

		public const float DefaultDecay = 1.2f;

		private readonly List<AhpProcess> _activeProcesses = new List<AhpProcess>();

		private float _maxSoFar;

		public override SyncMode Mode => SyncMode.PrivateAndSpectators;

		public override float MinValue => 0f;

		public override float MaxValue
		{
			get
			{
				return _maxSoFar;
			}
			set
			{
				if (value != _maxSoFar)
				{
					_maxSoFar = value;
					MaxValueDirty = true;
				}
			}
		}

		internal override void ClassChanged()
		{
			_maxSoFar = 75f;
			if (NetworkServer.active)
			{
				_activeProcesses.Clear();
			}
		}

		internal override void Update()
		{
			base.Update();
			if (NetworkServer.active)
			{
				ServerUpdateProcesses();
			}
		}

		public override float ReadValue(SyncedStatMessages.StatMessageType type, NetworkReader reader)
		{
			return (int)reader.ReadUShort();
		}

		public override void WriteValue(SyncedStatMessages.StatMessageType type, NetworkWriter writer)
		{
			int num = ((type == SyncedStatMessages.StatMessageType.CurrentValue) ? Mathf.Clamp(Mathf.CeilToInt(CurValue), 0, 65535) : Mathf.Clamp(Mathf.CeilToInt(MaxValue), 0, 65535));
			writer.WriteUShort((ushort)num);
		}

		public override bool CheckDirty(float prevValue, float newValue)
		{
			return Mathf.CeilToInt(prevValue) != Mathf.CeilToInt(newValue);
		}

		public AhpProcess ServerAddProcess(float amount, float limit, float decay, float efficacy, float sustain, bool persistant)
		{
			float num = 0f;
			float num2 = limit;
			foreach (AhpProcess activeProcess in _activeProcesses)
			{
				num += activeProcess.CurrentAmount;
				num2 = Mathf.Max(num2, activeProcess.Limit);
			}
			float num3 = num + amount - num2;
			if (num3 > 0f)
			{
				amount = Mathf.Max(0f, amount - num3);
			}
			AhpProcess ahpProcess = new AhpProcess(amount, limit, decay, efficacy, sustain, persistant);
			for (int i = 0; i < _activeProcesses.Count; i++)
			{
				if (!(efficacy < _activeProcesses[i].Efficacy))
				{
					_activeProcesses.Insert(i, ahpProcess);
					ServerUpdateProcesses(removeInactive: false);
					return ahpProcess;
				}
			}
			_activeProcesses.Add(ahpProcess);
			ServerUpdateProcesses(removeInactive: false);
			return ahpProcess;
		}

		public AhpProcess ServerAddProcess(IAhpProcess process)
		{
			return ServerAddProcess(process.CurrentAmount, process.Limit, process.DecayRate, process.Efficacy, process.SustainTime, process.Persistant);
		}

		public AhpProcess ServerAddProcess(float amount)
		{
			return ServerAddProcess(amount, MaxValue, 1.2f, 0.7f, 0f, persistant: false);
		}

		public bool ServerTryGetProcess(int killcode, out AhpProcess process)
		{
			foreach (AhpProcess activeProcess in _activeProcesses)
			{
				if (activeProcess.KillCode == killcode)
				{
					process = activeProcess;
					return true;
				}
			}
			process = null;
			return false;
		}

		public bool ServerKillProcess(int killcode)
		{
			if (ServerTryGetProcess(killcode, out var process))
			{
				return _activeProcesses.Remove(process);
			}
			return false;
		}

		public void ServerKillAllProcesses()
		{
			_activeProcesses.Clear();
		}

		public float ServerProcessDamage(float damage)
		{
			if (damage <= 0f)
			{
				return damage;
			}
			foreach (AhpProcess activeProcess in _activeProcesses)
			{
				float num = damage * activeProcess.Efficacy;
				if (num >= activeProcess.CurrentAmount)
				{
					damage -= activeProcess.CurrentAmount;
					activeProcess.CurrentAmount = 0f;
					continue;
				}
				activeProcess.CurrentAmount -= num;
				return damage - num;
			}
			ServerUpdateProcesses(removeInactive: false);
			return damage;
		}

		public void ServerAddProcessValue(float value)
		{
			if (value <= 0f)
			{
				return;
			}
			foreach (AhpProcess activeProcess in _activeProcesses)
			{
				if (value <= 0f)
				{
					break;
				}
				float num = activeProcess.Limit - activeProcess.CurrentAmount;
				float num2 = ((value > num) ? num : value);
				value -= num2;
				activeProcess.CurrentAmount += num2;
			}
			ServerUpdateProcesses(removeInactive: false);
		}

		public void ServerUpdateProcesses(bool removeInactive = true, bool updateCurValue = true)
		{
			float num = MaxValue;
			float num2 = 0f;
			List<int> list = ListPool<int>.Shared.Rent();
			for (int i = 0; i < _activeProcesses.Count; i++)
			{
				AhpProcess ahpProcess = _activeProcesses[i];
				num2 += ahpProcess.CurrentAmount;
				num = Mathf.Max(num, ahpProcess.Limit);
				if (ahpProcess.SustainTime > 0f)
				{
					ahpProcess.SustainTime -= Time.deltaTime;
					continue;
				}
				ahpProcess.CurrentAmount = Mathf.Clamp(ahpProcess.CurrentAmount - ahpProcess.DecayRate * Time.deltaTime, 0f, ahpProcess.Limit);
				if (ahpProcess.CurrentAmount == 0f && !ahpProcess.Persistant)
				{
					list.Add(i - list.Count);
				}
			}
			if (removeInactive)
			{
				foreach (int item in list)
				{
					_activeProcesses.RemoveAt(item);
				}
			}
			ListPool<int>.Shared.Return(list);
			if (updateCurValue)
			{
				CurValue = Mathf.Clamp(num2, MinValue, num);
			}
		}

		public IEnumerable<AhpProcessSnapshot> GenerateSnapshots()
		{
			return _activeProcesses.Select((AhpProcess p) => p.CreateSnapshot());
		}

		public void FillSnapshots(List<AhpProcessSnapshot> snapshots)
		{
			snapshots.Clear();
			snapshots.AddRange(GenerateSnapshots());
		}
	}
}

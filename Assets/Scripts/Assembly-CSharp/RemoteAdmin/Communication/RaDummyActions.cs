using System;
using System.Collections.Generic;
using NetworkManagerUtils.Dummies;
using UnityEngine;

namespace RemoteAdmin.Communication
{
	public class RaDummyActions : RaClientDataRequest
	{
		private class DummyData
		{
			private int _groupsLen;

			private ActionsGroupPair[] _groups;

			private const int InitialGroupSize = 16;

			private const string InitialGroupName = "Miscellaneous";

			public ReadOnlySpan<ActionsGroupPair> Groups => new ReadOnlySpan<ActionsGroupPair>(_groups, 0, _groupsLen);

			private ActionsGroupPair CurGroup
			{
				get
				{
					EnsureCapacity(_groupsLen);
					int num = Mathf.Max(0, _groupsLen - 1);
					return _groups[num];
				}
			}

			private void EnsureCapacity(int minLen)
			{
				if (_groups == null)
				{
					int num = Mathf.Max(minLen * 2, 16);
					_groups = new ActionsGroupPair[num];
				}
				else if (_groups.Length < minLen)
				{
					Array.Resize(ref _groups, minLen * 2);
				}
				for (int i = 0; i < _groups.Length; i++)
				{
					ActionsGroupPair[] groups = _groups;
					int num2 = i;
					if (groups[num2] == null)
					{
						groups[num2] = new ActionsGroupPair("Miscellaneous");
					}
				}
			}

			public void Clear()
			{
				if (_groups != null)
				{
					for (int i = 0; i < _groupsLen; i++)
					{
						ActionsGroupPair obj = _groups[i];
						obj.Name = "Miscellaneous";
						obj.Actions.Clear();
					}
				}
				_groupsLen = 0;
			}

			public void Receive(string word)
			{
				if (word.StartsWith("___"))
				{
					_groupsLen++;
					ActionsGroupPair curGroup = CurGroup;
					int length = "___".Length;
					curGroup.Name = word.Substring(length, word.Length - length);
				}
				else
				{
					CurGroup.Actions.Add(word);
				}
			}
		}

		private class ActionsGroupPair
		{
			public string Name;

			public readonly List<string> Actions;

			public ActionsGroupPair(string name)
			{
				Name = name;
				Actions = new List<string>();
			}
		}

		private const string GroupPrefix = "___";

		private const string DummyIdPrefix = "***";

		private static readonly Dictionary<uint, HashSet<uint>> NonDirtyReceivers = new Dictionary<uint, HashSet<uint>>();

		private static readonly Dictionary<uint, DummyData> ReceivedData = new Dictionary<uint, DummyData>();

		private uint _senderNetId;

		public string LastError { get; private set; }

		public override int DataId => 9;

		public void GetData(List<string> groupList, List<string> actionList, string selectedGroup)
		{
			groupList.Clear();
			actionList.Clear();
			HashSet<string> hashSet = NorthwoodLib.Pools.HashSetPool<string>.Shared.Rent();
			HashSet<string> hashSet2 = NorthwoodLib.Pools.HashSetPool<string>.Shared.Rent();
			foreach (PlayerRecord instance in PlayerRecord.Instances)
			{
				if (!TryGetDummyDataFromRecord(instance, out var ret))
				{
					continue;
				}
				ReadOnlySpan<ActionsGroupPair> groups = ret.Groups;
				for (int i = 0; i < groups.Length; i++)
				{
					ActionsGroupPair actionsGroupPair = groups[i];
					AddUnique(groupList, hashSet, actionsGroupPair.Name);
					if (!(actionsGroupPair.Name != selectedGroup))
					{
						foreach (string action in actionsGroupPair.Actions)
						{
							AddUnique(actionList, hashSet2, action);
						}
					}
				}
			}
			NorthwoodLib.Pools.HashSetPool<string>.Shared.Return(hashSet);
			NorthwoodLib.Pools.HashSetPool<string>.Shared.Return(hashSet2);
			static void AddUnique(List<string> list, HashSet<string> set, string item)
			{
				if (set.Add(item))
				{
					list.Add(item);
				}
			}
		}

		private bool TryGetDummyDataFromRecord(PlayerRecord record, out DummyData ret)
		{
			ret = null;
			if (record == null || !record.IsSelected || !int.TryParse(record.PlayerId, out var result) || !ReferenceHub.TryGetHub(result, out var hub))
			{
				return false;
			}
			return ReceivedData.TryGetValue(hub.netId, out ret);
		}

		// Collects the group/action layout received for a dummy; groups keep server order.
		public static bool TryGetReceivedActions(uint dummyNetId, List<KeyValuePair<string, List<string>>> result)
		{
			result.Clear();
			if (!ReceivedData.TryGetValue(dummyNetId, out var value))
			{
				return false;
			}
			ReadOnlySpan<ActionsGroupPair> groups = value.Groups;
			for (int i = 0; i < groups.Length; i++)
			{
				result.Add(new KeyValuePair<string, List<string>>(groups[i].Name, new List<string>(groups[i].Actions)));
			}
			return true;
		}

		public override void ReceiveData(string data, bool secure)
		{
			base.ReceiveData(data, secure);
			LastError = null;
			try
			{
				int num = data.IndexOf("***");
				string text = data.Substring(num, data.Length - num);
				ClientReceive(text.Split(','));
			}
			catch (Exception ex)
			{
				LastError = ex.Message;
			}
		}

		public override void ReceiveData(CommandSender sender, string data)
		{
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				base.ReceiveData(sender, data);
				return;
			}
			bool flag = false;
			_senderNetId = playerCommandSender.ReferenceHub.netId;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsDummy)
				{
					HashSet<uint> orAddNew = NonDirtyReceivers.GetOrAddNew(allHub.netId);
					if (DummyActionCollector.IsDirty(allHub))
					{
						orAddNew.Clear();
						flag = true;
					}
					else if (!orAddNew.Contains(_senderNetId))
					{
						flag = true;
					}
				}
			}
			if (flag)
			{
				base.ReceiveData(sender, data);
			}
		}

		protected override void GatherData()
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsDummy && !NonDirtyReceivers.GetOrAddNew(allHub.netId).Contains(_senderNetId))
				{
					AppendDummy(allHub);
				}
			}
		}

		private void AppendDummy(ReferenceHub dummy)
		{
			AppendData("***" + dummy.netId);
			foreach (DummyAction item in DummyActionCollector.ServerGetActions(dummy))
			{
				if (item.Action == null)
				{
					AppendData("___" + item.Name);
				}
				else
				{
					AppendData(item.Name);
				}
			}
		}

		private void ClientReceive(string[] words)
		{
			DummyData dummyData = null;
			foreach (string text in words)
			{
				if (string.IsNullOrEmpty(text))
				{
					continue;
				}
				if (text.StartsWith("***"))
				{
					string text2 = text;
					int length = "***".Length;
					string s = text2.Substring(length, text2.Length - length);
					dummyData = ReceivedData.GetOrAdd(uint.Parse(s), () => new DummyData());
					dummyData.Clear();
				}
				else
				{
					dummyData.Receive(text);
				}
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += OnClientReady;
		}

		private static void OnClientReady()
		{
			NonDirtyReceivers.Clear();
			ReceivedData.Clear();
		}
	}
}

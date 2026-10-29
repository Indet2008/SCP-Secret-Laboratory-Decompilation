using System;
using System.Collections.Generic;
using GameCore;
using InventorySystem.Searching;
using Mirror;
using TMPro;
using UnityEngine;

namespace Hints
{
	[RequireComponent(typeof(SearchCoordinator))]
	public class HintDisplay : NetworkBehaviour
	{
		private SharedHintData _sharedData;

		private Stack<Hint> _hints;

		private TextMeshProUGUI _textbox;

		public static readonly HashSet<NetworkConnection> SuppressedReceivers = new HashSet<NetworkConnection>();

		public Hint ActiveHint { get; private set; }

		private void Start()
		{
			if (base.isLocalPlayer)
			{
				_hints = new Stack<Hint>();
				_textbox = UserMainInterface.singleton.hintText;
				_sharedData = new SharedHintData(base.gameObject, _textbox);
				NetworkClient.ReplaceHandler<HintMessage>(ShowLocal);
			}
		}

		private void Update()
		{
			if (base.isLocalPlayer && ActiveHint != null && !(ActiveHint.Update(Time.time) < 1f))
			{
				ActiveHint.Dispose();
				PopHint();
			}
		}

		private void PushHint(Hint hint)
		{
			_hints.Push(hint);
			ActiveHint = hint;
		}

		private void PopHint()
		{
			ActiveHint = (_hints.Count > 0) ? _hints.Pop() : null;
		}

		private void ShowLocal(Hint hint)
		{
			if (hint == null)
			{
				GameCore.Console.AddLog("Attempted to display an empty hint!", Color.red, nospace: false, ConsoleLogType.Error);
				return;
			}
			hint.Awake(_sharedData);
			PushHint(hint);
		}

		private void ShowLocal(HintMessage message)
		{
			ShowLocal(message.Content);
		}

		public void Show(Hint hint)
		{
			if (hint == null)
			{
				throw new ArgumentNullException("hint");
			}
			if (base.isLocalPlayer)
			{
				ShowLocal(hint);
			}
			else if (NetworkServer.active)
			{
				NetworkConnection networkConnection = base.netIdentity.connectionToClient;
				if (!SuppressedReceivers.Contains(networkConnection))
				{
					networkConnection.Send(new HintMessage(hint));
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

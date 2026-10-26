using System;
using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Keycards.Snake;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class ChaosKeycardItem : KeycardItem, IItemAlertDrawer, IItemDrawer
	{
		private enum ChaosMsgType
		{
			SnakeMsgSync = 0,
			NewConnectionFullSync = 1,
			MovementSwitch = 2,
			UseDetails = 3
		}

		public static readonly Dictionary<ushort, SnakeEngine> SnakeSessions = new Dictionary<ushort, SnakeEngine>();

		private static SnakeNetworkMessage _msgToSend;

		private static ChaosKeycardItem _selfTemplate;

		private SnakeEngine _localEngine;

		private float _remainingMoveCooldown;

		private float _snakeHintElapsed;

		private float _snakeHintFade;

		private string _snakeHintFormat;

		private object[] _snakeHintFormatContent;

		[SerializeField]
		private int _snakeStartLength;

		[SerializeField]
		private byte _snakeMaxLength;

		[SerializeField]
		private float _hintFadeSpeed;

		[SerializeField]
		private float _hintDuration;

		[SerializeField]
		private float _hintDurationAfterInteract;

		[SerializeField]
		private Vector2Int _snakeAreaSize;

		[SerializeField]
		private float _snakeGameoverTime;

		[SerializeField]
		private AnimationCurve _moveCooldownOverScore;

		public AlertContent Alert
		{
			get
			{
				if (_snakeHintFade <= 0f)
				{
					return default;
				}
				if (_snakeHintFormat == null)
				{
					_snakeHintFormat = Translations.Get(InventoryGuiTranslation.SnakeHint);
				}
				if (_snakeHintFormatContent == null)
				{
					_snakeHintFormatContent = new object[4];
				}
				_snakeHintFormatContent[0] = new ReadableKeyCode(ActionName.MoveForward);
				_snakeHintFormatContent[1] = new ReadableKeyCode(ActionName.MoveLeft);
				_snakeHintFormatContent[2] = new ReadableKeyCode(ActionName.MoveBackward);
				_snakeHintFormatContent[3] = new ReadableKeyCode(ActionName.MoveRight);
				return new AlertContent(string.Format(_snakeHintFormat, _snakeHintFormatContent), _snakeHintFade);
			}
		}

		public static event Action<ushort?, Vector2Int> OnSnakeMovementDirChanged;

		public static event Action<ushort, DoorPermissionFlags, string> OnDetailedUse;

		protected override void ClientProcessCustomRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessCustomRpcTemplate(reader, serial);
			switch ((ChaosMsgType)reader.ReadByte())
			{
			case ChaosMsgType.SnakeMsgSync:
				GetEngineForSerial(serial).ProcessMessage(new SnakeNetworkMessage(reader));
				break;
			case ChaosMsgType.NewConnectionFullSync:
				SnakeSessions.Clear();
				while (reader.Remaining > 0)
				{
					GetEngineForSerial(reader.ReadUShort()).ProcessMessage(new SnakeNetworkMessage(reader));
				}
				break;
			case ChaosMsgType.MovementSwitch:
			{
				float x = Mathf.Sign(reader.ReadSByte());
				float y = Mathf.Sign(reader.ReadSByte());
				Vector2Int arg3 = Vector2Int.CeilToInt(new Vector2(x, y));
				OnSnakeMovementDirChanged?.Invoke(serial, arg3);
				break;
			}
			case ChaosMsgType.UseDetails:
			{
				DoorPermissionFlags arg = (DoorPermissionFlags)reader.ReadUShort();
				string arg2 = reader.ReadString();
				OnDetailedUse?.Invoke(serial, arg, arg2);
				break;
			}
			}
		}

		protected override void ServerProcessCustomCmd(NetworkReader reader)
		{
			base.ServerProcessCustomCmd(reader);
			switch ((ChaosMsgType)reader.ReadByte())
			{
			case ChaosMsgType.SnakeMsgSync:
			{
				SnakeNetworkMessage msg = new SnakeNetworkMessage(reader);
				if (msg.HasFlag(SnakeNetworkMessage.SyncFlags.Delta))
				{
					ServerSendMessage(msg);
				}
				break;
			}
			case ChaosMsgType.MovementSwitch:
			{
				sbyte x = reader.ReadSByte();
				sbyte y = reader.ReadSByte();
				ServerSendPublicRpc((NetworkWriter writer) =>
				{
					writer.WriteSubheader(MsgType.Custom);
					writer.WriteSubheader(ChaosMsgType.MovementSwitch);
					writer.WriteSByte(x);
					writer.WriteSByte(y);
				});
				break;
			}
			}
		}

		protected override void ServerOnNewPlayerConnected(ReferenceHub hub)
		{
			base.ServerOnNewPlayerConnected(hub);
			ServerSendTargetRpc(hub, (NetworkWriter writer) =>
			{
				writer.WriteSubheader(MsgType.Custom);
				writer.WriteSubheader(ChaosMsgType.NewConnectionFullSync);
				foreach (KeyValuePair<ushort, SnakeEngine> snakeSession in SnakeSessions)
				{
					writer.WriteUShort(snakeSession.Key);
					snakeSession.Value.WriteFullResyncMessage(writer);
				}
			});
		}

		protected override void OnUsed(IDoorPermissionRequester requester, bool success)
		{
			base.OnUsed(requester, success);
			ServerSendPublicRpc((NetworkWriter x) =>
			{
				x.WriteSubheader(MsgType.Custom);
				x.WriteSubheader(ChaosMsgType.UseDetails);
				x.WriteUShort((ushort)requester.PermissionsPolicy.RequiredPermissions);
				x.WriteString(requester.RequesterLogSignature);
			});
		}

		internal override void OnTemplateReloaded(bool wasEverLoaded)
		{
			base.OnTemplateReloaded(wasEverLoaded);
			_selfTemplate = this;
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			if (base.IsControllable)
			{
				_localEngine = GetNewEngine(isLocalClient: true);
				SnakeSessions[base.ItemSerial] = _localEngine;
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			SnakeSessions.Remove(base.ItemSerial);
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (!base.IsControllable)
			{
				return;
			}
			if (UpdateSnake())
			{
				_snakeHintElapsed += Time.deltaTime;
				UpdateHint(_snakeHintElapsed < _hintDuration);
				return;
			}
			if (_snakeHintElapsed < _hintDuration)
			{
				_snakeHintElapsed = 0f;
			}
			UpdateHint(targetVisible: false);
		}

		private bool UpdateSnake()
		{
			if (!KeycardItem.StartInspectTimes.TryGetValue(base.ItemSerial, out var value))
			{
				return false;
			}
			if (NetworkTime.time - value < 1.7000000476837158)
			{
				return true;
			}
			UpdateInput(KeyCode.UpArrow, ActionName.MoveForward, Vector2Int.up);
			UpdateInput(KeyCode.DownArrow, ActionName.MoveBackward, Vector2Int.down);
			UpdateInput(KeyCode.LeftArrow, ActionName.MoveLeft, Vector2Int.left);
			UpdateInput(KeyCode.RightArrow, ActionName.MoveRight, Vector2Int.right);
			if (_remainingMoveCooldown > 0f)
			{
				_remainingMoveCooldown -= Time.deltaTime;
			}
			else
			{
				_localEngine.Move();
				_remainingMoveCooldown = _moveCooldownOverScore.Evaluate(_localEngine.Score);
			}
			return true;
		}

		private void UpdateInput(KeyCode kc, ActionName action, Vector2Int input)
		{
			if ((GetActionDown(action) || Input.GetKeyDown(kc)) && _localEngine.ProvideInput(input))
			{
				ClientSendCmd((NetworkWriter writer) =>
				{
					writer.WriteSubheader(MsgType.Custom);
					writer.WriteSubheader(ChaosMsgType.MovementSwitch);
					writer.WriteSByte((sbyte)input.x);
					writer.WriteSByte((sbyte)input.y);
				});
				_hintDuration = _hintDurationAfterInteract;
				OnSnakeMovementDirChanged?.Invoke(null, input);
			}
		}

		private void UpdateHint(bool targetVisible)
		{
			_snakeHintFade = Mathf.MoveTowards(_snakeHintFade, targetVisible ? 1 : 0, Time.deltaTime * _hintFadeSpeed);
		}

		private void ServerSendMessage(SnakeNetworkMessage msg)
		{
			_msgToSend = msg;
			ServerSendPublicRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(MsgType.Custom);
				writer.WriteSubheader(ChaosMsgType.SnakeMsgSync);
				_msgToSend.WriteSelf(writer);
			});
		}

		private void ClientSendMessage(SnakeNetworkMessage msg)
		{
			_msgToSend = msg;
			ClientSendCmd((NetworkWriter writer) =>
			{
				writer.WriteSubheader(MsgType.Custom);
				writer.WriteSubheader(ChaosMsgType.SnakeMsgSync);
				_msgToSend.WriteSelf(writer);
			});
		}

		private SnakeEngine GetNewEngine(bool isLocalClient)
		{
			return new SnakeEngine(_snakeAreaSize / 2, _snakeStartLength, _snakeMaxLength, _snakeAreaSize, _snakeGameoverTime, isLocalClient ? new Action<SnakeNetworkMessage>(ClientSendMessage) : null);
		}

		private static SnakeEngine GetEngineForSerial(ushort serial)
		{
			return SnakeSessions.GetOrAdd(serial, () => _selfTemplate.GetNewEngine(isLocalClient: false));
		}
	}
}

using System;
using System.Linq;
using System.Runtime.InteropServices;
using Mirror;
using PlayerRoles.FirstPersonControl;
using TMPro;
using UnityEngine;

namespace AdminToys
{
	public class TextToy : AdminToyBase
	{
		public readonly SyncList<string> Arguments = new SyncList<string>();

		[SyncVar(hook = "OnDisplaySizeChanged")]
		private Vector2 _displaySize = DefaultDisplaySize;

		[SyncVar(hook = "OnTextFormatedChanged")]
		private string _textFormat;

		private TMP_Text _textMesh;

		private RectTransform _rectTransform;

		public static Vector2 DefaultDisplaySize => new Vector2(200f, 50f);

		public override string CommandName => "Text";

		public Vector2 DisplaySize
		{
			get
			{
				return _displaySize;
			}
			set
			{
				Network_displaySize = value;
			}
		}

		public string TextFormat
		{
			get
			{
				return _textFormat;
			}
			set
			{
				Network_textFormat = value;
			}
		}

		public Vector2 Network_displaySize
		{
			get
			{
				return _displaySize;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _displaySize, 32uL, OnDisplaySizeChanged);
			}
		}

		public string Network_textFormat
		{
			get
			{
				return _textFormat;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _textFormat, 64uL, OnTextFormatedChanged);
			}
		}

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			base.OnSpawned(admin, arguments);
			Vector3 position;
			Quaternion rotation;
			if (admin.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				position = fpcRole.FpcModule.Position;
				rotation = Quaternion.Euler(0f, fpcRole.FpcModule.MouseLook.CurrentHorizontal, 0f);
			}
			else
			{
				position = admin.transform.position;
				rotation = Quaternion.Euler(0f, admin.transform.rotation.eulerAngles.y, 0f);
			}
			base.transform.SetPositionAndRotation(position, rotation);
			if (arguments.Array.Length > 2)
			{
				TextFormat = string.Join(' ', arguments.Array[2..]);
			}
		}

		public override void OnStartClient()
		{
			base.OnStartClient();
			Arguments.OnModified += RefreshText;
		}

		private void RefreshText()
		{
			if (!(_textMesh == null))
			{
				if (Arguments.Count > 0 && !string.IsNullOrEmpty(TextFormat))
				{
					TMP_Text textMesh = _textMesh;
					string textFormat = TextFormat;
					object[] args = Arguments.ToArray();
					textMesh.SetText(Misc.FormatAvailable(textFormat, args));
				}
				else
				{
					_textMesh.SetText(TextFormat);
				}
			}
		}

		private void Awake()
		{
			if (!NetworkServer.active)
			{
				_textMesh = GetComponentInChildren<TMP_Text>();
				_rectTransform = _textMesh.gameObject.GetComponent<RectTransform>();
			}
		}

		private void OnDisplaySizeChanged(Vector2 oldSize, Vector2 newSize)
		{
			if (!(_rectTransform == null))
			{
				_rectTransform.sizeDelta = newSize;
			}
		}

		private void OnTextFormatedChanged(string oldValue, string newValue)
		{
			RefreshText();
		}

		public TextToy()
		{
			InitSyncObject(Arguments);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteVector2(_displaySize);
				writer.WriteString(_textFormat);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				writer.WriteVector2(_displaySize);
			}
			if ((base.syncVarDirtyBits & 0x40L) != 0L)
			{
				writer.WriteString(_textFormat);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _displaySize, OnDisplaySizeChanged, reader.ReadVector2());
				GeneratedSyncVarDeserialize(ref _textFormat, OnTextFormatedChanged, reader.ReadString());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _displaySize, OnDisplaySizeChanged, reader.ReadVector2());
			}
			if ((num & 0x40L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _textFormat, OnTextFormatedChanged, reader.ReadString());
			}
		}
	}
}

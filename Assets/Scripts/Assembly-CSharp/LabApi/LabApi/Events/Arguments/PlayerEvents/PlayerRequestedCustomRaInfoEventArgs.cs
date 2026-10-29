namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRequestedCustomRaInfoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public const int MaxClipboardCount = 3;

		private string[]? _clipboardTexts;

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public string[] SelectedIdentifiers { get; }

		public bool IsSensitiveInfo { get; }

		public global::System.Text.StringBuilder InfoBuilder { get; }

		public PlayerRequestedCustomRaInfoEventArgs(CommandSender commandSender, global::System.ArraySegment<string> selectionArgs, bool isSensitiveInfo, global::System.Text.StringBuilder infoBuilder)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			SelectedIdentifiers = global::System.Linq.Enumerable.First(selectionArgs).Split(".");
			IsSensitiveInfo = isSensitiveInfo;
			InfoBuilder = infoBuilder;
		}

		public string SetClipboardText(string linkText, string clipboardText, byte id)
		{
			if (id >= 3)
			{
				throw new global::System.ArgumentOutOfRangeException("id", id, $"id must be between 0 and {3}");
			}
			if (_clipboardTexts == null)
			{
				_clipboardTexts = new string[3];
			}
			_clipboardTexts[id] = clipboardText;
			return "<link=" + LinkIdForClipboardId(id) + ">" + linkText + "</link>";
		}

		public bool TryGetClipboardText(byte id, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out string? text)
		{
			if (id >= 3)
			{
				throw new global::System.ArgumentOutOfRangeException("id", id, $"id must be between 0 and {3}");
			}
			text = null;
			if (_clipboardTexts == null)
			{
				return false;
			}
			text = _clipboardTexts[id];
			return !string.IsNullOrEmpty(text);
		}

		private string LinkIdForClipboardId(byte id)
		{
			return id switch
			{
				0 => "CP_ID", 
				1 => "CP_IP", 
				2 => "CP_USERID", 
				_ => throw new global::System.ArgumentOutOfRangeException("id", id, $"id must be between 0 and {3}"), 
			};
		}
	}
}

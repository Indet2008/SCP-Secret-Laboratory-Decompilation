using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace Discord.Basic
{
	public class RichPresence
	{
		private readonly List<IntPtr> _buffers = new List<IntPtr>(10);

		private RichPresenceStruct _presence;

		public string details;

		public long endTimestamp;

		public bool instance;

		public string joinSecret;

		public string largeImageKey;

		public string largeImageText;

		public string matchSecret;

		public string partyId;

		public int partyMax;

		public int partySize;

		public string smallImageKey;

		public string smallImageText;

		public string spectateSecret;

		public long startTimestamp;

		public string state;

		internal RichPresenceStruct GetStruct()
		{
			if (_buffers.Count > 0)
			{
				FreeMem();
			}
			_presence.state = StrToPtr(state);
			_presence.details = StrToPtr(details);
			_presence.startTimestamp = startTimestamp;
			_presence.endTimestamp = endTimestamp;
			_presence.largeImageKey = StrToPtr(largeImageKey);
			_presence.largeImageText = StrToPtr(largeImageText);
			_presence.smallImageKey = StrToPtr(smallImageKey);
			_presence.smallImageText = StrToPtr(smallImageText);
			_presence.partyId = StrToPtr(partyId);
			_presence.partySize = partySize;
			_presence.partyMax = partyMax;
			_presence.matchSecret = StrToPtr(matchSecret);
			_presence.joinSecret = StrToPtr(joinSecret);
			_presence.spectateSecret = StrToPtr(spectateSecret);
			_presence.instance = instance;
			return _presence;
		}

		private IntPtr StrToPtr(string input)
		{
			if (string.IsNullOrEmpty(input))
			{
				return IntPtr.Zero;
			}
			int byteCount = Encoding.UTF8.GetByteCount(input);
			IntPtr intPtr = Marshal.AllocHGlobal(byteCount + 1);
			byte[] bytes = new byte[byteCount + 1];
			Encoding.UTF8.GetBytes(input, 0, input.Length, bytes, 0);
			Marshal.Copy(bytes, 0, intPtr, byteCount + 1);
			_buffers.Add(intPtr);
			return intPtr;
		}

		internal void FreeMem()
		{
			for (int num = _buffers.Count - 1; num >= 0; num--)
			{
				Marshal.FreeHGlobal(_buffers[num]);
				_buffers.RemoveAt(num);
			}
		}
	}
}

using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

namespace GameCore
{
	public static class WindowsCursorApi
	{
		private struct ICONINFO
		{
			public bool FIcon;

			public uint XHotspot;

			public uint YHotspot;

			public IntPtr HbmMask;

			public IntPtr HbmColor;
		}

		private struct BITMAPINFOHEADER
		{
			public uint BiSize;

			public int BiWidth;

			public int BiHeight;

			public ushort BiPlanes;

			public ushort BitBitCount;

			public uint BiCompression;

			public uint BiSizeImage;

			public int BiXPelsPerMeter;

			public int BiYPelsPerMeter;

			public uint BiClrUsed;

			public uint BiClrImportant;
		}

		private struct BITMAPINFO
		{
			public BITMAPINFOHEADER BmiHeader;

			public uint BmiColors;
		}

		private readonly struct CachedCursor
		{
			public readonly Texture2D Texture;

			public readonly Vector2 Hotspot;

			public CachedCursor(Texture2D texture, Vector2 hotspot)
			{
				Texture = texture;
				Hotspot = hotspot;
			}
		}

		private const int SM_CXCURSOR = 13;

		private const int SM_CYCURSOR = 14;

		private const uint DI_NORMAL = 3u;

		private const uint DIB_RGB_COLORS = 0u;

		private static readonly Dictionary<SystemCursorID, CachedCursor> CachedCursors = new Dictionary<SystemCursorID, CachedCursor>();

		public static void SetCursor(SystemCursorID id)
		{
			if (!CachedCursors.TryGetValue(id, out var value))
			{
				Texture2D texture = LoadCursorAsTexture(id, out var hotspot);
				value = new CachedCursor(texture, hotspot);
				CachedCursors.Add(id, value);
			}
			if (value.Texture != null)
			{
				Cursor.SetCursor(value.Texture, value.Hotspot, CursorMode.Auto);
				Cursor.visible = true;
				Cursor.lockState = CursorLockMode.None;
			}
		}

		private unsafe static Texture2D LoadCursorAsTexture(SystemCursorID id, out Vector2 hotspot)
		{
			IntPtr intPtr = LoadCursor(IntPtr.Zero, (int)id);
			hotspot = Vector2.zero;
			if (intPtr == IntPtr.Zero)
			{
				return null;
			}
			intPtr = CopyIcon(intPtr);
			if (!GetIconInfo(intPtr, out var iconInfo))
			{
				return null;
			}
			int systemMetrics = GetSystemMetrics(13);
			int systemMetrics2 = GetSystemMetrics(14);
			hotspot = new Vector2(iconInfo.XHotspot, iconInfo.YHotspot);
			IntPtr hdc = CreateCompatibleDC(IntPtr.Zero);
			BITMAPINFO pbmi = new BITMAPINFO
			{
				BmiHeader = 
				{
					BiSize = (uint)Marshal.SizeOf<BITMAPINFOHEADER>(),
					BiWidth = systemMetrics,
					BiHeight = -systemMetrics2,
					BiPlanes = 1,
					BitBitCount = 32,
					BiCompression = 0u
				}
			};
			IntPtr intPtr2 = CreateDIBSection(hdc, ref pbmi, 0u, out var ppvBits, IntPtr.Zero, 0u);
			IntPtr h = SelectObject(hdc, intPtr2);
			DrawIconEx(hdc, 0, 0, intPtr, systemMetrics, systemMetrics2, 0, IntPtr.Zero, 3u);
			Texture2D texture2D = new Texture2D(systemMetrics, systemMetrics2, TextureFormat.RGBA32, mipChain: false);
			uint* ptr = (uint*)ppvBits.ToPointer();
			Color32[] array = new Color32[systemMetrics * systemMetrics2];
			for (int i = 0; i < systemMetrics2; i++)
			{
				int num = i * systemMetrics;
				for (int j = 0; j < systemMetrics; j++)
				{
					uint num2 = ptr[num + j];
					byte b = (byte)(num2 & 0xFF);
					byte g = (byte)((num2 >> 8) & 0xFF);
					byte r = (byte)((num2 >> 16) & 0xFF);
					byte a = (byte)((num2 >> 24) & 0xFF);
					int num3 = systemMetrics2 - 1 - i;
					array[num3 * systemMetrics + j] = new Color32(r, g, b, a);
				}
			}
			texture2D.SetPixels32(array);
			texture2D.Apply();
			SelectObject(hdc, h);
			DeleteObject(intPtr2);
			if (iconInfo.HbmColor != IntPtr.Zero)
			{
				DeleteObject(iconInfo.HbmColor);
			}
			if (iconInfo.HbmMask != IntPtr.Zero)
			{
				DeleteObject(iconInfo.HbmMask);
			}
			return texture2D;
		}

		[DllImport("user32.dll")]
		private static extern IntPtr LoadCursor(IntPtr hInstance, int lpCursorName);

		[DllImport("user32.dll")]
		private static extern bool GetIconInfo(IntPtr hCursor, out ICONINFO iconInfo);

		[DllImport("user32.dll")]
		private static extern IntPtr CopyIcon(IntPtr hIcon);

		[DllImport("gdi32.dll")]
		private static extern IntPtr CreateCompatibleDC(IntPtr hdc);

		[DllImport("gdi32.dll")]
		private static extern IntPtr CreateDIBSection(IntPtr hdc, ref BITMAPINFO pbmi, uint iUsage, out IntPtr ppvBits, IntPtr hSection, uint dwOffset);

		[DllImport("gdi32.dll")]
		private static extern IntPtr SelectObject(IntPtr hdc, IntPtr h);

		[DllImport("gdi32.dll")]
		private static extern bool DeleteObject(IntPtr hObject);

		[DllImport("user32.dll")]
		private static extern bool DrawIconEx(IntPtr hdc, int xLeft, int yTop, IntPtr hIcon, int cxWidth, int cyHeight, int istepIfAniCur, IntPtr hbrFlickerFreeDraw, uint diFlags);

		[DllImport("user32.dll")]
		private static extern int GetSystemMetrics(int nIndex);
	}
}

using UnityEngine;
using ZXing;
using ZXing.Common;
using ZXing.QrCode;

namespace RemoteAdmin
{
	internal static class QrTextureUtility
	{
		public static Texture2D Create(string content, int size)
		{
			Texture2D texture2D = new Texture2D(size, size, TextureFormat.RGBA32, mipChain: false)
			{
				filterMode = FilterMode.Point
			};
			Color32[] array = new Color32[size * size];
			Color32 color = new Color32(0, 0, 0, byte.MaxValue);
			Color32 color2 = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
			BitMatrix bitMatrix = null;
			if (!string.IsNullOrEmpty(content))
			{
				try
				{
					bitMatrix = new QRCodeWriter().encode(content, BarcodeFormat.QR_CODE, size, size);
				}
				catch
				{
					bitMatrix = null;
				}
			}
			for (int i = 0; i < size; i++)
			{
				for (int j = 0; j < size; j++)
				{
					array[i * size + j] = ((bitMatrix != null && bitMatrix[j, size - 1 - i]) ? color : color2);
				}
			}
			texture2D.SetPixels32(array);
			texture2D.Apply();
			return texture2D;
		}
	}
}
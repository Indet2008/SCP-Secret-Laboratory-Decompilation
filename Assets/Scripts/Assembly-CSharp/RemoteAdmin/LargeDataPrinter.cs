using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using ZXing;
using ZXing.Common;

namespace RemoteAdmin
{
	public class LargeDataPrinter : MonoBehaviour
	{
		public GameObject Panel;

		public RawImage QrDisplay;

		public TMP_Text TimeDisplay;

		private static LargeDataPrinter _singleton;

		private static BarcodeWriterGeneric _barcodeWriter;

		private void OnEnable()
		{
			_singleton = this;
			if (_barcodeWriter == null)
			{
				_barcodeWriter = new BarcodeWriterGeneric
				{
					Format = BarcodeFormat.QR_CODE,
					Options = new EncodingOptions
					{
						Height = 800,
						Width = 800
					}
				};
			}
		}

		private void Update()
		{
			if (Input.GetKeyDown(KeyCode.Escape) && Panel.activeSelf)
			{
				Panel.SetActive(value: false);
			}
		}

		private void FixedUpdate()
		{
			TimeDisplay.text = DateTime.UtcNow.ToString("d/M/yyyy HH:mm:ss");
		}

		public static void Display(string content)
		{
			BitMatrix bitMatrix = _barcodeWriter.Encode(content);
			Texture2D texture2D = new Texture2D(800, 800, TextureFormat.RGBA32, mipChain: false);
			for (int i = 0; i < 800; i++)
			{
				for (int j = 0; j < 800; j++)
				{
					texture2D.SetPixel(i, j, bitMatrix[i, j] ? Color.black : Color.white);
				}
			}
			texture2D.Apply(updateMipmaps: true);
			_singleton.Panel.SetActive(value: true);
			_singleton.QrDisplay.texture = texture2D;
		}

		public static void Display(string content, bool replaceToBr)
		{
			Display(replaceToBr ? content.Replace("\n", "<br>") : content);
		}

		public static void Hide()
		{
			_singleton.Panel.SetActive(value: false);
		}
	}
}

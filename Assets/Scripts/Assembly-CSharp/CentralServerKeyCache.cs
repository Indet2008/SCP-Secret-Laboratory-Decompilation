using System;
using System.IO;
using System.Linq;
using Cryptography;
using GameCore;
using Org.BouncyCastle.Crypto;
using UnityEngine;

public static class CentralServerKeyCache
{
	private const string CacheLocation = "internal/KeyCache";

	private const string CacheSignatureLocation = "internal/KeySignatureCache";

	private const string InternalDir = "internal/";

	internal static readonly AsymmetricKeyParameter MasterKey;

	private const string MasterPublicKey = "-----BEGIN PUBLIC KEY-----\r\nMIGbMBAGByqGSM49AgEGBSuBBAAjA4GGAAQAbL0YvrhVB2meqCq5XzjAJD8Ii0hb\r\nBHdIQ587N583cP8twjDhcITjZhBHJPJDuA85XdpgG04HwT0SD3WcAvoQXBUAUsG1\r\nLS9TR4urHwfgfroq4tH2HAQE6ZxFZeIFSglLO8nxySim4yKBj96HLG624lzKvzoD\r\nId+GOwjcd3XskOq9Dwc=\r\n-----END PUBLIC KEY-----";

	static CentralServerKeyCache()
	{
		MasterKey = ECDSA.PublicKeyFromString("-----BEGIN PUBLIC KEY-----\r\nMIGbMBAGByqGSM49AgEGBSuBBAAjA4GGAAQAbL0YvrhVB2meqCq5XzjAJD8Ii0hb\r\nBHdIQ587N583cP8twjDhcITjZhBHJPJDuA85XdpgG04HwT0SD3WcAvoQXBUAUsG1\r\nLS9TR4urHwfgfroq4tH2HAQE6ZxFZeIFSglLO8nxySim4yKBj96HLG624lzKvzoD\r\nId+GOwjcd3XskOq9Dwc=\r\n-----END PUBLIC KEY-----");
	}

	public static string ReadCache()
	{
		try
		{
			string appFolder = FileManager.GetAppFolder();
			string path = appFolder + "internal/KeyCache";
			string path2 = appFolder + "internal/KeySignatureCache";
			if (!File.Exists(path))
			{
				ServerConsole.AddLog("Central server public key not found in cache.");
				return null;
			}
			if (!File.Exists(path2))
			{
				ServerConsole.AddLog("Central server public key signature not found in cache.");
				return null;
			}
			string[] source = FileManager.ReadAllLines(path);
			string[] array = FileManager.ReadAllLines(path2);
			if (array.Length == 0)
			{
				ServerConsole.AddLog("Can't load central server public key from cache - empty signature.");
				return null;
			}
			string text = source.Aggregate("", (string current, string line) => current + line + "\r\n").Trim();
			try
			{
				if (ECDSA.Verify(text, array[0], MasterKey))
				{
					return text;
				}
				GameCore.Console.AddLog("Invalid signature of Central Server Key in cache!", Color.red);
				return null;
			}
			catch (Exception ex)
			{
				if (ServerStatic.IsDedicated)
				{
					ServerConsole.AddLog("Can't load central server public key from cache - " + ex.Message);
				}
				else
				{
					GameCore.Console.AddLog("Can't load central server public key from cache - " + ex.Message, Color.magenta);
				}
				return null;
			}
		}
		catch (Exception ex2)
		{
			ServerConsole.AddLog("Can't read public key cache - " + ex2.Message);
			return null;
		}
	}

	public static void SaveCache(string key, string signature)
	{
		try
		{
			if (!ECDSA.Verify(key, signature, MasterKey))
			{
				GameCore.Console.AddLog("Invalid signature of Central Server Key!", Color.red);
				return;
			}
			string appFolder = FileManager.GetAppFolder();
			string path = appFolder + "internal/KeyCache";
			if (!Directory.Exists(FileManager.GetAppFolder() + "internal/"))
			{
				Directory.CreateDirectory(FileManager.GetAppFolder() + "internal/");
			}
			if (File.Exists(path))
			{
				if (key == ReadCache())
				{
					ServerConsole.AddLog("Key cache is up to date.");
					return;
				}
				File.Delete(path);
			}
			ServerConsole.AddLog("Updating key cache...");
			FileManager.WriteStringToFile(key, path);
			FileManager.WriteStringToFile(signature, appFolder + "internal/KeySignatureCache");
			ServerConsole.AddLog("Key cache updated.");
		}
		catch (Exception ex)
		{
			ServerConsole.AddLog("Can't write public key cache - " + ex.Message);
		}
	}
}

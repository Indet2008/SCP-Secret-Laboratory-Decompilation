using System;
using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class SerialNumberDetail : SyncedDetail
	{
		private static readonly Dictionary<string, ulong> ConstantNumbers = new Dictionary<string, ulong>
		{
			["jamie@northwood"] = 1uL,
			["hubert@northwood"] = 77777777777777777uL
		};

		private static readonly Dictionary<ulong, int> DuplicateCounter = new Dictionary<ulong, int>();

		private static readonly Dictionary<Material, Material[]> DigitMats = new Dictionary<Material, Material[]>();

		private static readonly System.Random Randomizer = new System.Random();

		[SerializeField]
		private int _serialLen;

		[SerializeField]
		private int _suffixLen;

		[SerializeField]
		private Material _sourceMaterial;

		[SerializeField]
		private Vector2 _uvBaselineOffset;

		[SerializeField]
		private Vector2 _uvOffsetMultiplier;

		public override void WriteDefault(NetworkWriter writer)
		{
			writer.WriteULong(0uL);
			writer.WriteByte(0);
		}

		public override void WriteNewItem(KeycardItem item, NetworkWriter writer)
		{
			ulong numberForPlayer = GetNumberForPlayer(item.Owner);
			WriteUniqueSerial(numberForPlayer, writer);
		}

		public override void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer)
		{
			ulong serial = (ulong)(Randomizer.NextDouble() * 1.8446744073709552E+19);
			WriteUniqueSerial(serial, writer);
		}

		protected override void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template)
		{
			ulong value = reader.ReadULong();
			byte b = reader.ReadByte();
			Renderer[] serialNumberDigits = target.SerialNumberDigits;
			for (int i = 0; i < serialNumberDigits.Length; i++)
			{
				serialNumberDigits[i].sharedMaterial = GetDigitMaterial(null);
			}
			for (int j = 0; j < _serialLen; j++)
			{
				int digitFromRight = GetDigitFromRight(value, j);
				serialNumberDigits[_serialLen - j - 1].sharedMaterial = GetDigitMaterial(digitFromRight);
			}
			for (int k = 0; k < _suffixLen; k++)
			{
				int digitFromRight2 = GetDigitFromRight(b, k);
				serialNumberDigits[^(1 + k)].sharedMaterial = GetDigitMaterial(digitFromRight2);
			}
		}

		protected Material GetDigitMaterial(int? digit)
		{
			int num = digit ?? 10;
			if (num < 0 || num > 10)
			{
				num = 10;
			}
			if (DigitMats.TryGetValue(_sourceMaterial, out var value))
			{
				return value[num];
			}
			value = new Material[11];
			for (int i = 0; i < value.Length; i++)
			{
				Material material = new Material(_sourceMaterial);
				Vector2 vector = i * _uvOffsetMultiplier;
				material.mainTextureOffset = _uvBaselineOffset + vector;
				value[i] = material;
			}
			DigitMats.Add(_sourceMaterial, value);
			return value[num];
		}

		private void WriteUniqueSerial(ulong serial, NetworkWriter writer)
		{
			int valueOrDefault = DuplicateCounter.GetValueOrDefault(serial);
			int num = valueOrDefault % (int)DigitsToModuloMask(_suffixLen);
			writer.WriteULong(serial);
			writer.WriteByte((byte)num);
			DuplicateCounter[serial] = valueOrDefault + 1;
		}

		private ulong GetNumberForPlayer(ReferenceHub hub)
		{
			if (ConstantNumbers.TryGetValue(hub.authManager.UserId, out var value))
			{
				return value;
			}
			ulong num = 1128889uL;
			string syncedUserId = hub.authManager.SyncedUserId;
			foreach (char c in syncedUserId)
			{
				int num2 = c * c;
				num = num * 571 + (ulong)num2;
			}
			return num % DigitsToModuloMask(_serialLen);
		}

		private static ulong DigitsToModuloMask(int digits)
		{
			ulong num = 1uL;
			for (int i = 0; i < digits; i++)
			{
				num *= 10;
			}
			return num;
		}

		private static int GetDigitFromRight(ulong value, int index)
		{
			ulong num = value;
			int num2 = 0;
			do
			{
				num /= 10;
				num2++;
			}
			while (num != 0);
			for (int i = 0; i < index; i++)
			{
				value /= 10;
			}
			return (int)(value % 10);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += DuplicateCounter.Clear;
		}
	}
}

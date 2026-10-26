using System;
using MapGeneration;
using Mirror;
using PlayerRoles;
using TMPro;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class NametagDetail : SyncedDetail, ICustomizableDetail
	{
		[Serializable]
		private struct RolePrefixOverride
		{
			public RoleTypeId[] Roles;

			public KeycardWordsCollection Prefix;
		}

		private const string DefaultName = "Name Not Set";

		[SerializeField]
		private RolePrefixOverride[] _roleBasedPrefixes;

		[SerializeField]
		private KeycardWordsCollection _fallbackPrefix;

		[SerializeField]
		private KeycardWordsCollection _fakeNamesPeople;

		[SerializeField]
		private KeycardWordsCollection _fakeNamesScp914;

		private static string _customNametag;

		public int CustomizablePropertiesAmount => 1;

		public string[] CommandArguments => new string[1] { "Card holder name (use '_' instead of spaces)" };

		public void ParseArguments(ArraySegment<string> args)
		{
			_customNametag = args.At(0).Replace('_', ' ');
		}

		public void SetArguments(ArraySegment<object> args)
		{
			_customNametag = (string)args.At(0);
		}

		public override void WriteDefault(NetworkWriter writer)
		{
			WriteNameWithPrefix(writer, "Name Not Set", RoleTypeId.None);
		}

		public override void WriteNewItem(KeycardItem item, NetworkWriter writer)
		{
			if (item.Customizable)
			{
				writer.WriteString(_customNametag);
				return;
			}
			ReferenceHub owner = item.Owner;
			WriteNameWithPrefix(writer, owner.nicknameSync.DisplayName, owner.GetRoleId());
		}

		public override void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer)
		{
			if (pickup.Position.TryGetRoom(out var room) && room.Name == RoomName.Lcz914)
			{
				writer.WriteString(_fakeNamesScp914.NextRandomWord());
			}
			else
			{
				WriteNameWithPrefix(writer, _fakeNamesPeople.NextRandomWord(), RoleTypeId.None);
			}
		}

		protected override void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template)
		{
			string text = reader.ReadString();
			TMP_Text[] nameFields = target.NameFields;
			for (int i = 0; i < nameFields.Length; i++)
			{
				nameFields[i].text = text;
			}
		}

		private void WriteNameWithPrefix(NetworkWriter writer, string name, RoleTypeId role)
		{
			KeycardWordsCollection keycardWordsCollection = _fallbackPrefix;
			RolePrefixOverride[] roleBasedPrefixes = _roleBasedPrefixes;
			for (int i = 0; i < roleBasedPrefixes.Length; i++)
			{
				RolePrefixOverride rolePrefixOverride = roleBasedPrefixes[i];
				if (rolePrefixOverride.Roles.Contains(role))
				{
					keycardWordsCollection = rolePrefixOverride.Prefix;
					break;
				}
			}
			if (keycardWordsCollection == null)
			{
				writer.WriteString(name);
			}
			else
			{
				writer.WriteString(keycardWordsCollection.Words.RandomItem() + " " + name);
			}
		}
	}
}

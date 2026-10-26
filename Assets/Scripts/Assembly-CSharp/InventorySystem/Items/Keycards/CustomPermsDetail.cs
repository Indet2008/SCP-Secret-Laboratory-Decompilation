using System;
using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class CustomPermsDetail : SyncedDetail, ICustomizableDetail, IDoorPermissionProvider
	{
		private static readonly Dictionary<ushort, DoorPermissionFlags> CustomPermissions = new Dictionary<ushort, DoorPermissionFlags>();

		private static KeycardLevels _customLevels;

		private static Color32? _customColor;

		public PermissionUsed PermissionsUsedCallback => null;

		public int CustomizablePropertiesAmount => 2;

		public string[] CommandArguments => new string[4]
		{
			string.Format("{0} level (0-{1})", "Containment", 3),
			string.Format("{0} level (0-{1})", "Armory", 3),
			string.Format("{0} level (0-{1})", "Admin", 3),
			"Permission color (hex, name, or 'default')"
		};

		public void ParseArguments(ArraySegment<string> args)
		{
			_customColor = (Misc.TryParseColor(args.At(3), out var color) ? new Color32?(color) : ((Color32?)null));
			int containment = int.Parse(args.At(0));
			int armory = int.Parse(args.At(1));
			int admin = int.Parse(args.At(2));
			_customLevels = new KeycardLevels(containment, armory, admin);
		}

		public void SetArguments(ArraySegment<object> args)
		{
			_customLevels = (KeycardLevels)args.At(0);
			_customColor = (Color32)args.At(1);
		}

		private void WriteCustom(IIdentifierProvider target, NetworkWriter writer)
		{
			DoorPermissionFlags permissions = _customLevels.Permissions;
			if (NetworkServer.active)
			{
				ushort serialNumber = target.ItemId.SerialNumber;
				CustomPermissions[serialNumber] = permissions;
			}
			writer.WriteUShort((ushort)permissions);
			writer.WriteColor32Nullable(_customColor);
		}

		public override void WriteDefault(NetworkWriter writer)
		{
			writer.WriteUShort(0);
			writer.WriteColor32Nullable(null);
		}

		public override void WriteNewItem(KeycardItem item, NetworkWriter writer)
		{
			WriteCustom(item, writer);
		}

		public override void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer)
		{
			WriteCustom(pickup, writer);
		}

		protected override void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template)
		{
			DoorPermissionFlags doorPermissionFlags = (DoorPermissionFlags)reader.ReadUShort();
			Color color = reader.ReadColor32Nullable() ?? ((Color32)Color.white);
			target.SetPermissions(new KeycardLevels(doorPermissionFlags), color);
			CustomPermissions[target.ParentId.SerialNumber] = doorPermissionFlags;
		}

		public DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			KeycardItem component = base.transform.parent.GetComponent<KeycardItem>();
			if (!(component == null))
			{
				return CustomPermissions.GetValueOrDefault(component.ItemSerial);
			}
			return DoorPermissionFlags.None;
		}
	}
}

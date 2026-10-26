using UnityEngine;

namespace Interactables.Interobjects.DoorUtils
{
	public readonly struct KeycardLevels
	{
		public const int MaxLevel = 3;

		public static readonly DoorPermissionFlags[] AdminLevels = new DoorPermissionFlags[4]
		{
			DoorPermissionFlags.None,
			DoorPermissionFlags.Checkpoints | DoorPermissionFlags.Intercom,
			DoorPermissionFlags.ExitGates,
			DoorPermissionFlags.AlphaWarhead
		};

		public readonly int Containment;

		public readonly int Armory;

		public readonly int Admin;

		public int HighestLevelValue => Mathf.Max(Containment, Mathf.Max(Armory, Admin));

		public DoorPermissionFlags Permissions
		{
			get
			{
				DoorPermissionFlags doorPermissionFlags = DoorPermissionFlags.None;
				for (int i = 0; i < Containment; i++)
				{
					int num = 16 << i;
					doorPermissionFlags = (DoorPermissionFlags)((uint)doorPermissionFlags | (uint)(ushort)num);
				}
				for (int j = 0; j < Armory; j++)
				{
					int num2 = 128 << j;
					doorPermissionFlags = (DoorPermissionFlags)((uint)doorPermissionFlags | (uint)(ushort)num2);
				}
				for (int k = 0; k < Admin; k++)
				{
					doorPermissionFlags |= AdminLevels[k + 1];
				}
				return doorPermissionFlags;
			}
		}

		public KeycardLevels(DoorPermissionFlags flags)
		{
			Containment = 0;
			Armory = 0;
			Admin = 0;
			for (int i = 0; i < 3; i++)
			{
				DoorPermissionFlags flag = (DoorPermissionFlags)(16 << i);
				if (flags.HasFlagAny(flag))
				{
					Containment = i + 1;
				}
			}
			for (int j = 0; j < 3; j++)
			{
				DoorPermissionFlags flag2 = (DoorPermissionFlags)(128 << j);
				if (flags.HasFlagAny(flag2))
				{
					Armory = j + 1;
				}
			}
			for (int num = 3; num > 0; num--)
			{
				if (flags.HasFlagAny(AdminLevels[num]))
				{
					Admin = num;
					break;
				}
			}
		}

		public KeycardLevels(int containment, int armory, int admin, bool clamp = true)
		{
			if (clamp)
			{
				containment = Mathf.Clamp(containment, 0, 3);
				armory = Mathf.Clamp(armory, 0, 3);
				admin = Mathf.Clamp(admin, 0, 3);
			}
			Containment = containment;
			Armory = armory;
			Admin = admin;
		}
	}
}

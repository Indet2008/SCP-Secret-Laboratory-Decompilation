using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public struct FpcRotationOverrideMessage : NetworkMessage
	{
		private const float FullAngle = 360f;

		public Vector2 Rotation;

		public FpcRotationOverrideMessage(Vector2 rotation)
		{
			Rotation = rotation;
		}

		public FpcRotationOverrideMessage(NetworkReader reader)
		{
			int num = reader.ReadInt();
			ushort num2 = (ushort)num;
			ushort num3 = (ushort)(num << 16);
			float x = Mathf.Lerp(-360f, 360f, (float)(int)num3 / 65535f);
			float y = Mathf.Lerp(-360f, 360f, (float)(int)num2 / 65535f);
			Rotation = new Vector2(x, y);
		}

		public void Write(NetworkWriter writer)
		{
			float num = Mathf.InverseLerp(-360f, 360f, Rotation.x);
			float num2 = Mathf.InverseLerp(-360f, 360f, Rotation.y);
			ushort num3 = (ushort)Mathf.RoundToInt(num * 65535f);
			ushort num4 = (ushort)Mathf.RoundToInt(num2 * 65535f);
			int num5 = num3;
			num5 <<= 16;
			num5 += num4;
			writer.WriteInt(num5);
		}

		public void ProcessMessage()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole && fpcRole.FpcModule.ModuleReady)
			{
				fpcRole.FpcModule.MouseLook.CurrentVertical = Rotation.x;
				fpcRole.FpcModule.MouseLook.CurrentHorizontal = Rotation.y;
			}
		}
	}
}

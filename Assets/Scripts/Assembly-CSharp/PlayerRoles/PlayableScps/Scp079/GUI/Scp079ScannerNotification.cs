using System.Text;
using MapGeneration;
using NorthwoodLib.Pools;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.Map;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079ScannerNotification : Scp079AccentedNotification
	{
		private static readonly CachedLayerMask Mask = new CachedLayerMask("Default");

		private const string RedColorHex = "#ff1111";

		public Scp079ScannerNotification(HumanRole detectedHuman)
			: base(HumanFoundText(detectedHuman), detectedHuman.RoleColor.ToHex())
		{
		}

		public Scp079ScannerNotification(int retryTime)
			: base(NoneFoundText(retryTime), "#ff1111")
		{
		}

		private static string HumanFoundText(HumanRole role)
		{
			string format = Translations.Get(Scp079HudTranslation.ScanResultPlayerDetected);
			Scp079Camera bestCamera = GetBestCamera(role.FpcModule.Position);
			return string.Format(arg2: Translations.Get(ProceduralZoneMap.ZoneTranslations[bestCamera.Room.Zone]), format: format, arg0: role.RoleName, arg1: bestCamera.Label);
		}

		private static string NoneFoundText(int retryTime)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append(Translations.Get(Scp079HudTranslation.ScanResultNoneFound));
			if (retryTime > 0)
			{
				stringBuilder.Append("\n");
				stringBuilder.AppendFormat(Translations.Get(Scp079HudTranslation.ScanResultRetryingMessage), retryTime);
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		private static Scp079Camera GetBestCamera(Vector3 pos)
		{
			Scp079Camera.TryGetClosestCamera(pos, null, out var closest);
			if (!pos.TryGetRoom(out var room))
			{
				return closest;
			}
			bool flag = false;
			bool flag2 = false;
			float num = 0f;
			float num2 = 0f;
			Scp079Camera result = null;
			Scp079Camera result2 = null;
			foreach (Scp079InteractableBase allInstance in Scp079InteractableBase.AllInstances)
			{
				if (!(allInstance is Scp079Camera scp079Camera) || !(scp079Camera.Room == room))
				{
					continue;
				}
				float sqrMagnitude = (scp079Camera.Position - pos).sqrMagnitude;
				if (!flag || !(sqrMagnitude > num))
				{
					if (!flag2 || sqrMagnitude < num2)
					{
						result2 = scp079Camera;
						num2 = sqrMagnitude;
						flag2 = true;
					}
					if (!Physics.Linecast(scp079Camera.Position, pos, out var _, Mask))
					{
						result = scp079Camera;
						flag = true;
						num = sqrMagnitude;
					}
				}
			}
			if (!flag)
			{
				if (!flag2)
				{
					return closest;
				}
				return result2;
			}
			return result;
		}
	}
}

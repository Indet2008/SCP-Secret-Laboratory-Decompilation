using System;
using System.Collections.Generic;
using InventorySystem.Items.Scp1509;
using Mirror;
using PlayerRoles.PlayableScps.Scp1507;
using PlayerRoles.PlayableScps.Scp3114;
using PlayerRoles.PlayableScps.Scp939;
using UnityEngine;

namespace PlayerStatsSystem
{
	public static class DamageHandlers
	{
		public static readonly Func<DamageHandlerBase>[] DefinedConstructors = new Func<DamageHandlerBase>[23]
		{
			() => new RecontainmentDamageHandler(default),
			() => new FirearmDamageHandler(),
			() => new WarheadDamageHandler(),
			() => new UniversalDamageHandler(),
			() => new ScpDamageHandler(),
			() => new Scp096DamageHandler(),
			() => new Scp049DamageHandler(),
			() => new MicroHidDamageHandler(null, 0f),
			() => new CustomReasonDamageHandler(string.Empty),
			() => new ExplosionDamageHandler(default, Vector3.zero, 0f, 0, ExplosionType.Grenade),
			() => new Scp018DamageHandler(null, 0f, ignoreFF: false),
			() => new DisruptorDamageHandler(null, default, 0f),
			() => new JailbirdDamageHandler(),
			() => new Scp939DamageHandler(null, 0f),
			() => new Scp3114DamageHandler(),
			() => new Scp1507DamageHandler(default, 0f),
			() => new Scp956DamageHandler(Vector3.zero),
			() => new SnowballDamageHandler(),
			() => new CustomReasonFirearmDamageHandler(),
			() => new SilentDamageHandler(),
			() => new Scp1509DamageHandler(),
			() => new GrayCandyDamageHandler(),
			() => new MarshmallowDamageHandler(default, 0f)
		};

		public static readonly Dictionary<byte, Func<DamageHandlerBase>> ConstructorsById = new Dictionary<byte, Func<DamageHandlerBase>>();

		public static readonly Dictionary<int, byte> IdsByTypeHash = new Dictionary<int, byte>();

		[RuntimeInitializeOnLoadMethod]
		private static void PrepDictionaries()
		{
			byte b = 0;
			Func<DamageHandlerBase>[] definedConstructors = DefinedConstructors;
			foreach (Func<DamageHandlerBase> func in definedConstructors)
			{
				IdsByTypeHash.Add(func().GetType().FullName.GetStableHashCode(), b);
				ConstructorsById.Add(b, func);
				b++;
			}
		}
	}
}

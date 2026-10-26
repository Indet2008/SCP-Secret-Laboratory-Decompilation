using Footprinting;
using Mirror;
using PlayerRoles.Ragdolls;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114DamageHandler : AttackerDamageHandler, IRagdollInspectOverride
	{
		public enum HandlerType : byte
		{
			Slap = 0,
			Strangulation = 1,
			SkinSteal = 2
		}

		private DamageHandlerBase _replacedHandler;

		public override float Damage { get; set; }

		public override CassieAnnouncement CassieDeathAnnouncement => new CassieAnnouncement();

		public override Footprint Attacker { get; protected set; }

		public override string ServerLogsText => Subtype.ToString();

		public override bool AllowSelfDamage => false;

		public HandlerType Subtype { get; private set; }

		public bool StartingRagdoll { get; private set; }

		public override string RagdollInspectText => DeathTranslation.RagdollTranslation;

		public override string DeathScreenText => string.Empty;

		public string RagdollInspectFormatOverride
		{
			get
			{
				if (Subtype == HandlerType.SkinSteal)
				{
					if (StartingRagdoll)
					{
						return string.Empty;
					}
					if (!Translations.TryGet(Scp3114HudTranslation.InspectRagdollOverride, out var tr))
					{
						return "Missing translation. Owner: {0}";
					}
					return tr;
				}
				if (!StartingRagdoll)
				{
					return null;
				}
				if (!ReferenceHub.TryGetLocalHub(out var hub) || !hub.IsSCP())
				{
					return string.Empty;
				}
				return StartingDisguiseHint;
			}
		}

		private string StartingDisguiseHint
		{
			get
			{
				if (!Translations.TryGet(Scp3114HudTranslation.StartingRagdollHint, out var tr))
				{
					tr = "Missing starting ragdoll message for {0}";
				}
				return string.Format(tr, "{1}");
			}
		}

		private DeathTranslation DeathTranslation => Subtype switch
		{
			HandlerType.Slap => DeathTranslations.Scp3114Slap, 
			HandlerType.Strangulation => DeathTranslations.Asphyxiated, 
			_ => DeathTranslations.Unknown, 
		};

		public Scp3114DamageHandler(ReferenceHub attacker, float damage, HandlerType attackType)
		{
			Damage = damage;
			Subtype = attackType;
			Attacker = new Footprint(attacker);
		}

		public Scp3114DamageHandler()
		{
			Damage = 0f;
			Subtype = HandlerType.Slap;
			Attacker = default;
		}

		public Scp3114DamageHandler(BasicRagdoll ragdoll, bool isStarting)
		{
			Damage = 0f;
			_replacedHandler = ragdoll.Info.Handler;
			if (isStarting)
			{
				Subtype = HandlerType.Slap;
				StartingRagdoll = true;
			}
			else
			{
				Subtype = HandlerType.SkinSteal;
				StartingRagdoll = ragdoll.Info.Handler is Scp3114DamageHandler scp3114DamageHandler && scp3114DamageHandler.StartingRagdoll;
			}
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			writer.WriteByte((byte)Subtype);
			writer.WriteBool(StartingRagdoll);
			if (Subtype == HandlerType.SkinSteal)
			{
				writer.WriteDamageHandler(_replacedHandler);
			}
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			Subtype = (HandlerType)reader.ReadByte();
			StartingRagdoll = reader.ReadBool();
			if (Subtype == HandlerType.SkinSteal)
			{
				_replacedHandler = reader.ReadDamageHandler();
			}
		}

		public override void ProcessRagdoll(BasicRagdoll ragdoll)
		{
			if (!(ragdoll is DynamicRagdoll dynamicRagdoll))
			{
				base.ProcessRagdoll(ragdoll);
			}
			else if (Subtype == HandlerType.SkinSteal)
			{
				_replacedHandler?.ProcessRagdoll(ragdoll);
				Scp3114RagdollToBonesConverter.ConvertExisting(dynamicRagdoll);
			}
			else if (StartingRagdoll)
			{
				dynamicRagdoll.LinkedRigidbodies.ForEach((Rigidbody rb) =>
				{
					rb.linearVelocity = Physics.gravity;
				});
			}
			else
			{
				base.ProcessRagdoll(ragdoll);
			}
		}
	}
}

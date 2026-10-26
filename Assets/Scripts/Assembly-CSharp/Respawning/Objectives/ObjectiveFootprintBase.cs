using System.Text;
using Mirror;
using PlayerRoles;
using UnityEngine;

namespace Respawning.Objectives
{
	public abstract class ObjectiveFootprintBase
	{
		public float InfluenceReward { get; set; }

		public float TimeReward { get; set; }

		public ObjectiveHubFootprint AchievingPlayer { get; set; }

		protected abstract FootprintsTranslation TargetTranslation { get; }

		public virtual void ClientReadRpc(NetworkReader reader)
		{
			InfluenceReward = reader.ReadFloat();
			TimeReward = reader.ReadFloat();
			AchievingPlayer = new ObjectiveHubFootprint(reader);
		}

		public virtual void ServerWriteRpc(NetworkWriter writer)
		{
			writer.WriteFloat(InfluenceReward);
			writer.WriteFloat(TimeReward);
			AchievingPlayer.Write(writer);
		}

		public virtual StringBuilder ClientCompletionText(StringBuilder builder)
		{
			RoleTypeId roleType = AchievingPlayer.RoleType;
			Color roleColor = roleType.GetRoleColor();
			bool flag = TimeReward != 0f;
			bool num = InfluenceReward != 0f;
			string newValue = string.Empty;
			string newValue2 = string.Empty;
			builder.Append(Translations.Get(TargetTranslation));
			builder.Append(Translations.Get(FootprintsTranslation.GenericRewardsDisplay));
			if (num)
			{
				newValue2 = Translations.Get(FootprintsTranslation.InfluenceRewardDisplay);
			}
			if (flag)
			{
				newValue = Translations.Get(FootprintsTranslation.TimerRewardDisplay);
			}
			builder.Replace("%timeDisplay%", newValue2);
			builder.Replace("%influenceDisplay%", newValue);
			if (num)
			{
				builder.Replace("%influence%", InfluenceReward.ToString());
			}
			if (flag)
			{
				builder.Replace("%time%", TimeReward.ToString());
			}
			builder.Replace("%achieverColor%", roleColor.ToHex());
			builder.Replace("%achieverName%", AchievingPlayer.Nickname);
			builder.Replace("%factionColor%", roleType.GetFaction().GetFactionColor());
			if (num | flag)
			{
				builder.Replace("(", "[");
				builder.Replace(")", "]");
			}
			return builder;
		}
	}
}

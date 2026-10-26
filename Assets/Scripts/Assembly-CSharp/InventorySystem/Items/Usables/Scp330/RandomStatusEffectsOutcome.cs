using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using CustomPlayerEffects;
using NorthwoodLib.Pools;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class RandomStatusEffectsOutcome : BlackCandyOutcomeBase
	{
		private readonly struct EffectValues
		{
			public float Duration { get; init; }

			public byte Intensity { get; init; }

			public byte? MaxIntensity { get; init; }

			public EffectValues(float Duration, byte Intensity = 1, byte? MaxIntensity = null)
			{
				this.Duration = Duration;
				this.Intensity = Intensity;
				this.MaxIntensity = MaxIntensity;
			}

			[CompilerGenerated]
			public override string ToString()
			{
				StringBuilder stringBuilder = new StringBuilder();
				stringBuilder.Append("EffectValues");
				stringBuilder.Append(" { ");
				if (PrintMembers(stringBuilder))
				{
					stringBuilder.Append(' ');
				}
				stringBuilder.Append('}');
				return stringBuilder.ToString();
			}

			[CompilerGenerated]
			private bool PrintMembers(StringBuilder builder)
			{
				builder.Append("Duration = ");
				builder.Append(Duration.ToString());
				builder.Append(", Intensity = ");
				builder.Append(Intensity.ToString());
				builder.Append(", MaxIntensity = ");
				builder.Append(MaxIntensity.ToString());
				return true;
			}

			[CompilerGenerated]
			public static bool operator !=(EffectValues left, EffectValues right)
			{
				return !(left == right);
			}

			[CompilerGenerated]
			public static bool operator ==(EffectValues left, EffectValues right)
			{
				return left.Equals(right);
			}

			[CompilerGenerated]
			public override int GetHashCode()
			{
				return (EqualityComparer<float>.Default.GetHashCode(Duration) * -1521134295 + EqualityComparer<byte>.Default.GetHashCode(Intensity)) * -1521134295 + EqualityComparer<byte?>.Default.GetHashCode(MaxIntensity);
			}

			[CompilerGenerated]
			public override bool Equals(object obj)
			{
				if (obj is EffectValues)
				{
					return Equals((EffectValues)obj);
				}
				return false;
			}

			[CompilerGenerated]
			public bool Equals(EffectValues other)
			{
				if (EqualityComparer<float>.Default.Equals(Duration, other.Duration) && EqualityComparer<byte>.Default.Equals(Intensity, other.Intensity))
				{
					return EqualityComparer<byte?>.Default.Equals(MaxIntensity, other.MaxIntensity);
				}
				return false;
			}

			[CompilerGenerated]
			public void Deconstruct(out float Duration, out byte Intensity, out byte? MaxIntensity)
			{
				Duration = this.Duration;
				Intensity = this.Intensity;
				MaxIntensity = this.MaxIntensity;
			}
		}

		private const int MinGrantedEffects = 1;

		private const int MaxGrantedEffects = 3;

		private const byte DefaultIntensity = 1;

		private static readonly Dictionary<Type, EffectValues> PossibleEffects = new Dictionary<Type, EffectValues>
		{
			[typeof(CustomPlayerEffects.Scp207)] = new EffectValues(60f, 1, 4),
			[typeof(CustomPlayerEffects.AntiScp207)] = new EffectValues(60f, 1, 4),
			[typeof(Bleeding)] = new EffectValues(20f, 1),
			[typeof(Concussed)] = new EffectValues(10f, 1),
			[typeof(Invigorated)] = new EffectValues(15f, 1),
			[typeof(Slowness)] = new EffectValues(10f, 25),
			[typeof(Flashed)] = new EffectValues(5f, 1),
			[typeof(Poisoned)] = new EffectValues(20f, 1),
			[typeof(MovementBoost)] = new EffectValues(10f, 25),
			[typeof(Lightweight)] = new EffectValues(20f, 60)
		};

		public override void ServerGrant(ReferenceHub target)
		{
			List<Type> list = ListPool<Type>.Shared.Rent();
			int num = UnityEngine.Random.Range(1, 4);
			for (int i = 0; i < num; i++)
			{
				int index = UnityEngine.Random.Range(0, PossibleEffects.Count);
				Type item = PossibleEffects.Keys.ElementAt(index);
				list.Add(item);
			}
			StatusEffectBase[] allEffects = target.playerEffectsController.AllEffects;
			foreach (StatusEffectBase statusEffectBase in allEffects)
			{
				Type type = statusEffectBase.GetType();
				if (list.Contains(type) && PossibleEffects.TryGetValue(type, out var value))
				{
					float duration = ((statusEffectBase.Duration == 0f && statusEffectBase.IsEnabled) ? statusEffectBase.Duration : value.Duration);
					byte b = Math.Max(value.Intensity, statusEffectBase.Intensity);
					if (value.MaxIntensity.HasValue)
					{
						b = (byte)Mathf.Min(b, value.MaxIntensity.Value);
					}
					statusEffectBase.ServerSetState(b, duration);
				}
			}
			ListPool<Type>.Shared.Return(list);
		}
	}
}

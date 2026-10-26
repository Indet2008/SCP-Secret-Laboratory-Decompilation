using System;
using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;
using UserSettings;
using UserSettings.VideoSettings;

namespace AdminToys
{
	public class LightSourceToy : AdminToyBase
	{
		[SerializeField]
		private Light _light;

		[SyncVar(hook = "SetIntensity")]
		public float LightIntensity;

		[SyncVar(hook = "SetRange")]
		public float LightRange;

		[SyncVar(hook = "SetColor")]
		public Color LightColor;

		[SyncVar(hook = "SetShadows")]
		public LightShadows ShadowType;

		[SyncVar(hook = "SetShadowStrength")]
		public float ShadowStrength;

		[SyncVar(hook = "SetType")]
		public LightType LightType;

		[SyncVar(hook = "SetShape")]
		public LightShape LightShape;

		[SyncVar(hook = "SetSpotAngle")]
		public float SpotAngle;

		[SyncVar(hook = "SetInnerSpotAngle")]
		public float InnerSpotAngle;

		public override string CommandName => "LightSource";

		public float NetworkLightIntensity
		{
			get
			{
				return LightIntensity;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref LightIntensity, 32uL, SetIntensity);
			}
		}

		public float NetworkLightRange
		{
			get
			{
				return LightRange;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref LightRange, 64uL, SetRange);
			}
		}

		public Color NetworkLightColor
		{
			get
			{
				return LightColor;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref LightColor, 128uL, SetColor);
			}
		}

		public LightShadows NetworkShadowType
		{
			get
			{
				return ShadowType;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref ShadowType, 256uL, SetShadows);
			}
		}

		public float NetworkShadowStrength
		{
			get
			{
				return ShadowStrength;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref ShadowStrength, 512uL, SetShadowStrength);
			}
		}

		public LightType NetworkLightType
		{
			get
			{
				return LightType;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref LightType, 1024uL, SetType);
			}
		}

		public LightShape NetworkLightShape
		{
			get
			{
				return LightShape;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref LightShape, 2048uL, SetShape);
			}
		}

		public float NetworkSpotAngle
		{
			get
			{
				return SpotAngle;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref SpotAngle, 4096uL, SetSpotAngle);
			}
		}

		public float NetworkInnerSpotAngle
		{
			get
			{
				return InnerSpotAngle;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref InnerSpotAngle, 8192uL, SetInnerSpotAngle);
			}
		}

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			base.OnSpawned(admin, arguments);
			base.transform.position = admin.PlayerCameraReference.position;
			base.transform.localScale = Vector3.one;
		}

		protected override void Start()
		{
			base.Start();
			if (!UserSetting<bool>.Get(LightingVideoSetting.RenderShadows))
			{
				_light.shadows = LightShadows.None;
			}
		}

		private void SetIntensity(float oldIntensity, float newIntensity)
		{
			_light.intensity = newIntensity;
		}

		private void SetRange(float oldRange, float newRange)
		{
			_light.range = newRange;
		}

		private void SetColor(Color oldColor, Color newColor)
		{
			_light.color = newColor;
		}

		private void SetShadows(LightShadows oldShadows, LightShadows newShadows)
		{
			if (!UserSetting<bool>.Get(LightingVideoSetting.RenderShadows))
			{
				_light.shadows = LightShadows.None;
			}
			else
			{
				_light.shadows = ((LightType != LightType.Directional) ? newShadows : LightShadows.None);
			}
		}

		private void SetShadowStrength(float oldStrength, float newStrength)
		{
			_light.shadowStrength = newStrength;
		}

		private void SetType(LightType oldType, LightType newType)
		{
			if (newType == LightType.Directional)
			{
				NetworkShadowType = LightShadows.None;
			}
			if (newType > LightType.Point)
			{
				NetworkLightType = LightType.Point;
			}
			else
			{
				_light.type = newType;
			}
		}

		private void SetShape(LightShape oldShape, LightShape newShape)
		{
			_light.shape = newShape;
		}

		private void SetSpotAngle(float oldAngle, float newAngle)
		{
			_light.spotAngle = newAngle;
		}

		private void SetInnerSpotAngle(float oldAngle, float newAngle)
		{
			_light.innerSpotAngle = newAngle;
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteFloat(LightIntensity);
				writer.WriteFloat(LightRange);
				writer.WriteColor(LightColor);
				GeneratedNetworkCode._Write_UnityEngine_002ELightShadows(writer, ShadowType);
				writer.WriteFloat(ShadowStrength);
				GeneratedNetworkCode._Write_UnityEngine_002ELightType(writer, LightType);
				GeneratedNetworkCode._Write_UnityEngine_002ELightShape(writer, LightShape);
				writer.WriteFloat(SpotAngle);
				writer.WriteFloat(InnerSpotAngle);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				writer.WriteFloat(LightIntensity);
			}
			if ((base.syncVarDirtyBits & 0x40L) != 0L)
			{
				writer.WriteFloat(LightRange);
			}
			if ((base.syncVarDirtyBits & 0x80L) != 0L)
			{
				writer.WriteColor(LightColor);
			}
			if ((base.syncVarDirtyBits & 0x100L) != 0L)
			{
				GeneratedNetworkCode._Write_UnityEngine_002ELightShadows(writer, ShadowType);
			}
			if ((base.syncVarDirtyBits & 0x200L) != 0L)
			{
				writer.WriteFloat(ShadowStrength);
			}
			if ((base.syncVarDirtyBits & 0x400L) != 0L)
			{
				GeneratedNetworkCode._Write_UnityEngine_002ELightType(writer, LightType);
			}
			if ((base.syncVarDirtyBits & 0x800L) != 0L)
			{
				GeneratedNetworkCode._Write_UnityEngine_002ELightShape(writer, LightShape);
			}
			if ((base.syncVarDirtyBits & 0x1000L) != 0L)
			{
				writer.WriteFloat(SpotAngle);
			}
			if ((base.syncVarDirtyBits & 0x2000L) != 0L)
			{
				writer.WriteFloat(InnerSpotAngle);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref LightIntensity, SetIntensity, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref LightRange, SetRange, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref LightColor, SetColor, reader.ReadColor());
				GeneratedSyncVarDeserialize(ref ShadowType, SetShadows, GeneratedNetworkCode._Read_UnityEngine_002ELightShadows(reader));
				GeneratedSyncVarDeserialize(ref ShadowStrength, SetShadowStrength, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref LightType, SetType, GeneratedNetworkCode._Read_UnityEngine_002ELightType(reader));
				GeneratedSyncVarDeserialize(ref LightShape, SetShape, GeneratedNetworkCode._Read_UnityEngine_002ELightShape(reader));
				GeneratedSyncVarDeserialize(ref SpotAngle, SetSpotAngle, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref InnerSpotAngle, SetInnerSpotAngle, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref LightIntensity, SetIntensity, reader.ReadFloat());
			}
			if ((num & 0x40L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref LightRange, SetRange, reader.ReadFloat());
			}
			if ((num & 0x80L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref LightColor, SetColor, reader.ReadColor());
			}
			if ((num & 0x100L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref ShadowType, SetShadows, GeneratedNetworkCode._Read_UnityEngine_002ELightShadows(reader));
			}
			if ((num & 0x200L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref ShadowStrength, SetShadowStrength, reader.ReadFloat());
			}
			if ((num & 0x400L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref LightType, SetType, GeneratedNetworkCode._Read_UnityEngine_002ELightType(reader));
			}
			if ((num & 0x800L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref LightShape, SetShape, GeneratedNetworkCode._Read_UnityEngine_002ELightShape(reader));
			}
			if ((num & 0x1000L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref SpotAngle, SetSpotAngle, reader.ReadFloat());
			}
			if ((num & 0x2000L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref InnerSpotAngle, SetInnerSpotAngle, reader.ReadFloat());
			}
		}
	}
}

using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using MapGeneration;
using MapGeneration.StaticHelpers;
using Mirror;
using UnityEngine;

namespace AdminToys
{
	public class PrimitiveObjectToy : AdminToyBase, IRoomObject
	{
		private static readonly Dictionary<Color, Material> CachedMaterials = new Dictionary<Color, Material>();

		private static readonly Dictionary<PrimitiveType, Mesh> PrimitiveTypeToMesh = new Dictionary<PrimitiveType, Mesh>(6);

		private static readonly int BaseColor = Shader.PropertyToID("_BaseColor");

		[SerializeField]
		private Material _regularMatTemplate;

		[SerializeField]
		private Material _transparentMatTemplate;

		[SerializeField]
		private MeshFilter _filter;

		[SerializeField]
		private MeshRenderer _renderer;

		private Collider _collider;

		[SyncVar(hook = "SetPrimitive")]
		public PrimitiveType PrimitiveType;

		[SyncVar(hook = "SetColor")]
		public Color MaterialColor;

		[SyncVar(hook = "SetFlags")]
		public PrimitiveFlags PrimitiveFlags = PrimitiveFlags.Collidable | PrimitiveFlags.Visible;

		public override string CommandName => "PrimitiveObject";

		public RoomIdentifier OriginalRoom { get; set; }

		public PrimitiveType NetworkPrimitiveType
		{
			get
			{
				return PrimitiveType;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref PrimitiveType, 32uL, SetPrimitive);
			}
		}

		public Color NetworkMaterialColor
		{
			get
			{
				return MaterialColor;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref MaterialColor, 64uL, SetColor);
			}
		}

		public PrimitiveFlags NetworkPrimitiveFlags
		{
			get
			{
				return PrimitiveFlags;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref PrimitiveFlags, 128uL, SetFlags);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				CachedMaterials.Clear();
				PrimitiveTypeToMesh.Clear();
				PrimitiveType[] values = EnumUtils<PrimitiveType>.Values;
				foreach (PrimitiveType primitiveType in values)
				{
					GameObject obj = GameObject.CreatePrimitive(primitiveType);
					Mesh sharedMesh = obj.GetComponent<MeshFilter>().sharedMesh;
					PrimitiveTypeToMesh.Add(primitiveType, sharedMesh);
					UnityEngine.Object.Destroy(obj);
				}
			};
		}

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			string[] array = arguments.Array;
			NetworkPrimitiveType = ((array.Length > 2 && Enum.TryParse<PrimitiveType>(array[2], ignoreCase: true, out var result)) ? result : PrimitiveType.Sphere);
			NetworkMaterialColor = ((array.Length > 3 && ColorUtility.TryParseHtmlString(array[3], out var color)) ? color : Color.gray);
			float num = ((array.Length > 4 && float.TryParse(array[4], out var result2)) ? result2 : 1f);
			NetworkPrimitiveFlags = ((array.Length > 5 && Enum.TryParse<PrimitiveFlags>(array[5], ignoreCase: true, out var result3)) ? result3 : ((PrimitiveFlags)byte.MaxValue));
			base.transform.SetPositionAndRotation(admin.PlayerCameraReference.position, admin.PlayerCameraReference.rotation);
			base.transform.localScale = Vector3.one * num;
			base.NetworkScale = base.transform.localScale;
			base.OnSpawned(admin, arguments);
		}

		public void RefreshRoom()
		{
			if (base.transform.position.TryGetCurrentRoomByBounds(out var room))
			{
				OriginalRoom = room;
			}
		}

		protected override void Start()
		{
			base.Start();
			RefreshRoom();
			SetPrimitive(PrimitiveType.Sphere, PrimitiveType);
		}

		private void SetPrimitive(PrimitiveType _, PrimitiveType newPrim)
		{
			_filter.sharedMesh = PrimitiveTypeToMesh[newPrim];
			if (_collider != null)
			{
				UnityEngine.Object.Destroy(_collider);
			}
			if (newPrim == PrimitiveType.Cube)
			{
				_collider = base.gameObject.AddComponent<BoxCollider>();
			}
			else
			{
				MeshCollider meshCollider = base.gameObject.AddComponent<MeshCollider>();
				bool convex = newPrim != PrimitiveType.Plane && newPrim != PrimitiveType.Quad;
				meshCollider.convex = convex;
				_collider = meshCollider;
			}
			SetColor(Color.clear, MaterialColor);
			SetFlags(PrimitiveFlags.None, PrimitiveFlags);
		}

		private void SetColor(Color _, Color newColor)
		{
			_renderer.sharedMaterial = GetMaterialFromColor(newColor);
		}

		private Material GetMaterialFromColor(Color color)
		{
			if (CachedMaterials.TryGetValue(color, out var value))
			{
				return value;
			}
			value = ((color.a >= 1f) ? new Material(_regularMatTemplate) : new Material(_transparentMatTemplate));
			value.SetColor(BaseColor, color);
			CachedMaterials.Add(color, value);
			return value;
		}

		private void SetFlags(PrimitiveFlags _, PrimitiveFlags newPrimitiveFlags)
		{
			if (_collider != null)
			{
				_collider.enabled = newPrimitiveFlags.HasFlag(PrimitiveFlags.Collidable);
			}
			_renderer.enabled = newPrimitiveFlags.HasFlag(PrimitiveFlags.Visible);
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
				GeneratedNetworkCode._Write_UnityEngine_002EPrimitiveType(writer, PrimitiveType);
				writer.WriteColor(MaterialColor);
				GeneratedNetworkCode._Write_AdminToys_002EPrimitiveFlags(writer, PrimitiveFlags);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				GeneratedNetworkCode._Write_UnityEngine_002EPrimitiveType(writer, PrimitiveType);
			}
			if ((base.syncVarDirtyBits & 0x40L) != 0L)
			{
				writer.WriteColor(MaterialColor);
			}
			if ((base.syncVarDirtyBits & 0x80L) != 0L)
			{
				GeneratedNetworkCode._Write_AdminToys_002EPrimitiveFlags(writer, PrimitiveFlags);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref PrimitiveType, SetPrimitive, GeneratedNetworkCode._Read_UnityEngine_002EPrimitiveType(reader));
				GeneratedSyncVarDeserialize(ref MaterialColor, SetColor, reader.ReadColor());
				GeneratedSyncVarDeserialize(ref PrimitiveFlags, SetFlags, GeneratedNetworkCode._Read_AdminToys_002EPrimitiveFlags(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref PrimitiveType, SetPrimitive, GeneratedNetworkCode._Read_UnityEngine_002EPrimitiveType(reader));
			}
			if ((num & 0x40L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref MaterialColor, SetColor, reader.ReadColor());
			}
			if ((num & 0x80L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref PrimitiveFlags, SetFlags, GeneratedNetworkCode._Read_AdminToys_002EPrimitiveFlags(reader));
			}
		}
	}
}

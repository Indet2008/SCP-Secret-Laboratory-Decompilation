using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace AdminToys
{
	public class CapybaraToy : AdminToyBase
	{
		[SyncVar(hook = "SetCollisionsEnabled")]
		public bool CollisionsEnabled = true;

		private List<Collider> _colliders;

		public override string CommandName => "Capybara";

		public bool NetworkCollisionsEnabled
		{
			get
			{
				return CollisionsEnabled;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref CollisionsEnabled, 32uL, SetCollisionsEnabled);
			}
		}

		public override void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			base.OnSpawned(admin, arguments);
			Vector3 position;
			Quaternion rotation;
			if (admin.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				position = ((!Physics.Raycast(fpcRole.FpcModule.Position, Vector3.down, out var hitInfo, 2f)) ? fpcRole.FpcModule.Position : hitInfo.point);
				rotation = Quaternion.Euler(0f, fpcRole.FpcModule.MouseLook.CurrentHorizontal, 0f);
			}
			else
			{
				admin.transform.GetPositionAndRotation(out position, out rotation);
			}
			base.transform.SetPositionAndRotation(position, Quaternion.Euler(0f, rotation.eulerAngles.y, 0f));
			base.transform.localScale = Vector3.one;
			if (arguments.Count > 1 && bool.TryParse(arguments.ElementAt(1), out var result))
			{
				NetworkCollisionsEnabled = result;
			}
		}

		private void SetCollisionsEnabled(bool _, bool newValue)
		{
			foreach (Collider collider in _colliders)
			{
				collider.enabled = newValue;
			}
		}

		private void Awake()
		{
			_colliders = ListPool<Collider>.Shared.Rent();
			GetComponentsInChildren(includeInactive: true, _colliders);
			SetCollisionsEnabled(_: true, CollisionsEnabled);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			ListPool<Collider>.Shared.Return(_colliders);
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
				writer.WriteBool(CollisionsEnabled);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				writer.WriteBool(CollisionsEnabled);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref CollisionsEnabled, SetCollisionsEnabled, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref CollisionsEnabled, SetCollisionsEnabled, reader.ReadBool());
			}
		}
	}
}

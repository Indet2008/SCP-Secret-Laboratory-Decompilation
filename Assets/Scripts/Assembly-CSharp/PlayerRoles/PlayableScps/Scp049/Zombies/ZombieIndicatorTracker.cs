using System.Collections.Generic;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	// Restored from the client build (IL2CPP): shows the call marker over SCP-049 to its local zombie.
	public class ZombieIndicatorTracker : StandardSubroutine<ZombieRole>
	{
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _effectPrefab;

		private bool _hasInstances;

		private readonly Dictionary<ReferenceHub, GameObject> _instances = new Dictionary<ReferenceHub, GameObject>();

		private static readonly List<ReferenceHub> ToRemove = new List<ReferenceHub>();

		protected override void Awake()
		{
			base.Awake();
			ReferenceHub.OnPlayerRemoved += DestroyIndicator;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (_hasInstances)
			{
				DestroyAll();
			}
		}

		private void Update()
		{
			if (base.Owner != null && base.Owner.isLocalPlayer)
			{
				ValidateAll();
			}
		}

		private Scp049CallAbility GetCallFast(Scp049Role scp049)
		{
			scp049.SubroutineModule.TryGetSubroutine<Scp049CallAbility>(out var call);
			return call;
		}

		private void ValidateAll()
		{
			ToRemove.Clear();
			foreach (KeyValuePair<ReferenceHub, GameObject> instance in _instances)
			{
				if (!ValidatePlayer(instance.Key))
				{
					ToRemove.Add(instance.Key);
				}
			}
			foreach (ReferenceHub hub in ToRemove)
			{
				DestroyIndicator(hub);
			}
			foreach (ReferenceHub hub in ReferenceHub.AllHubs)
			{
				if (ValidatePlayer(hub))
				{
					ShowIndicator(hub);
				}
			}
		}

		private bool ValidatePlayer(ReferenceHub hub)
		{
			if (hub == null || !(hub.roleManager.CurrentRole is Scp049Role scp049))
			{
				return false;
			}
			Scp049CallAbility call = GetCallFast(scp049);
			return call != null && call.IsMarkerShown;
		}

		private void ShowIndicator(ReferenceHub target)
		{
			_hasInstances = true;
			if (!_instances.ContainsKey(target))
			{
				_instances[target] = Object.Instantiate(_effectPrefab, target.transform);
			}
		}

		private void DestroyIndicator(ReferenceHub target)
		{
			if (_instances.TryGetValue(target, out var instance))
			{
				if (instance != null)
				{
					Object.Destroy(instance);
				}
				_instances.Remove(target);
			}
		}

		private void DestroyAll()
		{
			foreach (GameObject instance in _instances.Values)
			{
				if (instance != null)
				{
					Object.Destroy(instance);
				}
			}
			_instances.Clear();
			_hasInstances = false;
		}
	}
}

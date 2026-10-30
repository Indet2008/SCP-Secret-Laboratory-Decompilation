using CustomRendering;
using MapGeneration.StaticHelpers;
using PlayerStatsSystem;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering;

namespace Interactables.Interobjects
{
	public class SqueakInteraction : PopupInterobject, IDestructible, IBlockStaticBatching
	{
		private SqueakSpawner _spawner;

		[SerializeField]
		private TextMeshProUGUI _mouseText;

		[SerializeField]
		private GameObject _mouseGameObject;

		private Volume _tempVolume;

		public uint NetworkId => _spawner.netId;

		public Vector3 CenterOfMass => Vector3.zero;

		public bool Damage(float damage, DamageHandlerBase handler, Vector3 exactHitPos)
		{
			if (!(handler is AttackerDamageHandler attackerDamageHandler) || attackerDamageHandler.Attacker.Hub == null)
			{
				return false;
			}
			_spawner.TargetHitMouse(attackerDamageHandler.Attacker.Hub.networkIdentity.connectionToClient);
			return true;
		}

		protected override void OnClientStateChange()
		{
			switch (CurrentState)
			{
			case PopupState.Off:
				if (_tempVolume != null)
				{
					_mouseGameObject.SetActive(value: true);
					PostProcessingVolumes.DestroyVolume(_tempVolume);
				}
				break;
			case PopupState.Enabling:
			{
				_mouseGameObject.SetActive(value: true);
				Ripples ripples = ScriptableObject.CreateInstance<Ripples>();
				ripples.active = true;
				ripples.Strength.Override(10f);
				ripples.Distance.Override(5f);
				ripples.Width.Override(2f);
				ripples.Height.Override(2f);
				Darken darken = ScriptableObject.CreateInstance<Darken>();
				darken.active = true;
				darken.Intensity.Override(0.9f);
				Vector3 position = ReferenceHub.LocalHub.transform.position;
				TrackedPosition = new Vector4(position.x, position.y, position.z, 0f);
				_tempVolume = PostProcessingVolumes.SafeGetVolume(1, 0f, new VolumeComponent[2] { ripples, darken });
				if (_tempVolume != null)
				{
					_tempVolume.weight = 0f;
				}
				break;
			}
			}
		}

		protected override void OnClientUpdate(float enableRatio)
		{
			_tempVolume.weight = enableRatio;
			Color color = _mouseText.color;
			color.a = enableRatio * 0.5f;
			_mouseText.color = color;
		}

		private void Awake()
		{
			_spawner = GetComponentInParent<SqueakSpawner>();
		}
	}
}

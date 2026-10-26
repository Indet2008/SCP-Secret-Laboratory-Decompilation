using System;
using System.Collections.Generic;
using InventorySystem.Items.Armor;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public class WearableArmor : DisplayableWearableBase
	{
		[Serializable]
		public struct ArmorSet
		{
			public ItemType[] ArmorTypes;

			public PackedArmorPart[] PackedArmorParts;

			public List<ElementBonePair> TrackedBones;

			public List<VisibleElement> VisibleObjects;

			public GameObject[] SimpleModelElements;
		}

		[Serializable]
		public class VisibleElement
		{
			public GameObject Target;

			public HumanBodyBones Parent;

			public bool ScaleToFade;

			private Transform _targetTr;

			private Vector3 _originalScale;

			public void Setup(Animator anim)
			{
				_targetTr = Target.transform;
				if (Parent != HumanBodyBones.LastBone)
				{
					_targetTr.SetParent(anim.GetBoneTransform(Parent));
				}
				if (ScaleToFade)
				{
					_originalScale = _targetTr.localScale;
				}
				Target.SetActive(value: false);
			}

			public void SetScale(float scale)
			{
				_targetTr.localScale = _originalScale * scale;
			}
		}

		[Serializable]
		public class ElementBonePair
		{
			[SerializeField]
			private Transform _target;

			[SerializeField]
			private HumanBodyBones _bone;

			private Transform _boneTr;

			public void Setup(Animator anim)
			{
				_boneTr = anim.GetBoneTransform(_bone);
			}

			public void Track()
			{
				_boneTr.GetPositionAndRotation(out var position, out var rotation);
				_target.SetPositionAndRotation(position, rotation);
			}
		}

		private static readonly Dictionary<Material, Material> NonAllocMaterialCopies = new Dictionary<Material, Material>();

		private static readonly List<Material> NonAllocMatList = new List<Material>();

		private static readonly int FadeHash = Shader.PropertyToID("_Fade");

		private readonly List<GameObject> _activeSimpleElements = new List<GameObject>();

		private readonly List<VisibleElement> _activeVisibleElements = new List<VisibleElement>();

		private readonly List<ElementBonePair> _trackedBones = new List<ElementBonePair>();

		private readonly List<Material> _allFadeableMaterials = new List<Material>();

		private bool _hasCuller;

		private ItemType? _lastArmor;

		[field: SerializeField]
		public ArmorSet[] DefinedSets { get; private set; }

		[field: SerializeField]
		public List<Renderer> FadeableRenderes { get; private set; }

		private ItemType ServerCurArmor
		{
			get
			{
				if (!base.Model.OwnerHub.inventory.TryGetBodyArmor(out var bodyArmor))
				{
					return ItemType.None;
				}
				return bodyArmor.ItemTypeId;
			}
		}

		public override void Initialize(WearableSubcontroller subcontroller)
		{
			base.Initialize(subcontroller);
			InitCuller();
			InitElements();
			InitFadeables();
			SetFade(base.Model.Fade);
			SetArmor(ItemType.None);
		}

		public override void SetFade(float fade)
		{
			foreach (VisibleElement activeVisibleElement in _activeVisibleElements)
			{
				if (activeVisibleElement.ScaleToFade)
				{
					activeVisibleElement.SetScale(fade);
				}
			}
			foreach (Material allFadeableMaterial in _allFadeableMaterials)
			{
				allFadeableMaterial.SetFloat(FadeHash, fade);
			}
		}

		public override void WriteSyncvars(NetworkWriter writer)
		{
			base.WriteSyncvars(writer);
			writer.WriteSByte((sbyte)ServerCurArmor);
		}

		public override void ApplySyncvars(NetworkReader reader)
		{
			base.ApplySyncvars(reader);
			SetArmor((ItemType)reader.ReadSByte());
		}

		public override void OnWornStatusChanged()
		{
			base.OnWornStatusChanged();
			if (!base.IsWorn)
			{
				SetArmor(ItemType.None);
			}
		}

		public override void UpdateVisibility()
		{
			base.UpdateVisibility();
			foreach (VisibleElement activeVisibleElement in _activeVisibleElements)
			{
				activeVisibleElement.Target.SetActive(base.IsVisible);
			}
		}

		private void LateUpdate()
		{
			if (!_hasCuller)
			{
				MatchAllBones();
			}
		}

		private void MatchAllBones()
		{
			MatchBones(0);
		}

		private void MatchBones(int startIndex)
		{
			if (base.IsVisible)
			{
				for (int i = startIndex; i < _trackedBones.Count; i++)
				{
					_trackedBones[i].Track();
				}
			}
		}

		private void SetArmor(ItemType armorType)
		{
			if (_lastArmor == armorType)
			{
				return;
			}
			_lastArmor = armorType;
			foreach (VisibleElement activeVisibleElement in _activeVisibleElements)
			{
				activeVisibleElement.Target.SetActive(value: false);
			}
			foreach (GameObject activeSimpleElement in _activeSimpleElements)
			{
				activeSimpleElement.SetActive(value: false);
			}
			_trackedBones.Clear();
			_activeSimpleElements.Clear();
			_activeVisibleElements.Clear();
			float fade = base.Model.Fade;
			ArmorSet[] definedSets = DefinedSets;
			for (int i = 0; i < definedSets.Length; i++)
			{
				ArmorSet armorSet = definedSets[i];
				if (!armorSet.ArmorTypes.Contains(armorType))
				{
					continue;
				}
				int count = _trackedBones.Count;
				_trackedBones.AddRange(armorSet.TrackedBones);
				MatchBones(count);
				foreach (VisibleElement visibleObject in armorSet.VisibleObjects)
				{
					visibleObject.Target.SetActive(base.IsVisible);
					if (visibleObject.ScaleToFade)
					{
						visibleObject.SetScale(fade);
					}
					_activeVisibleElements.Add(visibleObject);
				}
				GameObject[] simpleModelElements = armorSet.SimpleModelElements;
				foreach (GameObject gameObject in simpleModelElements)
				{
					gameObject.SetActive(value: true);
					_activeSimpleElements.Add(gameObject);
				}
			}
		}

		private void InitCuller()
		{
			if (base.Model.TryGetSubcontroller<CullingSubcontroller>(out var subcontroller))
			{
				_hasCuller = true;
				subcontroller.OnAnimatorUpdated += MatchAllBones;
			}
		}

		private void InitElements()
		{
			Animator animator = base.Animator;
			ArmorSet[] definedSets = DefinedSets;
			for (int i = 0; i < definedSets.Length; i++)
			{
				ArmorSet target = definedSets[i];
				PackedArmorPart[] packedArmorParts = target.PackedArmorParts;
				for (int j = 0; j < packedArmorParts.Length; j++)
				{
					packedArmorParts[j].Unpack(target, FadeableRenderes);
				}
				foreach (VisibleElement visibleObject in target.VisibleObjects)
				{
					visibleObject.Setup(animator);
				}
				foreach (ElementBonePair trackedBone in target.TrackedBones)
				{
					trackedBone.Setup(animator);
				}
				GameObject[] simpleModelElements = target.SimpleModelElements;
				for (int j = 0; j < simpleModelElements.Length; j++)
				{
					simpleModelElements[j].SetActive(!base.Model.HasOwner);
				}
			}
		}

		private void InitFadeables()
		{
			NonAllocMaterialCopies.Clear();
			foreach (Renderer fadeableRendere in FadeableRenderes)
			{
				SetupRendererMatInstances(fadeableRendere);
			}
			_allFadeableMaterials.EnsureCapacity(NonAllocMaterialCopies.Count);
			foreach (KeyValuePair<Material, Material> nonAllocMaterialCopy in NonAllocMaterialCopies)
			{
				_allFadeableMaterials.Add(nonAllocMaterialCopy.Value);
			}
		}

		private void SetupRendererMatInstances(Renderer rend)
		{
			NonAllocMatList.Clear();
			rend.GetSharedMaterials(NonAllocMatList);
			if (NonAllocMatList.Count == 1)
			{
				rend.sharedMaterial = GetOrAddMatInstance(NonAllocMatList[0]);
				return;
			}
			for (int i = 0; i < NonAllocMatList.Count; i++)
			{
				NonAllocMatList[i] = GetOrAddMatInstance(NonAllocMatList[i]);
			}
			rend.SetMaterials(NonAllocMatList);
		}

		private Material GetOrAddMatInstance(Material original)
		{
			if (NonAllocMaterialCopies.TryGetValue(original, out var value))
			{
				return value;
			}
			Material material = new Material(original);
			NonAllocMaterialCopies[original] = material;
			return material;
		}
	}
}

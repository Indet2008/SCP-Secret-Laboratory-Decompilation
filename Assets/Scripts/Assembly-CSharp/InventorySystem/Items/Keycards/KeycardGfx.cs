using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.AutoIcons;
using TMPro;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class KeycardGfx : MonoBehaviour
	{
		private static readonly int TintColorHash = Shader.PropertyToID("_Tint");

		private static readonly int PermsColorHash = Shader.PropertyToID("_PermsColor");

		private static readonly int ContainmentLevelStepHash = Shader.PropertyToID("_ContainmentStep");

		private static readonly int ArmoryLevelStepHash = Shader.PropertyToID("_ArmoryStep");

		private static readonly int AdminLevelStepHash = Shader.PropertyToID("_AdminStep");

		private static readonly int IgnoreDistanceTintHash = Shader.PropertyToID("_IgnoreDistanceTint");

		private static readonly float[] LevelToStep = new float[4] { 1f, 0.45f, 0.1f, 0f };

		private IIdentifierProvider _idProvider;

		private KeycardMaterialHandler _keycardMaterial;

		[SerializeField]
		private Renderer _mainRenderer;

		private IIdentifierProvider IdProvider => _idProvider ?? (_idProvider = GetComponentInParent<IIdentifierProvider>(includeInactive: true));

		private KeycardMaterialHandler Material => _keycardMaterial ?? (_keycardMaterial = new KeycardMaterialHandler(_mainRenderer));

		public ItemIdentifier ParentId => IdProvider.ItemId;

		public bool IsSubjectForIconRendering { get; private set; }

		[field: SerializeField]
		public float ExtraWeight { get; private set; }

		[field: SerializeField]
		public TMP_Text[] KeycardLabels { get; private set; }

		[field: SerializeField]
		public TMP_Text[] NameFields { get; private set; }

		[field: SerializeField]
		public Renderer[] SerialNumberDigits { get; private set; }

		[field: SerializeField]
		public MeshFilter RankFilter { get; private set; }

		[field: SerializeField]
		public GameObject[] ElementVariants { get; private set; }

		public void SetTint(Color color)
		{
			Material instance = Material.Instance;
			instance.SetColor(TintColorHash, color);
			if (IsSubjectForIconRendering)
			{
				instance.SetFloat(IgnoreDistanceTintHash, 1f);
			}
		}

		public void SetAsIconSubject()
		{
			IsSubjectForIconRendering = true;
		}

		public void SetPermissions(KeycardLevels levels, Color color)
		{
			if (!(_mainRenderer == null))
			{
				Material instance = Material.Instance;
				instance.SetFloat(ContainmentLevelStepHash, LevelToStep[levels.Containment]);
				instance.SetFloat(ArmoryLevelStepHash, LevelToStep[levels.Armory]);
				instance.SetFloat(AdminLevelStepHash, LevelToStep[levels.Admin]);
				instance.SetColor(PermsColorHash, color);
			}
		}

		public void OnAllDetailsApplied()
		{
			if (IdProvider is KeycardViewmodel { IsLocal: not false } keycardViewmodel && keycardViewmodel.ParentItem.TryGetComponent<AutoIconApplier>(out var component))
			{
				component.UpdateIcon();
			}
		}

		private void Awake()
		{
			if (base.enabled)
			{
				KeycardDetailSynchronizer.RegisterReceiver(this);
			}
		}

		private void OnDestroy()
		{
			KeycardDetailSynchronizer.UnregisterReceiver(this);
			_keycardMaterial?.Cleanup();
		}
	}
}

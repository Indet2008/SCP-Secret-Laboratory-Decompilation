public class SnowballFlames : global::UnityEngine.MonoBehaviour
{
	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AudioSource _igniteSound;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.ParticleSystem _flames;

	[global::UnityEngine.SerializeField]
	private global::InventorySystem.Items.Thirdperson.ThirdpersonItemBase _thirdpersonItem;

	[global::UnityEngine.SerializeField]
	private global::InventorySystem.Items.ThrowableProjectiles.ThrownProjectile _projectile;

	[global::UnityEngine.SerializeField]
	private global::InventorySystem.Items.ItemViewmodelBase _viewmodel;

	private bool _isIgnited;

	private global::System.Func<ushort> _serialGetter;

	private ushort Serial
	{
		get
		{
			return default;
		}
	}

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void UpdateFlame(bool ignoreAudio)
	{
	}

	public SnowballFlames()
	{
	}
}

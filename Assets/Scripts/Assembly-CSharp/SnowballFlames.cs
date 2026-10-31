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
			if (_serialGetter == null)
			{
				if (_thirdpersonItem != null)
				{
					_serialGetter = () => _thirdpersonItem.ItemId.SerialNumber;
				}
				else if (_projectile != null)
				{
					_serialGetter = () => _projectile.Info.Serial;
				}
				else
				{
					if (!(_viewmodel != null))
					{
						return 0;
					}
					_serialGetter = () => _viewmodel.ItemId.SerialNumber;
				}
			}
			return _serialGetter();
		}
	}

	private void Start()
	{
		UpdateFlame(ignoreAudio: true);
	}

	private void Update()
	{
		UpdateFlame(ignoreAudio: false);
	}

	private void UpdateFlame(bool ignoreAudio)
	{
		bool flag = global::InventorySystem.Items.ThrowableProjectiles.SnowballItem.IsCooked(Serial, _projectile != null);
		if (flag != _isIgnited)
		{
			_isIgnited = flag;
			global::UnityEngine.ParticleSystem.EmissionModule emission = _flames.emission;
			emission.enabled = flag;
			if (flag && !ignoreAudio && _igniteSound != null)
			{
				_igniteSound.Play();
			}
		}
	}

	public SnowballFlames()
	{
	}
}

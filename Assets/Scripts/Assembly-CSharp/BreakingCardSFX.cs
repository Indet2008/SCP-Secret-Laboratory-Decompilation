public class BreakingCardSFX : global::UnityEngine.MonoBehaviour
{
	public string[] texts;

	public string langFile;

	public float waitTime;

	private float _time;

	private int _index;

	private global::TMPro.TMP_Text _txtMeshPro;

	private void Start()
	{
		_txtMeshPro = GetComponent<global::TMPro.TMP_Text>();
		if (!string.IsNullOrEmpty(langFile))
		{
			string[] keys = global::TranslationReader.GetKeys(langFile);
			if (keys.Length > 1)
			{
				texts = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Skip(keys, 1));
			}
		}
	}

	private void FixedUpdate()
	{
		_time += global::UnityEngine.Time.fixedDeltaTime;
		if (!(_time < waitTime))
		{
			_time = 0f;
			_index++;
			if (_index >= texts.Length)
			{
				_index = -1;
			}
			_txtMeshPro.text = ((_index == -1) ? string.Empty : texts[_index]);
		}
	}

	public BreakingCardSFX()
	{
	}
}

namespace OperationalGuide
{
	public class SecretToggle : global::UnityEngine.MonoBehaviour
	{
		public global::UnityEngine.GameObject[] Toggleables;

		public global::OperationalGuide.SecretPhrase SecretPhrase;

		private void Awake()
		{
		}

		private void OnDestroy()
		{
		}

		private void OnSecretChanged(bool status)
		{
		}

		public SecretToggle()
		{
		}
	}
}

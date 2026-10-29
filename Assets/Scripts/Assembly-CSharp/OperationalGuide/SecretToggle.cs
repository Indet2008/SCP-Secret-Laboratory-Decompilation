using System;
using UnityEngine;

namespace OperationalGuide
{
	public class SecretToggle : MonoBehaviour
	{
		public GameObject[] Toggleables;

		public SecretPhrase SecretPhrase;

		private void Awake()
		{
			SecretPhrase secretPhrase = SecretPhrase;
			secretPhrase.OnSecretChanged = (Action<bool>)Delegate.Combine(secretPhrase.OnSecretChanged, new Action<bool>(OnSecretChanged));
		}

		private void OnDestroy()
		{
			SecretPhrase secretPhrase = SecretPhrase;
			secretPhrase.OnSecretChanged = (Action<bool>)Delegate.Remove(secretPhrase.OnSecretChanged, new Action<bool>(OnSecretChanged));
		}

		private void OnSecretChanged(bool state)
		{
			GameObject[] toggleables = Toggleables;
			for (int i = 0; i < toggleables.Length; i++)
			{
				toggleables[i].SetActive(state);
			}
		}
	}
}

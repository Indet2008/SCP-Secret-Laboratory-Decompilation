using System.Collections.Generic;
using AudioPooling;
using MEC;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.UI;

public class YouWereKilled : MonoBehaviour
{
	public static YouWereKilled Singleton;

	[Space]
	public GameObject _root;

	public Text _info;

	private const float DeathBellVolume = 0.85f;

	[SerializeField]
	private AudioClip _deathBell;

	private void Awake()
	{
		Singleton = this;
	}

	public void PlayRegular(DamageHandlerBase hitInfo)
	{
		Timing.RunCoroutine(_Play(hitInfo.DeathScreenText, null, null).CancelWith(base.gameObject), Segment.FixedUpdate);
	}

	public void PlayAttacker(string nickname, RoleTypeId role)
	{
		string attackerRole = (PlayerRoleLoader.TryGetRoleTemplate<PlayerRoleBase>(role, out var result) ? result.RoleName : null);
		Timing.RunCoroutine(_Play(null, nickname, attackerRole).CancelWith(base.gameObject), Segment.FixedUpdate);
	}

	internal IEnumerator<float> _Play(string reason, string attacker, string attackerRole)
	{
		_root.SetActive(true);
		CanvasRenderer[] renderers = _root.GetComponentsInChildren<CanvasRenderer>();
		AudioSourcePoolManager.Play2D(_deathBell, 0.85f);
		if (!string.IsNullOrEmpty(reason))
		{
			_info.text = reason;
		}
		else
		{
			string text = TranslationReader.Get("Legacy_Interfaces", 15);
			string text2 = TranslationReader.Get("Legacy_Interfaces", 16);
			_info.text = "<size=20>" + text + "</size>\n" + attacker + "<size=20>\n" + text2 + "\n</size>" + attackerRole;
		}
		float alpha = 0f;
		while (alpha <= 1f)
		{
			CanvasRenderer[] array = renderers;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetAlpha(alpha);
			}
			alpha += 0.03f;
			yield return float.NegativeInfinity;
		}
		for (int frames = 0; frames < 300; frames++)
		{
			yield return float.NegativeInfinity;
		}
		while (alpha >= 0f)
		{
			alpha -= 0.02f;
			CanvasRenderer[] array = renderers;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetAlpha(alpha);
			}
			yield return float.NegativeInfinity;
		}
		CanvasRenderer[] array2 = renderers;
		for (int i = 0; i < array2.Length; i++)
		{
			array2[i].SetAlpha(0f);
		}
	}
}

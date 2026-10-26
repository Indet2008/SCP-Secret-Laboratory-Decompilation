using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class AlphaWarheadScreen : MonoBehaviour
{
	private static readonly List<AlphaWarheadScreen> Instances = new List<AlphaWarheadScreen>();

	private static string _lastText;

	private static bool _lastInevitable;

	[SerializeField]
	private TMP_Text _text;

	[SerializeField]
	private GameObject[] _inevitable;

	private void Start()
	{
		if (!Instances.Contains(this))
		{
			Instances.Add(this);
		}
		UpdateScreen();
	}

	private void OnDestroy()
	{
		Instances.Remove(this);
	}

	private void UpdateScreen()
	{
		_text.text = _lastText;
		GameObject[] inevitable = _inevitable;
		for (int i = 0; i < inevitable.Length; i++)
		{
			inevitable[i].SetActive(_lastInevitable);
		}
	}

	public static void SetScreen(string text, bool showInevitableWarn)
	{
		_lastText = text;
		_lastInevitable = showInevitableWarn;
		foreach (AlphaWarheadScreen instance in Instances)
		{
			instance.UpdateScreen();
		}
	}
}

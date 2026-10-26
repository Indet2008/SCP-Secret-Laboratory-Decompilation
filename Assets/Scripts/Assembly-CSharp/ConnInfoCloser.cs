using UnityEngine;

public class ConnInfoCloser : ConnInfoButton
{
	public GameObject[] objToClose;

	public override void UseButton()
	{
		GameObject[] array = objToClose;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(value: false);
		}
		base.UseButton();
	}
}

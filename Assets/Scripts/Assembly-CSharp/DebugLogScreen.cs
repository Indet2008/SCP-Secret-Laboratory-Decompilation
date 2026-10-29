using CursorManagement;
using UnityEngine;

public class DebugLogScreen : MonoBehaviour
{
	public GameObject Log;

	public GameObject Info;

	private void OnEnable()
	{
		Info.SetActive(value: true);
		CursorManager.SetLockMode((CursorLockMode)((Log.activeSelf ? 1 : 0) + 1));
	}

	private void OnDisable()
	{
		Info.SetActive(value: false);
		Cursor.lockState = CursorLockMode.Confined;
		Cursor.visible = true;
	}

	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.F4) && DebugLogReader.SuccesfullyInitialized())
		{
			Log.SetActive(!Log.activeSelf);
			CursorManager.SetLockMode((CursorLockMode)((Log.activeSelf ? 1 : 0) + 1));
		}
	}
}

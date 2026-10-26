using System;
using System.ComponentModel;
using System.IO;
using System.Runtime.InteropServices;
using NorthwoodLib;
using UnityEngine;
using UnityEngine.SceneManagement;

public class WindowsUpdateWarning : MonoBehaviour
{
	public GameObject warning;

	public GameObject menu;

	private void Start()
	{
		warning.SetActive(UpdateRequired());
		menu.SetActive(SceneManager.GetActiveScene().buildIndex == 3 || !warning.activeSelf);
	}

	public static bool UpdateRequired()
	{
		try
		{
			int result;
			if (SystemInfo.operatingSystemFamily == OperatingSystemFamily.Windows && NorthwoodLib.OperatingSystem.Version.Major < 10)
			{
				string folderPath = Environment.GetFolderPath(Environment.SpecialFolder.System);
				char directorySeparatorChar = Path.DirectorySeparatorChar;
				if (!File.Exists(folderPath + directorySeparatorChar + "API-MS-WIN-CRT-MATH-L1-1-0.dll"))
				{
					result = ((!CheckDll("API-MS-WIN-CRT-MATH-L1-1-0.dll")) ? 1 : 0);
					goto IL_004b;
				}
			}
			result = 0;
			goto IL_004b;
			IL_004b:
			return (byte)result != 0;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return true;
		}
	}

	private static bool CheckDll(string name)
	{
		IntPtr intPtr = LoadLibrary(name);
		if (intPtr == IntPtr.Zero)
		{
			throw new Win32Exception();
		}
		if (!FreeLibrary(intPtr))
		{
			throw new Win32Exception();
		}
		return true;
	}

	[DllImport("Kernel32.dll", CharSet = CharSet.Unicode, EntryPoint = "LoadLibraryW", SetLastError = true)]
	private static extern IntPtr LoadLibrary(string name);

	[DllImport("Kernel32.dll", SetLastError = true)]
	private static extern bool FreeLibrary(IntPtr library);
}

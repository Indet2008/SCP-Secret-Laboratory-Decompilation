using System;
using System.Runtime.InteropServices;
using System.Threading;
using UnityEngine;

public static class GpuDriver
{
	private const string Library = "GpuDriver.dll";

	private const CallingConvention CallingConv = CallingConvention.StdCall;

	private static string _driverVersion;

	private static readonly object _dataLock = new object();

	public static string DriverVersion
	{
		get
		{
			if (!RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
			{
				return SystemInfo.graphicsDeviceVersion;
			}
			lock (_dataLock)
			{
				if (!string.IsNullOrWhiteSpace(_driverVersion))
				{
					return _driverVersion;
				}
				try
				{
					string gpuName = SystemInfo.graphicsDeviceName;
					Thread thread = new Thread(() =>
					{
						lock (_dataLock)
						{
							IntPtr driverVersion = GetDriverVersion(gpuName);
							if (driverVersion == IntPtr.Zero)
							{
								Debug.LogWarning("GPU Driver version for " + gpuName + " not found!");
								driverVersion = GetDriverVersion(null);
							}
							_driverVersion = Marshal.PtrToStringUni(driverVersion) ?? "Loading failed";
							Free(driverVersion);
							Debug.Log("GPU Driver version: " + _driverVersion);
							MainThreadDispatcher.Dispatch(() =>
							{
								DriverLoaded?.Invoke(_driverVersion);
							});
						}
					});
					thread.IsBackground = true;
					thread.SetApartmentState(ApartmentState.MTA);
					thread.Start();
					return "Loading...";
				}
				catch (Exception message)
				{
					Debug.Log(message);
					return SystemInfo.graphicsDeviceVersion;
				}
			}
		}
	}

	public static event Action<string> DriverLoaded;

	[DllImport("GpuDriver.dll", CallingConvention = CallingConvention.StdCall, EntryPoint = "get_gpu_driver")]
	private static extern IntPtr GetDriverVersion([MarshalAs(UnmanagedType.LPWStr)] string name);

	[DllImport("GpuDriver.dll", CallingConvention = CallingConvention.StdCall, EntryPoint = "free_driver")]
	private static extern void Free(IntPtr version);
}

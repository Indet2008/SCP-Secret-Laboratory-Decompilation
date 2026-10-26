using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;

namespace Windows
{
	public class HeadlessConsole
	{
		private TextWriter oldOutput;

		private const int STD_OUTPUT_HANDLE = -11;

		public void Initialize()
		{
			if (!AttachConsole(uint.MaxValue))
			{
				AllocConsole();
			}
			oldOutput = Console.Out;
			try
			{
				FileStream stream = new FileStream(GetStdHandle(-11), FileAccess.Write);
				Encoding aSCII = Encoding.ASCII;
				Console.SetOut(new StreamWriter(stream, aSCII)
				{
					AutoFlush = true
				});
			}
			catch (Exception ex)
			{
				Debug.Log("Couldn't redirect output: " + ex.Message);
			}
		}

		public void Shutdown()
		{
			Console.SetOut(oldOutput);
			FreeConsole();
		}

		public void SetTitle(string strName)
		{
			SetConsoleTitle(strName);
		}

		[DllImport("kernel32.dll", SetLastError = true)]
		private static extern bool AttachConsole(uint dwProcessId);

		[DllImport("kernel32.dll", SetLastError = true)]
		private static extern bool AllocConsole();

		[DllImport("kernel32.dll", SetLastError = true)]
		private static extern bool FreeConsole();

		[DllImport("kernel32.dll", CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Auto, SetLastError = true)]
		private static extern IntPtr GetStdHandle(int nStdHandle);

		[DllImport("kernel32.dll")]
		private static extern bool SetConsoleTitle(string lpConsoleTitle);
	}
}

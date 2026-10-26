using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using GameCore;
using NorthwoodLib.Pools;
using UnityEngine;

namespace Cmdbinding
{
	public class CmdBinding : MonoBehaviour
	{
		private const string CmdbindingFileName = "SCP Secret Laboratory/cmdbinding.txt";

		public static readonly List<Bind> Bindings;

		public static string FilePath { get; private set; }

		static CmdBinding()
		{
			Bindings = new List<Bind>();
			FilePath = GeneratePath();
			LoadFile();
		}

		public static void AddBinding(KeyCode key, string command, bool allowReplacing = true)
		{
			Bind bind = new Bind(key, command);
			for (int i = 0; i < Bindings.Count; i++)
			{
				if (Bindings[i].Key == key)
				{
					if (allowReplacing)
					{
						Bindings[i] = bind;
					}
					return;
				}
			}
			Bindings.Add(bind);
		}

		public static void RemoveBinding(KeyCode key)
		{
			for (int i = 0; i < Bindings.Count; i++)
			{
				if (Bindings[i].Key == key)
				{
					Bindings.RemoveAt(i);
					break;
				}
			}
		}

		public static void RemoveAllBindings()
		{
			Bindings.Clear();
			SaveChanges();
		}

		public static bool TryGetBind(KeyCode key, out Bind bind)
		{
			for (int i = 0; i < Bindings.Count; i++)
			{
				bind = Bindings[i];
				if (bind.Key == key)
				{
					return true;
				}
			}
			bind = default;
			return false;
		}

		public static void SaveChanges()
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			for (int i = 0; i < Bindings.Count; i++)
			{
				Bind bind = Bindings[i];
				stringBuilder.Append((int)bind.Key);
				stringBuilder.Append(':');
				stringBuilder.Append(bind.Command);
				if (i != Bindings.Count - 1)
				{
					stringBuilder.AppendLine();
				}
			}
			StreamWriter streamWriter = new StreamWriter(FilePath);
			streamWriter.WriteLine(StringBuilderPool.Shared.ToStringReturn(stringBuilder));
			streamWriter.Close();
		}

		public static void LoadFile()
		{
			GameCore.Console.AddLog("Loading cmd bindings...", Color.grey);
			try
			{
				Bindings.Clear();
				if (!File.Exists(FilePath))
				{
					ResetBindings();
				}
				StreamReader streamReader = new StreamReader(FilePath);
				string text;
				while ((text = streamReader.ReadLine()) != null)
				{
					if (!string.IsNullOrEmpty(text) && text.Contains(':'))
					{
						string[] array = text.Split(':');
						if (int.TryParse(array[0], out var result))
						{
							Bind item = new Bind((KeyCode)result, array[1]);
							Bindings.Add(item);
						}
					}
				}
				streamReader.Close();
			}
			catch (Exception ex)
			{
				Debug.Log("Error occurred whilst loading Cmdbindings: " + ex.StackTrace + " - " + ex.Message);
			}
		}

		[Obsolete("This has now been made obsolete by the SSS system.")]
		internal static void SynchronizeKeybind(KeyCode code, string cmd)
		{
		}

		private static void ResetBindings()
		{
			Debug.Log("Resetting Cmdbindings!");
			new StreamWriter(FilePath).Close();
		}

		private static string GeneratePath()
		{
			return Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "SCP Secret Laboratory/cmdbinding.txt");
		}

		private void Update()
		{
			if (Bindings.Count <= 0 || GameCore.Console.Singleton == null)
			{
				return;
			}
			foreach (Bind binding in Bindings)
			{
				if (Input.GetKeyDown(binding.Key))
				{
					GameCore.Console.Singleton.TypeCommand(binding.Command);
				}
			}
		}
	}
}

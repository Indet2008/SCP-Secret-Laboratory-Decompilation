using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using GameCore;
using NorthwoodLib.Pools;

public static class FileManager
{
	private static string _appfolder = "";

	private static string _configfolder = "";

	public static void RefreshAppFolder()
	{
		_appfolder = ((ServerStatic.IsDedicated && ConfigFile.HosterPolicy != null && ConfigFile.HosterPolicy.GetBool("gamedir_for_configs")) ? "AppData" : (Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + GetPathSeparator() + "SCP Secret Laboratory"));
	}

	public static string GetAppFolder(bool addSeparator = true, bool serverConfig = false, string centralConfig = "")
	{
		if (string.IsNullOrEmpty(_appfolder))
		{
			RefreshAppFolder();
		}
		if (serverConfig && !string.IsNullOrEmpty(_configfolder) && string.IsNullOrEmpty(centralConfig))
		{
			return _configfolder + (addSeparator ? GetPathSeparator().ToString() : "");
		}
		return _appfolder + ((addSeparator | serverConfig) ? GetPathSeparator().ToString() : "") + (serverConfig ? ("config/" + ((!string.IsNullOrEmpty(centralConfig)) ? centralConfig : (ServerStatic.IsDedicated ? ServerStatic.ServerPort.ToString() : "nondedicated")) + (addSeparator ? GetPathSeparator().ToString() : "")) : "");
	}

	public static string StripPath(string path)
	{
		path = path.Replace("\"", "").Trim();
		while (path.EndsWith("\\") || path.EndsWith("/") || path.EndsWith(GetPathSeparator().ToString()))
		{
			path = path.Substring(0, path.Length - 1);
		}
		return path;
	}

	public static void SetAppFolder(string path)
	{
		path = StripPath(path);
		if (!Directory.Exists(path))
		{
			_appfolder = "";
		}
		else
		{
			_appfolder = path;
		}
	}

	public static void SetConfigFolder(string path)
	{
		path = StripPath(path);
		if (!Directory.Exists(path))
		{
			_configfolder = "";
		}
		else
		{
			_configfolder = path;
		}
	}

	public static string ReplacePathSeparators(string path)
	{
		return path.Replace('/', GetPathSeparator()).Replace('\\', GetPathSeparator());
	}

	public static char GetPathSeparator()
	{
		return Path.DirectorySeparatorChar;
	}

	public static bool FileExists(string path)
	{
		return File.Exists(path);
	}

	public static bool DictionaryExists(string path)
	{
		return Directory.Exists(path);
	}

	public static void FileCreate(string path)
	{
		File.Create(path).Dispose();
	}

	public static FileStream FileStreamCreate(string path)
	{
		return File.Create(path);
	}

	public static string[] ReadAllLines(string path)
	{
		List<string> list = ListPool<string>.Shared.Rent();
		using (StreamReader streamReader = new StreamReader(path))
		{
			string item;
			while ((item = streamReader.ReadLine()) != null)
			{
				list.Add(item);
			}
		}
		string[] result = list.ToArray();
		ListPool<string>.Shared.Return(list);
		return result;
	}

	public static List<string> ReadAllLinesList(string path)
	{
		List<string> list = new List<string>();
		using StreamReader streamReader = new StreamReader(path);
		string item;
		while ((item = streamReader.ReadLine()) != null)
		{
			list.Add(item);
		}
		return list;
	}

	public static void ReadAllLinesList(string path, List<string> list)
	{
		list.Clear();
		using StreamReader streamReader = new StreamReader(path);
		string item;
		while ((item = streamReader.ReadLine()) != null)
		{
			list.Add(item);
		}
	}

	public static string[] ReadAllLinesSafe(string path)
	{
		List<string> list = ListPool<string>.Shared.Rent();
		using (FileStream stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			using StreamReader streamReader = new StreamReader(stream);
			string item;
			while ((item = streamReader.ReadLine()) != null)
			{
				list.Add(item);
			}
		}
		string[] result = list.ToArray();
		ListPool<string>.Shared.Return(list);
		return result;
	}

	public static List<string> ReadAllLinesSafeList(string path)
	{
		List<string> list = new List<string>();
		using FileStream stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
		using StreamReader streamReader = new StreamReader(stream);
		string item;
		while ((item = streamReader.ReadLine()) != null)
		{
			list.Add(item);
		}
		return list;
	}

	public static void ReadAllLinesSafeList(string path, List<string> list)
	{
		list.Clear();
		using FileStream stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
		using StreamReader streamReader = new StreamReader(stream);
		string item;
		while ((item = streamReader.ReadLine()) != null)
		{
			list.Add(item);
		}
	}

	public static string ReadAllText(string path)
	{
		return File.ReadAllText(path);
	}

	public static string ReadAllTextSafe(string path)
	{
		using FileStream stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
		using StreamReader streamReader = new StreamReader(stream);
		return streamReader.ReadToEnd();
	}

	public static void WriteToFile(IEnumerable<string> data, string path, bool removeempty = false)
	{
		File.WriteAllLines(path, removeempty ? data.Where((string line) => !string.IsNullOrWhiteSpace(line.Replace(Environment.NewLine, "").Replace("\r\n", "").Replace("\n", "")
			.Replace(" ", ""))) : data, Misc.Utf8Encoding);
	}

	public static void WriteStringToFile(string data, string path)
	{
		File.WriteAllText(path, data, Misc.Utf8Encoding);
	}

	public static void WriteToFileSafe(IEnumerable<string> data, string path, bool removeempty = false)
	{
		using FileStream stream = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write, FileShare.ReadWrite);
		using StreamWriter streamWriter = new StreamWriter(stream, Misc.Utf8Encoding);
		streamWriter.Write(string.Join("\r\n", data));
	}

	public static void WriteStringToFileSafe(string data, string path)
	{
		using FileStream stream = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write, FileShare.ReadWrite);
		using StreamWriter streamWriter = new StreamWriter(stream, Misc.Utf8Encoding);
		streamWriter.Write(data);
	}

	public static void AppendFile(string data, string path, bool newLine = true)
	{
		string[] array = ReadAllLines(path);
		if (!newLine || array.Length == 0 || array[^1].EndsWith(Environment.NewLine) || array[^1].EndsWith("\n"))
		{
			File.AppendAllText(path, data, Misc.Utf8Encoding);
		}
		else
		{
			File.AppendAllText(path, Environment.NewLine + data, Misc.Utf8Encoding);
		}
	}

	public static void AppendFileSafe(string data, string path, bool newLine = true)
	{
		using FileStream stream = new FileStream(path, FileMode.Append, FileAccess.Write, FileShare.ReadWrite);
		using StreamWriter streamWriter = new StreamWriter(stream, Misc.Utf8Encoding);
		streamWriter.Write(newLine ? ("\r\n" + data) : data);
	}

	public static void RenameFile(string path, string newpath)
	{
		File.Move(path, newpath);
	}

	public static void DeleteFile(string path)
	{
		File.Delete(path);
	}

	public static void ReplaceLine(int line, string text, string path)
	{
		string[] array = ReadAllLines(path);
		array[line] = text;
		WriteToFile(array, path);
	}

	public static void RemoveEmptyLines(string path)
	{
		string[] array = ReadAllLines(path);
		string[] array2 = array.Where((string s) => !string.IsNullOrWhiteSpace(s.Replace(Environment.NewLine, "").Replace("\r\n", "").Replace("\n", "")
			.Replace(" ", ""))).ToArray();
		if (array != array2)
		{
			WriteToFile(array2, path);
		}
	}

	private static void DirectoryCopy(string sourceDirName, string destDirName, bool copySubDirs = true, bool overwrite = true)
	{
		DirectoryInfo directoryInfo = new DirectoryInfo(sourceDirName);
		if (!directoryInfo.Exists)
		{
			throw new DirectoryNotFoundException("Source directory does not exist or could not be found: " + sourceDirName);
		}
		DirectoryInfo[] directories = directoryInfo.GetDirectories();
		if (Directory.Exists(destDirName))
		{
			Directory.Delete(destDirName, recursive: true);
		}
		Directory.CreateDirectory(destDirName);
		FileInfo[] files = directoryInfo.GetFiles();
		foreach (FileInfo fileInfo in files)
		{
			string destFileName = Path.Combine(destDirName, fileInfo.Name);
			fileInfo.CopyTo(destFileName, overwrite);
		}
		if (copySubDirs)
		{
			DirectoryInfo[] array = directories;
			foreach (DirectoryInfo directoryInfo2 in array)
			{
				string destDirName2 = Path.Combine(destDirName, directoryInfo2.Name);
				DirectoryCopy(directoryInfo2.FullName, destDirName2, overwrite);
			}
		}
	}
}

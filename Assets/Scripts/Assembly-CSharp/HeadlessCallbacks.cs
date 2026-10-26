using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using UnityEngine;

public class HeadlessCallbacks : Attribute
{
	private static IEnumerable callbackRegistry;

	public static void FindCallbacks()
	{
		if (callbackRegistry != null)
		{
			return;
		}
		try
		{
			callbackRegistry = from t in Assembly.GetExecutingAssembly().GetTypes()
				let attributes = t.GetCustomAttributes(typeof(HeadlessCallbacks), inherit: true)
				where attributes != null && attributes.Length != 0
				select t;
		}
		catch (ReflectionTypeLoadException ex)
		{
			try
			{
				callbackRegistry = ex.Types.Where((Type t) => t != null);
			}
			catch (Exception ex2)
			{
				Debug.Log("Headless Builder could not find callbacks (" + ex2.GetType().Name + "), but will still continue as planned");
				callbackRegistry = Enumerable.Empty<Type>();
			}
		}
		catch (Exception ex3)
		{
			Debug.Log("Headless Builder could not find callbacks (" + ex3.GetType().Name + "), but will still continue as planned");
			callbackRegistry = Enumerable.Empty<Type>();
		}
	}

	public static void InvokeCallbacks(string callbackName)
	{
		FindCallbacks();
		foreach (Type item in callbackRegistry)
		{
			MethodInfo method = item.GetMethod(callbackName);
			if (method != null)
			{
				try
				{
					method.Invoke(item, null);
				}
				catch (Exception message)
				{
					Debug.LogError(message);
				}
			}
		}
	}
}

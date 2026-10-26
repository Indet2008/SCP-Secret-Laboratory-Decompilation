using System;
using System.Collections;
using System.Reflection;
using System.Text;
using Org.BouncyCastle.Security;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin.Stripdown
{
	public static class StripdownProcessor
	{
		private static readonly StringBuilder ReturnSb = new StringBuilder();

		private static object[] _selections;

		private static Type _selectedType;

		private const BindingFlags SearchFlags = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

		private static string PrintMembers(object obj, MemberInfo[] infos)
		{
			if (obj == null)
			{
				return "null";
			}
			ReturnSb.Clear();
			foreach (MemberInfo memberInfo in infos)
			{
				ReturnSb.Append(memberInfo.Name);
				ReturnSb.Append("=\"");
				if (memberInfo is FieldInfo fieldInfo)
				{
					ReturnSb.Append(PrintObjToString(fieldInfo.GetValue(obj)));
				}
				else
				{
					if (!(memberInfo is PropertyInfo propertyInfo))
					{
						throw new InvalidOperationException("Member " + memberInfo.Name + " is not a value provider!");
					}
					ReturnSb.Append(PrintObjToString(propertyInfo.GetValue(obj)));
				}
				ReturnSb.Append("\"; ");
			}
			return ReturnSb.ToString();
		}

		private static string PrintObjToString(object obj)
		{
			if (!(obj is ICollection collection))
			{
				return obj.ToString();
			}
			string text = "Collection {Cnt=" + collection.Count;
			foreach (object item in collection)
			{
				text = text + ", " + item.ToString();
			}
			return text + "}";
		}

		private static MemberInfo GetValueMemberByName(string name)
		{
			MemberInfo memberInfo = (MemberInfo)(((object)_selectedType.GetField(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)) ?? ((object)_selectedType.GetProperty(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)));
			if (memberInfo != null)
			{
				return memberInfo;
			}
			ReturnSb.Clear();
			ReturnSb.Append("Value " + name + " not found. Available values:");
			_selectedType.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).ForEach((FieldInfo x) =>
			{
				ReturnSb.AppendLine(x.Name);
			});
			_selectedType.GetProperties(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic).ForEach((PropertyInfo x) =>
			{
				ReturnSb.AppendLine(x.Name);
			});
			throw new InvalidParameterException(ReturnSb.ToString());
		}

		public static int SelectUnityObjects(string typeName)
		{
			_selectedType = Type.GetType(typeName, throwOnError: true, ignoreCase: true);
			object[] selections = UnityEngine.Object.FindObjectsOfType(_selectedType);
			_selections = selections;
			return _selections.Length;
		}

		public static void SelectValues(string valueName)
		{
			MemberInfo valueMemberByName = GetValueMemberByName(valueName);
			int num = _selections.Length;
			object[] array = new object[num];
			Array.Copy(_selections, array, num);
			_selections = new object[num];
			if (valueMemberByName is PropertyInfo propertyInfo)
			{
				_selectedType = propertyInfo.PropertyType;
				for (int i = 0; i < num; i++)
				{
					_selections[i] = propertyInfo.GetValue(array[i]);
				}
			}
			else if (valueMemberByName is FieldInfo fieldInfo)
			{
				_selectedType = fieldInfo.FieldType;
				for (int j = 0; j < num; j++)
				{
					_selections[j] = fieldInfo.GetValue(array[j]);
				}
			}
		}

		public static void SelectComponent(string componentName)
		{
			int num = _selections.Length;
			object[] array = new object[num];
			Array.Copy(_selections, array, num);
			_selections = new object[num];
			for (int i = 0; i < num; i++)
			{
				object obj = array[i];
				GameObject gameObject = null;
				if (obj is GameObject gameObject2)
				{
					gameObject = gameObject2;
				}
				else
				{
					if (!(obj is Component component))
					{
						throw new InvalidOperationException("Currently selected object type (" + obj.GetType().FullName + ") does not support GetComponent.");
					}
					gameObject = component.gameObject;
				}
				Component component2 = gameObject.GetComponent(componentName);
				if (component2 == null)
				{
					ReturnSb.Clear();
					ReturnSb.Append("GameObject " + gameObject.name + " does not have a " + componentName + " component.");
					ReturnSb.AppendLine("List of compoenents:");
					gameObject.GetComponents<Component>().ForEach((Component x) =>
					{
						ReturnSb.AppendLine(x.GetType().Name);
					});
					throw new InvalidParameterException(ReturnSb.ToString());
				}
				_selections[i] = component2;
			}
		}

		public static string[] Print(params string[] valueNames)
		{
			if (_selections == null || _selections.Length == 0)
			{
				throw new InvalidOperationException("No objects selected!");
			}
			int num = _selections.Length;
			int num2 = valueNames.Length;
			MemberInfo[] array = new MemberInfo[num2];
			for (int i = 0; i < num2; i++)
			{
				array[i] = GetValueMemberByName(valueNames[i]);
			}
			string[] array2 = new string[num];
			for (int j = 0; j < num; j++)
			{
				string text;
				try
				{
					text = PrintMembers(_selections[j], array);
				}
				catch (Exception ex)
				{
					text = ex.Message;
				}
				array2[j] = text;
			}
			return array2;
		}
	}
}

using System;
using System.Collections.Generic;
using UnityEngine;
using Utf8Json.Formatters;

namespace Utf8Json.Unity
{
	internal static class UnityResolverGetFormatterHelper
	{
		private static readonly Dictionary<Type, int> lookup;

		static UnityResolverGetFormatterHelper()
		{
			lookup = new Dictionary<Type, int>(7)
			{
				{
					typeof(Vector2),
					0
				},
				{
					typeof(Vector3),
					1
				},
				{
					typeof(Vector4),
					2
				},
				{
					typeof(Quaternion),
					3
				},
				{
					typeof(Color),
					4
				},
				{
					typeof(Bounds),
					5
				},
				{
					typeof(Rect),
					6
				},
				{
					typeof(Vector2[]),
					7
				},
				{
					typeof(Vector3[]),
					8
				},
				{
					typeof(Vector4[]),
					9
				},
				{
					typeof(Quaternion[]),
					10
				},
				{
					typeof(Color[]),
					11
				},
				{
					typeof(Bounds[]),
					12
				},
				{
					typeof(Rect[]),
					13
				},
				{
					typeof(Vector2?),
					14
				},
				{
					typeof(Vector3?),
					15
				},
				{
					typeof(Vector4?),
					16
				},
				{
					typeof(Quaternion?),
					17
				},
				{
					typeof(Color?),
					18
				},
				{
					typeof(Bounds?),
					19
				},
				{
					typeof(Rect?),
					20
				}
			};
		}

		internal static object GetFormatter(Type t)
		{
			if (!lookup.TryGetValue(t, out var value))
			{
				return null;
			}
			return value switch
			{
				0 => new Vector2Formatter(), 
				1 => new Vector3Formatter(), 
				2 => new Vector4Formatter(), 
				3 => new QuaternionFormatter(), 
				4 => new ColorFormatter(), 
				5 => new BoundsFormatter(), 
				6 => new RectFormatter(), 
				7 => new ArrayFormatter<Vector2>(), 
				8 => new ArrayFormatter<Vector3>(), 
				9 => new ArrayFormatter<Vector4>(), 
				10 => new ArrayFormatter<Quaternion>(), 
				11 => new ArrayFormatter<Color>(), 
				12 => new ArrayFormatter<Bounds>(), 
				13 => new ArrayFormatter<Rect>(), 
				14 => new StaticNullableFormatter<Vector2>(new Vector2Formatter()), 
				15 => new StaticNullableFormatter<Vector3>(new Vector3Formatter()), 
				16 => new StaticNullableFormatter<Vector4>(new Vector4Formatter()), 
				17 => new StaticNullableFormatter<Quaternion>(new QuaternionFormatter()), 
				18 => new StaticNullableFormatter<Color>(new ColorFormatter()), 
				19 => new StaticNullableFormatter<Bounds>(new BoundsFormatter()), 
				20 => new StaticNullableFormatter<Rect>(new RectFormatter()), 
				_ => null, 
			};
		}
	}
}

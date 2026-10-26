using System;

namespace Utf8Json
{
	[AttributeUsage(AttributeTargets.Constructor, AllowMultiple = false, Inherited = true)]
	public class SerializationConstructorAttribute : Attribute
	{
	}
}

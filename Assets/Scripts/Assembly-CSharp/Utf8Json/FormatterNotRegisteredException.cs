using System;

namespace Utf8Json
{
	public class FormatterNotRegisteredException : Exception
	{
		public FormatterNotRegisteredException(string message)
			: base(message)
		{
		}
	}
}

using System;
using System.Runtime.Serialization;
using System.Security.Permissions;

namespace LiteNetLib4Mirror.Open.Nat
{
	[Serializable]
	public class MappingException : Exception
	{
		public int ErrorCode { get; private set; }

		public string ErrorText { get; private set; }

		internal MappingException()
		{
		}

		internal MappingException(string message)
			: base(message)
		{
		}

		internal MappingException(int errorCode, string errorText)
			: base($"Error {errorCode}: {errorText}")
		{
			ErrorCode = errorCode;
			ErrorText = errorText;
		}

		internal MappingException(string message, Exception innerException)
			: base(message, innerException)
		{
		}

		protected MappingException(SerializationInfo info, StreamingContext context)
			: base(info, context)
		{
		}

		[SecurityPermission(SecurityAction.Demand, SerializationFormatter = true)]
		public override void GetObjectData(SerializationInfo info, StreamingContext context)
		{
			if (info == null)
			{
				throw new ArgumentNullException("info");
			}
			ErrorCode = info.GetInt32("errorCode");
			ErrorText = info.GetString("errorText");
			base.GetObjectData(info, context);
		}
	}
}

using System;
using YamlDotNet.Core;
using YamlDotNet.Serialization;

namespace Serialization
{
	internal sealed class CommentsObjectDescriptor : IObjectDescriptor
	{
		private readonly IObjectDescriptor _innerDescriptor;

		public string Comment { get; private set; }

		public object Value => _innerDescriptor.Value;

		public Type Type => _innerDescriptor.Type;

		public Type StaticType => _innerDescriptor.StaticType;

		public ScalarStyle ScalarStyle => _innerDescriptor.ScalarStyle;

		public CommentsObjectDescriptor(IObjectDescriptor innerDescriptor, string comment)
		{
			_innerDescriptor = innerDescriptor;
			Comment = comment;
		}
	}
}

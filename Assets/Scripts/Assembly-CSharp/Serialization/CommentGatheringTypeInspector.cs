using System;
using System.Collections.Generic;
using System.Linq;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.TypeInspectors;

namespace Serialization
{
	public class CommentGatheringTypeInspector : TypeInspectorSkeleton
	{
		private readonly ITypeInspector _innerTypeDescriptor;

		public CommentGatheringTypeInspector(ITypeInspector innerTypeDescriptor)
		{
			_innerTypeDescriptor = innerTypeDescriptor ?? throw new ArgumentNullException("innerTypeDescriptor");
		}

		public override IEnumerable<IPropertyDescriptor> GetProperties(Type type, object container)
		{
			return from descriptor in _innerTypeDescriptor.GetProperties(type, container)
				select new CommentsPropertyDescriptor(descriptor);
		}
	}
}

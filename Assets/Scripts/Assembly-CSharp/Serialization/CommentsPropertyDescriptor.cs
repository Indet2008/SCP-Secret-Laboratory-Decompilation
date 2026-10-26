using System;
using System.ComponentModel;
using YamlDotNet.Core;
using YamlDotNet.Serialization;

namespace Serialization
{
	internal sealed class CommentsPropertyDescriptor : IPropertyDescriptor
	{
		private readonly IPropertyDescriptor _baseDescriptor;

		public string Name { get; set; }

		public Type Type => _baseDescriptor.Type;

		public Type TypeOverride
		{
			get
			{
				return _baseDescriptor.TypeOverride;
			}
			set
			{
				_baseDescriptor.TypeOverride = value;
			}
		}

		public int Order { get; set; }

		public ScalarStyle ScalarStyle
		{
			get
			{
				return _baseDescriptor.ScalarStyle;
			}
			set
			{
				_baseDescriptor.ScalarStyle = value;
			}
		}

		public bool CanWrite => _baseDescriptor.CanWrite;

		public CommentsPropertyDescriptor(IPropertyDescriptor baseDescriptor)
		{
			_baseDescriptor = baseDescriptor;
			Name = baseDescriptor.Name;
		}

		public void Write(object target, object value)
		{
			_baseDescriptor.Write(target, value);
		}

		public T GetCustomAttribute<T>() where T : Attribute
		{
			return _baseDescriptor.GetCustomAttribute<T>();
		}

		public IObjectDescriptor Read(object target)
		{
			DescriptionAttribute customAttribute = _baseDescriptor.GetCustomAttribute<DescriptionAttribute>();
			if (customAttribute == null)
			{
				return _baseDescriptor.Read(target);
			}
			return new CommentsObjectDescriptor(_baseDescriptor.Read(target), customAttribute.Description);
		}
	}
}

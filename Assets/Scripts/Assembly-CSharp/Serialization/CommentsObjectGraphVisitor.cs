using YamlDotNet.Core;
using YamlDotNet.Core.Events;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.ObjectGraphVisitors;

namespace Serialization
{
	public class CommentsObjectGraphVisitor : ChainedObjectGraphVisitor
	{
		public CommentsObjectGraphVisitor(IObjectGraphVisitor<IEmitter> nextVisitor)
			: base(nextVisitor)
		{
		}

		public override bool EnterMapping(IPropertyDescriptor key, IObjectDescriptor value, IEmitter context)
		{
			if (value is CommentsObjectDescriptor { Comment: not null } commentsObjectDescriptor)
			{
				context.Emit(new Comment(commentsObjectDescriptor.Comment, isInline: false));
			}
			return base.EnterMapping(key, value, context);
		}
	}
}

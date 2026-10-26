using System;
using System.Reflection.Emit;

namespace Utf8Json.Internal.Emit
{
	internal class StringConstantValueMetaMember : MetaMember
	{
		private readonly string constant;

		public StringConstantValueMetaMember(string name, string constant)
			: base(typeof(string), name, name, isWritable: false, isReadable: true)
		{
			this.constant = constant;
		}

		public override void EmitLoadValue(ILGenerator il)
		{
			il.Emit(OpCodes.Pop);
			il.Emit(OpCodes.Ldstr, constant);
		}

		public override void EmitStoreValue(ILGenerator il)
		{
			throw new NotSupportedException();
		}
	}
}

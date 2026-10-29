using System;

namespace Hints
{
	public abstract class FormattableHint<THint> : Hint where THint : FormattableHint<THint>
	{
		private THint _genericThis;

		private Func<THint, float, string> _formattedTextStrategy;

		protected abstract Func<THint, float, string> FormattedTextStrategy { get; }

		protected FormattableHint(HintParameter[] parameters, HintEffect[] effects, float durationScalar = 1f)
			: base(parameters, effects, durationScalar)
		{
		}

		protected override void Start()
		{
			_genericThis = (this as THint) ?? throw new InvalidOperationException("The generic argument of FormattableHint must be itself.");
			_formattedTextStrategy = FormattedTextStrategy;
			base.Start();
		}

		protected override void Destroy()
		{
			base.Destroy();
			base.Data.Textbox.text = string.Empty;
		}

		protected override string UpdateContent(float progress)
		{
			return _formattedTextStrategy(_genericThis, progress);
		}
	}
}

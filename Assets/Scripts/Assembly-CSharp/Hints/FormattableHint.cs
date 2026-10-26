namespace Hints
{
	public abstract class FormattableHint<THint> : Hint where THint : FormattableHint<THint>
	{
		protected FormattableHint(HintParameter[] parameters, HintEffect[] effects, float durationScalar = 1f)
			: base(parameters, effects, durationScalar)
		{
		}
	}
}

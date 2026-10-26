namespace Utf8Json.Internal.DoubleConversion
{
	internal struct CachedPower
	{
		public readonly ulong significand;

		public readonly short binary_exponent;

		public readonly short decimal_exponent;

		public CachedPower(ulong significand, short binary_exponent, short decimal_exponent)
		{
			this.significand = significand;
			this.binary_exponent = binary_exponent;
			this.decimal_exponent = decimal_exponent;
		}
	}
}

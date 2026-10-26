using System;
using Hints;
using Mirror;
using UnityEngine;

namespace Utils.Networking
{
	public static class HintParameterReaderWriter
	{
		public enum HintParameterType : byte
		{
			Text = 0,
			Timespan = 1,
			Ammo = 2,
			Item = 3,
			ItemCategory = 4,
			Byte = 5,
			SByte = 6,
			Short = 7,
			UShort = 8,
			Int = 9,
			UInt = 10,
			Long = 11,
			ULong = 12,
			Float = 13,
			Double = 14,
			PackedLong = 15,
			PackedULong = 16,
			Scp330Hint = 17,
			SSKeybind = 18,
			AnimationCurve = 19
		}

		public static HintParameter ReadHintParameter(this NetworkReader reader)
		{
			byte b = reader.ReadByte();
			Func<NetworkReader, HintParameter> func;
			switch ((HintParameterType)b)
			{
			case HintParameterType.Text:
				func = StringHintParameter.FromNetwork;
				break;
			case HintParameterType.Timespan:
				func = TimespanHintParameter.FromNetwork;
				break;
			case HintParameterType.Ammo:
				func = AmmoHintParameter.FromNetwork;
				break;
			case HintParameterType.Item:
				func = ItemHintParameter.FromNetwork;
				break;
			case HintParameterType.ItemCategory:
				func = ItemCategoryHintParameter.FromNetwork;
				break;
			case HintParameterType.Byte:
				func = ByteHintParameter.FromNetwork;
				break;
			case HintParameterType.SByte:
				func = SByteHintParameter.FromNetwork;
				break;
			case HintParameterType.Short:
				func = ShortHintParameter.FromNetwork;
				break;
			case HintParameterType.UShort:
				func = UShortHintParameter.FromNetwork;
				break;
			case HintParameterType.Int:
				func = IntHintParameter.FromNetwork;
				break;
			case HintParameterType.UInt:
				func = UIntHintParameter.FromNetwork;
				break;
			case HintParameterType.Long:
				func = LongHintParameter.FromNetwork;
				break;
			case HintParameterType.ULong:
				func = ULongHintParameter.FromNetwork;
				break;
			case HintParameterType.Float:
				func = FloatHintParameter.FromNetwork;
				break;
			case HintParameterType.Double:
				func = DoubleHintParameter.FromNetwork;
				break;
			case HintParameterType.PackedLong:
				func = PackedLongHintParameter.FromNetwork;
				break;
			case HintParameterType.PackedULong:
				func = PackedULongHintParameter.FromNetwork;
				break;
			case HintParameterType.Scp330Hint:
				func = Scp330HintParameter.FromNetwork;
				break;
			case HintParameterType.SSKeybind:
				func = SSKeybindHintParameter.FromNetwork;
				break;
			case HintParameterType.AnimationCurve:
				func = AnimationCurveHintParameter.FromNetwork;
				break;
			default:
				Debug.LogWarning($"Received malformed hint parameter (type {b}).");
				return null;
			}
			return func(reader);
		}

		public static void WriteHintParameter(this NetworkWriter writer, HintParameter parameter)
		{
			if (parameter == null)
			{
				throw new ArgumentNullException("parameter");
			}
			HintParameterType value;
			if (!(parameter is StringHintParameter))
			{
				if (!(parameter is TimespanHintParameter))
				{
					if (!(parameter is AmmoHintParameter))
					{
						if (!(parameter is ItemHintParameter))
						{
							if (!(parameter is ItemCategoryHintParameter))
							{
								if (!(parameter is ByteHintParameter))
								{
									if (!(parameter is SByteHintParameter))
									{
										if (!(parameter is ShortHintParameter))
										{
											if (!(parameter is UShortHintParameter))
											{
												if (!(parameter is IntHintParameter))
												{
													if (!(parameter is UIntHintParameter))
													{
														if (!(parameter is LongHintParameter))
														{
															if (!(parameter is ULongHintParameter))
															{
																if (!(parameter is FloatHintParameter))
																{
																	if (!(parameter is DoubleHintParameter))
																	{
																		if (!(parameter is PackedLongHintParameter))
																		{
																			if (!(parameter is PackedULongHintParameter))
																			{
																				if (!(parameter is Scp330HintParameter))
																				{
																					if (!(parameter is SSKeybindHintParameter))
																					{
																						if (!(parameter is AnimationCurveHintParameter))
																						{
																							throw new ArgumentException("Hint parameter was of an unknown type. This type should be added to the pattern switch (needed for polymorphism to work).", "parameter");
																						}
																						value = HintParameterType.AnimationCurve;
																					}
																					else
																					{
																						value = HintParameterType.SSKeybind;
																					}
																				}
																				else
																				{
																					value = HintParameterType.Scp330Hint;
																				}
																			}
																			else
																			{
																				value = HintParameterType.PackedULong;
																			}
																		}
																		else
																		{
																			value = HintParameterType.PackedLong;
																		}
																	}
																	else
																	{
																		value = HintParameterType.Double;
																	}
																}
																else
																{
																	value = HintParameterType.Float;
																}
															}
															else
															{
																value = HintParameterType.ULong;
															}
														}
														else
														{
															value = HintParameterType.Long;
														}
													}
													else
													{
														value = HintParameterType.UInt;
													}
												}
												else
												{
													value = HintParameterType.Int;
												}
											}
											else
											{
												value = HintParameterType.UShort;
											}
										}
										else
										{
											value = HintParameterType.Short;
										}
									}
									else
									{
										value = HintParameterType.SByte;
									}
								}
								else
								{
									value = HintParameterType.Byte;
								}
							}
							else
							{
								value = HintParameterType.ItemCategory;
							}
						}
						else
						{
							value = HintParameterType.Item;
						}
					}
					else
					{
						value = HintParameterType.Ammo;
					}
				}
				else
				{
					value = HintParameterType.Timespan;
				}
			}
			else
			{
				value = HintParameterType.Text;
			}
			writer.WriteByte((byte)value);
			parameter.Serialize(writer);
		}
	}
}

using System;

namespace InventorySystem.Items.Firearms.Attachments
{
	[Serializable]
	public class AttachmentSettings
	{
		public float Weight;

		public float PhysicalLength;

		public AttachmentParameterValuePair[] SerializedParameters;

		public AttachmentDescriptiveAdvantages AdditionalPros;

		public AttachmentDescriptiveDownsides AdditionalCons;
	}
}

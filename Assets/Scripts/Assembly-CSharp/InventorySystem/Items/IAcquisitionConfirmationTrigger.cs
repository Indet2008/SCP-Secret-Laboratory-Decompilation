namespace InventorySystem.Items
{
	public interface IAcquisitionConfirmationTrigger
	{
		bool AcquisitionAlreadyReceived { get; set; }

		void ServerConfirmAcqusition();
	}
}

using UnityEngine;

namespace RemoteAdmin.Elements
{
	public class SendButton : CustomButton
	{
		public string CustomCommand;

		[Tooltip("The format on which our command will be sent.\n{0} = Command.\n{1} = Selected Player.\n{2} = Selected Values.\n{3} = Input Field.")]
		public string CustomFormat;

		public override void Select()
		{
			if (string.IsNullOrEmpty(CustomCommand))
			{
				Debug.LogWarning("[SendButton] " + base.gameObject.name + " has no command assigned.", base.gameObject);
				return;
			}
			SendCommand(CustomCommand, CustomFormat);
		}

		protected virtual void SendCommand(string command, string format)
		{
			EnsureInitialized();
			if (base.CommandMenu == null)
			{
				RemoteAdminClient.SendQuery(command);
			}
			else
			{
				base.CommandMenu.SendCommand(command, format);
			}
		}
	}
}
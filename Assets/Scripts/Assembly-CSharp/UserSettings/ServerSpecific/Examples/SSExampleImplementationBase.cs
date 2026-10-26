namespace UserSettings.ServerSpecific.Examples
{
	public abstract class SSExampleImplementationBase
	{
		private static SSExampleImplementationBase _activeExample;

		public static readonly SSExampleImplementationBase[] AllExamples = new SSExampleImplementationBase[6]
		{
			new SSFieldsDemoExample(),
			new SSAbilitiesExample(),
			new SSTextAreaExample(),
			new SSPagesExample(),
			new SSPrimitiveSpawnerExample(),
			new SSLightSpawnerExample()
		};

		public abstract string Name { get; }

		public abstract void Activate();

		public abstract void Deactivate();

		public static bool TryActivateExample(int index, out string message)
		{
			if (!AllExamples.TryGet(index, out var element))
			{
				message = $"Index {index} out of range.";
				return false;
			}
			if (_activeExample == element)
			{
				message = "This example is already active. Use the 'stop' argument to deactivate.";
				return false;
			}
			if (_activeExample != null)
			{
				message = "Another example is already active. Use the 'stop' argument to deactivate.";
				return false;
			}
			_activeExample = element;
			_activeExample.Activate();
			message = element.Name + " activated.";
			return true;
		}

		public static bool TryDeactivateExample(out string disabledName)
		{
			if (_activeExample == null)
			{
				disabledName = null;
				return false;
			}
			disabledName = _activeExample.Name;
			_activeExample.Deactivate();
			_activeExample = null;
			ServerSpecificSettingsSync.DefinedSettings = null;
			ServerSpecificSettingsSync.SendToAll();
			return true;
		}
	}
}

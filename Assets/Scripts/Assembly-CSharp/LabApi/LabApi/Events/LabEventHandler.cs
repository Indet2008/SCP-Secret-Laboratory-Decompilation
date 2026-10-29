namespace LabApi.Events
{
	public delegate void LabEventHandler();
	public delegate void LabEventHandler<in TEventArgs>(TEventArgs ev) where TEventArgs : global::System.EventArgs;
}

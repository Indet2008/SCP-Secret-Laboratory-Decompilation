namespace RemoteAdmin.Interfaces
{
	public interface ISelectableElement
	{
		bool IsSelected
		{
			get;
			set;
		}

		void SetState(bool isSelected);
	}
}

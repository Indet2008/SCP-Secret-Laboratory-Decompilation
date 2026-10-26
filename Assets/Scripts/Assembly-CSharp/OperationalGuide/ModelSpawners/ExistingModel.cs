namespace OperationalGuide.ModelSpawners
{
	[global::System.Serializable]
	public struct ExistingModel
	{
		public global::PlayerRoles.FirstPersonControl.Thirdperson.CharacterModel[] Models;

		public global::OperationalGuide.PannableObject PannableObject;

		public global::PlayerRoles.RoleTypeId RoleType;
	}
}

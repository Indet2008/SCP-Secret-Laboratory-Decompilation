using System;
using Mirror;
using TMPro;

namespace UserSettings.ServerSpecific
{
	public class SSTextArea : ServerSpecificSettingBase
	{
		public enum FoldoutMode
		{
			NotCollapsable = 0,
			CollapseOnEntry = 1,
			ExtendOnEntry = 2,
			CollapsedByDefault = 3,
			ExtendedByDefault = 4
		}

		public override UserResponseMode ResponseMode => UserResponseMode.None;

		public FoldoutMode Foldout { get; private set; }

		public TextAlignmentOptions AlignmentOptions { get; private set; }

		public override string DebugValue => "N/A";

		public SSTextArea(int? id, string content, FoldoutMode foldoutMode = FoldoutMode.NotCollapsable, string collapsedText = null, TextAlignmentOptions textAlignment = TextAlignmentOptions.TopLeft)
		{
			SetId(id, content);
			base.Label = content;
			base.HintDescription = collapsedText;
			Foldout = foldoutMode;
			AlignmentOptions = textAlignment;
		}

		public void SendTextUpdate(string newText, bool applyOverride = true, Func<ReferenceHub, bool> receiveFilter = null)
		{
			SendLabelUpdate(newText, applyOverride, receiveFilter);
		}

		public override void SerializeEntry(NetworkWriter writer)
		{
			base.SerializeEntry(writer);
			writer.WriteByte((byte)Foldout);
			writer.WriteInt((int)AlignmentOptions);
		}

		public override void DeserializeEntry(NetworkReader reader)
		{
			base.DeserializeEntry(reader);
			Foldout = (FoldoutMode)reader.ReadByte();
			AlignmentOptions = (TextAlignmentOptions)reader.ReadInt();
		}

		public override void ApplyDefaultValues()
		{
		}
	}
}

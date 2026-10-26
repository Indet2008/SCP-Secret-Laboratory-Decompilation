using System.Text;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public interface ICustomNicknameDisplayRole
	{
		Color NicknameColor { get; }

		void WriteNickname(StringBuilder sb);
	}
}

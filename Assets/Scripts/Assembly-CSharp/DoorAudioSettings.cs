using System;
using UnityEngine;

[CreateAssetMenu(fileName = "New Door Audio Settings", menuName = "ScriptableObject/Doors/DoorAudioSettings")]
public class DoorAudioSettings : ScriptableObject
{
	private static readonly System.Random Rng = Misc.CreateRandom();

	public AudioClip[] DoorOpeningSound;

	public AudioClip[] DoorClosingSound;

	public AudioClip AccessDenied;

	public AudioClip AccessGranted;

	public AudioClip RandomOpeningSound => DoorOpeningSound[Rng.Next(DoorOpeningSound.Length)];

	public AudioClip RandomClosingSound => DoorClosingSound[Rng.Next(DoorClosingSound.Length)];
}

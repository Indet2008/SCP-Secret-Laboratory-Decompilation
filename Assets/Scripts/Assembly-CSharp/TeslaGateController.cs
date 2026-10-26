using System.Collections.Generic;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MEC;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using Subtitles;
using UnityEngine;

public class TeslaGateController : NetworkBehaviour
{
	public static TeslaGateController Singleton { get; private set; }

	private static void ServerReceiveMessage(NetworkConnection conn, TeslaHitMsg msg)
	{
		if (ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub))
		{
			if (msg.Gate == null)
			{
				hub.gameConsoleTransmission.SendToClient("Received non-existing tesla gate!", "red");
				return;
			}
			if (Vector3.Distance(msg.Gate.transform.position, hub.transform.position) > msg.Gate.sizeOfTrigger * 2.2f)
			{
				hub.gameConsoleTransmission.SendToClient("You are too far from a tesla gate!", "red");
				return;
			}
			DamageHandlerBase.CassieAnnouncement cassieAnnouncement = new DamageHandlerBase.CassieAnnouncement();
			cassieAnnouncement.Announcement = "SUCCESSFULLY TERMINATED BY AUTOMATIC SECURITY SYSTEM";
			cassieAnnouncement.SubtitleParts = new SubtitlePart[1]
			{
				new SubtitlePart(SubtitleType.TerminatedBySecuritySystem, (string[])null)
			};
			DamageHandlerBase.CassieAnnouncement cassieAnnouncement2 = cassieAnnouncement;
			hub.playerStats.DealDamage(new UniversalDamageHandler(Random.Range(200, 300), DeathTranslations.Tesla, cassieAnnouncement2));
		}
	}

	private void Awake()
	{
		Singleton = this;
	}

	private void Start()
	{
		Timing.RunCoroutine(DelayedStopIdleParticles());
		NetworkServer.ReplaceHandler<TeslaHitMsg>(ServerReceiveMessage);
	}

	private IEnumerator<float> DelayedStopIdleParticles()
	{
		for (int i = 0; i < 15; i++)
		{
			yield return float.NegativeInfinity;
		}
		foreach (TeslaGate allGate in TeslaGate.AllGates)
		{
			if (allGate == null || allGate.windupParticles == null)
			{
				continue;
			}
			ParticleSystem[] windupParticles = allGate.windupParticles;
			foreach (ParticleSystem particleSystem in windupParticles)
			{
				if (!(particleSystem == null))
				{
					particleSystem.Stop();
				}
			}
		}
	}

	public void FixedUpdate()
	{
		if (NetworkServer.active)
		{
			foreach (TeslaGate allGate in TeslaGate.AllGates)
			{
				if (allGate.isActiveAndEnabled)
				{
					if (allGate.InactiveTime > 0f)
					{
						allGate.NetworkInactiveTime = Mathf.Max(0f, allGate.InactiveTime - Time.fixedDeltaTime);
					}
					else
					{
						bool flag = false;
						bool flag2 = false;
						ReferenceHub hub = null;
						ReferenceHub hub2 = null;
						foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
						{
							if (allHub.IsAlive())
							{
								if (!flag)
								{
									flag = allGate.IsInIdleRange(allHub);
									if (flag)
									{
										PlayerIdlingTeslaEventArgs e = new PlayerIdlingTeslaEventArgs(allHub, allGate);
										PlayerEvents.OnIdlingTesla(e);
										if (!e.IsAllowed)
										{
											flag = false;
										}
										else
										{
											hub = allHub;
										}
									}
								}
								if (!flag2 && allGate.PlayerInRange(allHub) && !allGate.InProgress)
								{
									PlayerTriggeringTeslaEventArgs e2 = new PlayerTriggeringTeslaEventArgs(allHub, allGate);
									PlayerEvents.OnTriggeringTesla(e2);
									if (e2.IsAllowed)
									{
										hub2 = allHub;
										flag2 = true;
									}
								}
							}
						}
						if (flag2)
						{
							allGate.ServerSideCode();
							PlayerEvents.OnTriggeredTesla(new PlayerTriggeredTeslaEventArgs(hub2, allGate));
						}
						if (flag != allGate.isIdling)
						{
							allGate.ServerSideIdle(flag);
							if (flag)
							{
								PlayerEvents.OnIdledTesla(new PlayerIdledTeslaEventArgs(hub, allGate));
							}
						}
					}
				}
			}
			return;
		}
		foreach (TeslaGate allGate2 in TeslaGate.AllGates)
		{
			allGate2.ClientSideCode();
		}
	}

	public override bool Weaved()
	{
		return true;
	}
}

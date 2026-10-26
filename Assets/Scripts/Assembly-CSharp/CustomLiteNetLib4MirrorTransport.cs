using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using CentralAuth;
using Cryptography;
using GameCore;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using LiteNetLib;
using LiteNetLib.Utils;
using Mirror.LiteNetLib4Mirror;

public class CustomLiteNetLib4MirrorTransport : LiteNetLib4MirrorTransport
{
	private enum ClientType : byte
	{
		GameClient = 0,
		VerificationService = 1
	}

	private static readonly NetDataWriter RequestWriter;

	public static GeoblockingMode Geoblocking;

	public static ChallengeType ChallengeMode;

	public static ushort ChallengeInitLen;

	public static ushort ChallengeSecretLen;

	public static readonly ConcurrentDictionary<IPEndPoint, PreauthItem> UserIds;

	public static readonly ConcurrentDictionary<string, PreauthChallengeItem> Challenges;

	public static bool UserRateLimiting;

	public static bool IpRateLimiting;

	public static bool UseGlobalBans;

	public static bool GeoblockIgnoreWhitelisted;

	public static bool UseChallenge;

	public static bool DisplayPreauthLogs;

	private static bool _delayConnections;

	public static bool SuppressRejections;

	public static bool SuppressIssued;

	public static uint Rejected;

	public static uint ChallengeIssued;

	public static byte DelayTime;

	internal static byte DelayVolume;

	internal static byte DelayVolumeThreshold;

	public static readonly ConcurrentDictionary<string, byte> UserIdFastReload;

	public static readonly ConcurrentDictionary<string, byte> UserRateLimit;

	public static readonly ConcurrentDictionary<IPAddress, byte> IpRateLimit;

	public static readonly ConcurrentDictionary<string, byte> GeoblockingList;

	public static RejectionReason LastRejectionReason;

	public static string LastCustomReason;

	public static string VerificationChallenge;

	public static string VerificationResponse;

	public static long LastBanExpiration;

	public static bool IpPassthroughEnabled;

	public static ConcurrentDictionary<IPAddress, byte> TrustedProxies;

	public static ConcurrentDictionary<int, string> RealIpAddresses;

	public static uint RejectionThreshold;

	public static uint IssuedThreshold;

	public static bool UseReservedSlots;

	private static Stopwatch _preAuthSpeed;

	private long _lastPreAuthSpeed = 1000L;

	public static bool PreVerifySignatures { get; set; }

	public static bool DelayConnections
	{
		get
		{
			return _delayConnections;
		}
		set
		{
			if (_delayConnections != value)
			{
				if (!value)
				{
					UserIds.Clear();
				}
				_delayConnections = value;
				ServerConsole.AddLog(value ? $"Incoming connections will be now delayed by {DelayTime} seconds." : "Incoming connections will be no longer delayed.");
			}
		}
	}

	static CustomLiteNetLib4MirrorTransport()
	{
		RequestWriter = new NetDataWriter();
		Geoblocking = GeoblockingMode.None;
		ChallengeMode = ChallengeType.Reply;
		UserIds = new ConcurrentDictionary<IPEndPoint, PreauthItem>();
		Challenges = new ConcurrentDictionary<string, PreauthChallengeItem>();
		_delayConnections = true;
		DelayTime = 3;
		UserIdFastReload = new ConcurrentDictionary<string, byte>();
		UserRateLimit = new ConcurrentDictionary<string, byte>();
		IpRateLimit = new ConcurrentDictionary<IPAddress, byte>();
		GeoblockingList = new ConcurrentDictionary<string, byte>();
		RejectionThreshold = 60u;
		IssuedThreshold = 50u;
		_preAuthSpeed = new Stopwatch();
	}

	protected internal override void ProcessConnectionRequest(ConnectionRequest request)
	{
		try
		{
			if (!request.Data.TryGetByte(out var result) || result >= 2)
			{
				RequestWriter.Reset();
				RequestWriter.Put((byte)2);
				request.RejectForce(RequestWriter);
				return;
			}
			if (result == 1)
			{
				if (VerificationChallenge != null && request.Data.TryGetString(out var result2) && result2 == VerificationChallenge)
				{
					RequestWriter.Reset();
					RequestWriter.Put((byte)18);
					RequestWriter.Put(VerificationResponse);
					request.Reject(RequestWriter);
					VerificationChallenge = null;
					VerificationResponse = null;
					ServerConsole.AddLog("Verification challenge and response have been sent.\nThe system has successfully checked your server, a verification response will be printed to your console shortly, please allow up to 5 minutes.", ConsoleColor.Green);
					return;
				}
				Rejected++;
				if (Rejected > RejectionThreshold)
				{
					SuppressRejections = true;
				}
				if (!SuppressRejections && DisplayPreauthLogs)
				{
					ServerConsole.AddLog($"Invalid verification challenge has been received from endpoint {request.RemoteEndPoint}.");
				}
				RequestWriter.Reset();
				RequestWriter.Put((byte)19);
				request.RejectForce(RequestWriter);
				return;
			}
			byte result3 = 0;
			if (!request.Data.TryGetByte(out var result4) || !request.Data.TryGetByte(out var result5) || !request.Data.TryGetByte(out var result6) || !request.Data.TryGetBool(out var result7) || (result7 && !request.Data.TryGetByte(out result3)))
			{
				RequestWriter.Reset();
				RequestWriter.Put((byte)3);
				request.RejectForce(RequestWriter);
				return;
			}
			if (!GameCore.Version.CompatibilityCheck(GameCore.Version.Major, GameCore.Version.Minor, GameCore.Version.Revision, result4, result5, result6, result7, result3))
			{
				RequestWriter.Reset();
				RequestWriter.Put((byte)3);
				request.RejectForce(RequestWriter);
				return;
			}
			bool flag = request.Data.TryGetInt(out var result8);
			byte[] result9 = null;
			if (result8 != 0 && !request.Data.TryGetBytesWithLength(out result9))
			{
				flag = false;
			}
			if (!flag)
			{
				RequestWriter.Reset();
				RequestWriter.Put((byte)15);
				request.RejectForce(RequestWriter);
				return;
			}
			if (UseChallenge)
			{
				if (result8 == 0 || result9 == null || result9.Length == 0)
				{
					if (PlayerAuthenticationManager.OnlineMode)
					{
						if (!request.Data.TryGetString(out var result10) || !result10.Contains('@', StringComparison.Ordinal))
						{
							Rejected++;
							if (Rejected > RejectionThreshold)
							{
								SuppressRejections = true;
							}
							if (!SuppressRejections && DisplayPreauthLogs)
							{
								ServerConsole.AddLog($"REJECTED challenge request from endpoint {request.RemoteEndPoint} due to missing PreAuthentication data.");
							}
							if (!SuppressRejections)
							{
								RequestWriter.Reset();
								RequestWriter.Put((byte)2);
								request.RejectForce(RequestWriter);
							}
							return;
						}
						long num = request.Data.GetLong();
						byte b = request.Data.GetByte();
						string text = request.Data.GetString();
						byte[] bytesWithLength = request.Data.GetBytesWithLength();
						bool flag2 = LiteNetLib4MirrorServer.GetPendingConnectionRequestsCount() >= LiteNetLib4MirrorTransport.Singleton.reconnectDelay / _lastPreAuthSpeed;
						bool flag3 = false;
						if (!flag2 || PreVerifySignatures)
						{
							_preAuthSpeed.Reset();
							_preAuthSpeed.Start();
							flag3 = ECDSA.VerifyBytes($"{result10};{b};{text};{num}", bytesWithLength, ServerConsole.PublicKey);
							_preAuthSpeed.Stop();
							_lastPreAuthSpeed = Math.Max(1L, _preAuthSpeed.ElapsedMilliseconds);
							if (flag2)
							{
								PreVerifySignatures = false;
							}
						}
						if (!flag2 && !flag3)
						{
							Rejected++;
							if (Rejected > RejectionThreshold)
							{
								SuppressRejections = true;
							}
							if (!SuppressRejections && DisplayPreauthLogs)
							{
								ServerConsole.AddLog($"REJECTED challenge request from endpoint {request.RemoteEndPoint} due to invalid digital signature.");
							}
							if (!SuppressRejections)
							{
								RequestWriter.Reset();
								RequestWriter.Put((byte)2);
								request.RejectForce(RequestWriter);
							}
							return;
						}
						if (!flag2 && !CheckUserRateLimit(request, result10, request.RemoteEndPoint.ToString()))
						{
							return;
						}
					}
					if (!CheckIpRateLimit(request))
					{
						return;
					}
					int num2 = 0;
					string key = string.Empty;
					for (byte b2 = 0; b2 < 3; b2++)
					{
						num2 = RandomGenerator.GetInt32();
						if (num2 == 0)
						{
							num2 = 1;
						}
						key = request.RemoteEndPoint.Address?.ToString() + "-" + num2;
						if (!Challenges.ContainsKey(key))
						{
							break;
						}
						if (b2 == 2)
						{
							RequestWriter.Reset();
							RequestWriter.Put((byte)4);
							request.RejectForce(RequestWriter);
							if (DisplayPreauthLogs)
							{
								ServerConsole.AddLog($"Failed to generate ID for challenge for incoming connection from endpoint {request.RemoteEndPoint}.");
							}
							return;
						}
					}
					byte[] bytes = RandomGenerator.GetBytes(ChallengeInitLen + ChallengeSecretLen, secure: true);
					ChallengeIssued++;
					if (ChallengeIssued > IssuedThreshold)
					{
						SuppressIssued = true;
					}
					if (!SuppressIssued && DisplayPreauthLogs)
					{
						ServerConsole.AddLog($"Requested challenge for incoming connection from endpoint {request.RemoteEndPoint}.");
					}
					RequestWriter.Reset();
					RequestWriter.Put((byte)13);
					RequestWriter.Put((byte)ChallengeMode);
					RequestWriter.Put(num2);
					switch (ChallengeMode)
					{
					case ChallengeType.MD5:
						RequestWriter.PutBytesWithLength(bytes, 0, ChallengeInitLen);
						RequestWriter.Put(ChallengeSecretLen);
						RequestWriter.PutBytesWithLength(Md.Md5(bytes));
						Challenges.TryAdd(key, new PreauthChallengeItem(new ArraySegment<byte>(bytes, ChallengeInitLen, ChallengeSecretLen)));
						break;
					case ChallengeType.SHA1:
						RequestWriter.PutBytesWithLength(bytes, 0, ChallengeInitLen);
						RequestWriter.Put(ChallengeSecretLen);
						RequestWriter.PutBytesWithLength(Sha.Sha1(bytes));
						Challenges.TryAdd(key, new PreauthChallengeItem(new ArraySegment<byte>(bytes, ChallengeInitLen, ChallengeSecretLen)));
						break;
					default:
						RequestWriter.PutBytesWithLength(bytes);
						Challenges.TryAdd(key, new PreauthChallengeItem(new ArraySegment<byte>(bytes)));
						break;
					}
					request.RejectForce(RequestWriter);
					return;
				}
				string key2 = request.RemoteEndPoint.Address?.ToString() + "-" + result8;
				if (!Challenges.ContainsKey(key2))
				{
					Rejected++;
					if (Rejected > RejectionThreshold)
					{
						SuppressRejections = true;
					}
					if (!SuppressRejections && DisplayPreauthLogs)
					{
						ServerConsole.AddLog($"Security challenge response of incoming connection from endpoint {request.RemoteEndPoint} has been REJECTED (invalid Challenge ID).");
					}
					RequestWriter.Reset();
					RequestWriter.Put((byte)14);
					request.RejectForce(RequestWriter);
					return;
				}
				PreauthChallengeItem value = Challenges[key2];
				ArraySegment<byte> validResponse = value.ValidResponse;
				if (!result9.SequenceEqual(validResponse))
				{
					Rejected++;
					if (Rejected > RejectionThreshold)
					{
						SuppressRejections = true;
					}
					if (!SuppressRejections && DisplayPreauthLogs)
					{
						ServerConsole.AddLog($"Security challenge response of incoming connection from endpoint {request.RemoteEndPoint} has been REJECTED (invalid response).");
					}
					RequestWriter.Reset();
					RequestWriter.Put((byte)15);
					request.RejectForce(RequestWriter);
					return;
				}
				Challenges.TryRemove(key2, out value);
				PreauthDisableIdleMode();
				if (DisplayPreauthLogs)
				{
					ServerConsole.AddLog($"Security challenge response of incoming connection from endpoint {request.RemoteEndPoint} has been accepted.");
				}
			}
			else if (!UseChallenge && !CheckIpRateLimit(request))
			{
				return;
			}
			if (DelayConnections)
			{
				PreauthDisableIdleMode();
				RequestWriter.Reset();
				RequestWriter.Put((byte)17);
				RequestWriter.Put(DelayTime);
				if (DelayVolume < byte.MaxValue)
				{
					DelayVolume++;
				}
				if (DelayVolume < DelayVolumeThreshold)
				{
					if (DisplayPreauthLogs)
					{
						ServerConsole.AddLog($"Delayed connection incoming from endpoint {request.RemoteEndPoint} by {DelayTime} seconds.");
					}
					request.Reject(RequestWriter);
				}
				else
				{
					if (DisplayPreauthLogs)
					{
						ServerConsole.AddLog($"Force delayed connection incoming from endpoint {request.RemoteEndPoint} by {DelayTime} seconds.");
					}
					request.RejectForce(RequestWriter);
				}
				return;
			}
			int position = request.Data.Position;
			if (!PlayerAuthenticationManager.OnlineMode)
			{
				KeyValuePair<BanDetails, BanDetails> keyValuePair = BanHandler.QueryBan(null, request.RemoteEndPoint.Address.ToString());
				if (keyValuePair.Value != null)
				{
					if (DisplayPreauthLogs)
					{
						ServerConsole.AddLog($"Player tried to connect from banned endpoint {request.RemoteEndPoint}.");
					}
					RequestWriter.Reset();
					RequestWriter.Put((byte)6);
					RequestWriter.Put(keyValuePair.Value.Expires);
					RequestWriter.Put(keyValuePair.Value?.Reason ?? string.Empty);
					request.RejectForce(RequestWriter);
					ResetIdleMode();
					return;
				}
				PlayerPreAuthenticatingEventArgs e = new PlayerPreAuthenticatingEventArgs(!IsServerFull(), string.Empty, request.RemoteEndPoint.Address.ToString(), 0L, CentralAuthPreauthFlags.None, string.Empty, null, request, position);
				PlayerEvents.OnPreAuthenticating(e);
				if (!e.IsAllowed)
				{
					if (e.CustomReject != null)
					{
						if (e.ForceReject)
						{
							request.RejectForce(e.CustomReject);
						}
						else
						{
							request.Reject(e.CustomReject);
						}
					}
					else
					{
						RequestWriter.Reset();
						RequestWriter.Put((byte)4);
						request.RejectForce(RequestWriter);
					}
				}
				else if (e.CanJoin)
				{
					request.Accept();
					PreauthDisableIdleMode();
					PlayerEvents.OnPreAuthenticated(new PlayerPreAuthenticatedEventArgs(string.Empty, request.RemoteEndPoint.Address.ToString(), 0L, CentralAuthPreauthFlags.None, string.Empty, null, request, position));
				}
				else
				{
					RequestWriter.Reset();
					RequestWriter.Put((byte)1);
					request.Reject(RequestWriter);
					ResetIdleMode();
				}
				return;
			}
			if (!request.Data.TryGetString(out var result11) || result11 == string.Empty)
			{
				RequestWriter.Reset();
				RequestWriter.Put((byte)5);
				request.RejectForce(RequestWriter);
				return;
			}
			if (!request.Data.TryGetLong(out var result12) || !request.Data.TryGetByte(out var result13) || !request.Data.TryGetString(out var result14) || !request.Data.TryGetBytesWithLength(out var result15))
			{
				RequestWriter.Reset();
				RequestWriter.Put((byte)4);
				request.RejectForce(RequestWriter);
				return;
			}
			string result16 = null;
			string text2 = ((IpPassthroughEnabled && TrustedProxies.ContainsKey(request.RemoteEndPoint.Address) && request.Data.TryGetString(out result16)) ? $"{result16} [routed via {request.RemoteEndPoint}]" : request.RemoteEndPoint.ToString());
			CentralAuthPreauthFlags flags = (CentralAuthPreauthFlags)result13;
			try
			{
				if (!ECDSA.VerifyBytes($"{result11};{result13};{result14};{result12}", result15, ServerConsole.PublicKey))
				{
					Rejected++;
					if (Rejected > RejectionThreshold)
					{
						SuppressRejections = true;
					}
					if (!SuppressRejections && DisplayPreauthLogs)
					{
						ServerConsole.AddLog("Player from endpoint " + text2 + " sent preauthentication token with invalid digital signature.");
					}
					RequestWriter.Reset();
					RequestWriter.Put((byte)2);
					request.RejectForce(RequestWriter);
					ResetIdleMode();
				}
				else if (TimeBehaviour.CurrentUnixTimestamp > result12)
				{
					Rejected++;
					if (Rejected > RejectionThreshold)
					{
						SuppressRejections = true;
					}
					if (!SuppressRejections && DisplayPreauthLogs)
					{
						ServerConsole.AddLog("Player from endpoint " + text2 + " sent expired preauthentication token.");
						ServerConsole.AddLog("Make sure that time and timezone set on server is correct. We recommend synchronizing the time.");
					}
					RequestWriter.Reset();
					RequestWriter.Put((byte)11);
					request.RejectForce(RequestWriter);
					ResetIdleMode();
				}
				else
				{
					if (!UseChallenge && !CheckUserRateLimit(request, result11, text2))
					{
						return;
					}
					if (!flags.HasFlagFast(CentralAuthPreauthFlags.IgnoreBans) || !CustomNetworkManager.IsVerified)
					{
						KeyValuePair<BanDetails, BanDetails> keyValuePair2 = BanHandler.QueryBan(result11, result16 ?? request.RemoteEndPoint.Address.ToString());
						if (keyValuePair2.Key != null || keyValuePair2.Value != null)
						{
							Rejected++;
							if (Rejected > RejectionThreshold)
							{
								SuppressRejections = true;
							}
							if (!SuppressRejections && DisplayPreauthLogs)
							{
								ServerConsole.AddLog(((keyValuePair2.Key == null) ? "Player" : "Banned player") + " " + result11 + " tried to connect from" + ((keyValuePair2.Value == null) ? "" : " banned") + " endpoint " + text2 + ".");
								ServerLogs.AddLog(ServerLogs.Modules.Networking, ((keyValuePair2.Key == null) ? "Player" : "Banned player") + " " + result11 + " tried to connect from" + ((keyValuePair2.Value == null) ? "" : " banned") + " endpoint " + text2 + ".", ServerLogs.ServerLogType.ConnectionUpdate);
							}
							RequestWriter.Reset();
							RequestWriter.Put((byte)6);
							RequestWriter.Put(keyValuePair2.Key?.Expires ?? keyValuePair2.Value.Expires);
							RequestWriter.Put(keyValuePair2.Key?.Reason ?? keyValuePair2.Value?.Reason ?? string.Empty);
							request.Reject(RequestWriter);
							ResetIdleMode();
							return;
						}
					}
					if (flags.HasFlagFast(CentralAuthPreauthFlags.AuthRejected))
					{
						if (DisplayPreauthLogs)
						{
							ServerConsole.AddLog("Player " + result11 + " (" + text2 + ") kicked due to auth rejection by central server.");
						}
						RequestWriter.Reset();
						RequestWriter.Put((byte)20);
						request.Reject(RequestWriter);
						ResetIdleMode();
						return;
					}
					if (flags.HasFlagFast(CentralAuthPreauthFlags.GloballyBanned) && (CustomNetworkManager.IsVerified || UseGlobalBans))
					{
						if (DisplayPreauthLogs)
						{
							ServerConsole.AddLog("Player " + result11 + " (" + text2 + ") kicked due to an active global ban.");
						}
						RequestWriter.Reset();
						RequestWriter.Put((byte)8);
						request.Reject(RequestWriter);
						ResetIdleMode();
						return;
					}
					if ((!flags.HasFlagFast(CentralAuthPreauthFlags.IgnoreWhitelist) || !CustomNetworkManager.IsVerified) && !WhiteList.IsWhitelisted(result11))
					{
						if (DisplayPreauthLogs)
						{
							ServerConsole.AddLog("Player " + result11 + " tried joined from endpoint " + text2 + ", but is not whitelisted.");
						}
						RequestWriter.Reset();
						RequestWriter.Put((byte)7);
						request.Reject(RequestWriter);
						ResetIdleMode();
						return;
					}
					if (Geoblocking != GeoblockingMode.None && (!flags.HasFlagFast(CentralAuthPreauthFlags.IgnoreGeoblock) || !ServerStatic.PermissionsHandler.BanTeamBypassGeo) && (!GeoblockIgnoreWhitelisted || !WhiteList.IsOnWhitelist(result11)) && ((Geoblocking == GeoblockingMode.Whitelist && !GeoblockingList.ContainsKey(result14)) || (Geoblocking == GeoblockingMode.Blacklist && GeoblockingList.ContainsKey(result14))))
					{
						Rejected++;
						if (Rejected > RejectionThreshold)
						{
							SuppressRejections = true;
						}
						if (!SuppressRejections && DisplayPreauthLogs)
						{
							ServerConsole.AddLog("Player " + result11 + " (" + text2 + ") tried joined from blocked country " + result14 + ".");
						}
						RequestWriter.Reset();
						RequestWriter.Put((byte)9);
						request.RejectForce(RequestWriter);
						ResetIdleMode();
						return;
					}
					UserIdFastReload.TryRemove(result11, out var _);
					PlayerPreAuthenticatingEventArgs e2 = new PlayerPreAuthenticatingEventArgs(!IsServerFull(result11, flags), result11, (result16 == null) ? request.RemoteEndPoint.Address.ToString() : result16, result12, flags, result14, result15, request, position);
					PlayerEvents.OnPreAuthenticating(e2);
					if (!e2.IsAllowed)
					{
						if (e2.CustomReject != null)
						{
							if (e2.ForceReject)
							{
								request.RejectForce(e2.CustomReject);
							}
							else
							{
								request.Reject(e2.CustomReject);
							}
						}
						else
						{
							RequestWriter.Reset();
							RequestWriter.Put((byte)4);
							request.RejectForce(RequestWriter);
						}
					}
					else if (e2.CanJoin)
					{
						if (UserIds.ContainsKey(request.RemoteEndPoint))
						{
							UserIds[request.RemoteEndPoint].SetUserId(result11);
						}
						else
						{
							UserIds.TryAdd(request.RemoteEndPoint, new PreauthItem(result11));
						}
						LiteNetPeer liteNetPeer = request.Accept();
						if (result16 != null)
						{
							if (RealIpAddresses.ContainsKey(liteNetPeer.Id))
							{
								RealIpAddresses[liteNetPeer.Id] = result16;
							}
							else
							{
								RealIpAddresses.TryAdd(liteNetPeer.Id, result16);
							}
						}
						ServerConsole.AddLog("Player " + result11 + " preauthenticated from endpoint " + text2 + ".");
						ServerLogs.AddLog(ServerLogs.Modules.Networking, result11 + " preauthenticated from endpoint " + text2 + ".", ServerLogs.ServerLogType.ConnectionUpdate);
						PreauthDisableIdleMode();
						PlayerEvents.OnPreAuthenticated(new PlayerPreAuthenticatedEventArgs(result11, (result16 == null) ? request.RemoteEndPoint.Address.ToString() : result16, result12, flags, result14, result15, request, position));
					}
					else
					{
						RequestWriter.Reset();
						RequestWriter.Put((byte)1);
						request.Reject(RequestWriter);
						ResetIdleMode();
					}
				}
			}
			catch (Exception ex)
			{
				Rejected++;
				if (Rejected > RejectionThreshold)
				{
					SuppressRejections = true;
				}
				if (!SuppressRejections && DisplayPreauthLogs)
				{
					ServerConsole.AddLog("Player from endpoint " + text2 + " sent an invalid preauthentication token. " + ex.Message);
				}
				RequestWriter.Reset();
				RequestWriter.Put((byte)2);
				request.RejectForce(RequestWriter);
				ResetIdleMode();
			}
		}
		catch (Exception ex2)
		{
			Rejected++;
			if (Rejected > RejectionThreshold)
			{
				SuppressRejections = true;
			}
			if (!SuppressRejections)
			{
				ServerConsole.AddLog($"Player from endpoint {request.RemoteEndPoint} failed to preauthenticate: {ex2.Message}");
			}
			RequestWriter.Reset();
			RequestWriter.Put((byte)4);
			request.RejectForce(RequestWriter);
		}
	}

	private static bool IsServerFull(string userId = null, CentralAuthPreauthFlags flags = CentralAuthPreauthFlags.None)
	{
		if (!string.IsNullOrEmpty(userId) && HasReservedSlot(userId, flags))
		{
			return false;
		}
		return LiteNetLib4MirrorCore.Host.ConnectedPeersCount >= CustomNetworkManager.slots;
	}

	private static bool HasReservedSlot(string userId, CentralAuthPreauthFlags flags)
	{
		if (flags.HasFlagFast(CentralAuthPreauthFlags.ReservedSlot) && ServerStatic.PermissionsHandler.BanTeamSlots)
		{
			return true;
		}
		if (!UseReservedSlots)
		{
			return false;
		}
		if (!ReservedSlot.HasReservedSlot(userId))
		{
			return false;
		}
		return CustomNetworkManager.slots + CustomNetworkManager.reservedSlots - LiteNetLib4MirrorCore.Host.ConnectedPeersCount > 0;
	}

	private static bool CheckIpRateLimit(ConnectionRequest request)
	{
		if (!IpRateLimiting)
		{
			return true;
		}
		if (IpRateLimit.ContainsKey(request.RemoteEndPoint.Address))
		{
			Rejected++;
			if (Rejected > RejectionThreshold)
			{
				SuppressRejections = true;
			}
			if (!SuppressRejections && !SuppressIssued)
			{
				ServerConsole.AddLog($"Incoming connection from endpoint {request.RemoteEndPoint} rejected due to exceeding the rate limit.");
				ServerLogs.AddLog(ServerLogs.Modules.Networking, $"Incoming connection from endpoint {request.RemoteEndPoint} rejected due to exceeding the rate limit.", ServerLogs.ServerLogType.AuthRateLimit);
			}
			RequestWriter.Reset();
			RequestWriter.Put((byte)12);
			request.RejectForce(RequestWriter);
			return false;
		}
		IpRateLimit.TryAdd(request.RemoteEndPoint.Address, 0);
		return true;
	}

	private static bool CheckUserRateLimit(ConnectionRequest request, string userId, string ep)
	{
		if (!UserRateLimiting)
		{
			return true;
		}
		if (UserRateLimit.ContainsKey(userId))
		{
			Rejected++;
			if (Rejected > RejectionThreshold)
			{
				SuppressRejections = true;
			}
			if (!SuppressRejections && DisplayPreauthLogs)
			{
				ServerConsole.AddLog("Incoming connection from " + userId + " (" + ep + ") rejected due to exceeding the rate limit.");
			}
			RequestWriter.Reset();
			RequestWriter.Put((byte)12);
			request.RejectForce(RequestWriter);
			ResetIdleMode();
			return false;
		}
		UserRateLimit.TryAdd(userId, 0);
		return true;
	}

	protected override void GetConnectData(NetDataWriter writer)
	{
	}

	protected internal override void OnConncetionRefused(DisconnectInfo disconnectinfo)
	{
		if (disconnectinfo.AdditionalData.TryGetByte(out var result))
		{
			LastRejectionReason = (RejectionReason)result;
		}
		else
		{
			LastRejectionReason = RejectionReason.NotSpecified;
		}
	}

	private static void ResetIdleMode()
	{
		MainThreadDispatcher.Dispatch(() =>
		{
			if (LiteNetLib4MirrorCore.Host.ConnectedPeersCount == 0)
			{
				IdleMode.SetIdleMode(state: true);
			}
		});
	}

	public static void PreauthDisableIdleMode()
	{
		MainThreadDispatcher.Dispatch(() =>
		{
			if (ServerStatic.IsDedicated && IdleMode.IdleModeActive)
			{
				IdleMode.PreauthStopwatch.Restart();
				IdleMode.SetIdleMode(state: false);
			}
		});
	}

	public static void ReloadChallengeOptions()
	{
		UseChallenge = ConfigFile.ServerConfig.GetBool("preauth_challenge", def: true);
		ChallengeInitLen = ConfigFile.ServerConfig.GetUShort("preauth_challenge_base_length", 16);
		ChallengeSecretLen = ConfigFile.ServerConfig.GetUShort("preauth_challenge_secret_length", 5);
		string text = ConfigFile.ServerConfig.GetString("preauth_challenge_mode", "reply").ToLower();
		if (!(text == "md5"))
		{
			if (text == "sha1")
			{
				ChallengeMode = ChallengeType.SHA1;
				return;
			}
			ChallengeMode = ChallengeType.Reply;
			ChallengeSecretLen = 0;
		}
		else
		{
			ChallengeMode = ChallengeType.MD5;
		}
	}
}

using System;
using System.Collections.Generic;
using Authenticator;
using Utf8Json.Formatters;
using Utf8Json.Formatters.Authenticator;

namespace Utf8Json.Resolvers
{
	internal static class GeneratedResolverGetFormatterHelper
	{
		private static readonly Dictionary<Type, int> lookup;

		static GeneratedResolverGetFormatterHelper()
		{
			lookup = new Dictionary<Type, int>(36)
			{
				{
					typeof(List<AuthenticatorPlayerObject>),
					0
				},
				{
					typeof(AuthenticatiorAuthReject[]),
					1
				},
				{
					typeof(CreditsListMember[]),
					2
				},
				{
					typeof(CreditsListCategory[]),
					3
				},
				{
					typeof(DiscordEmbedField[]),
					4
				},
				{
					typeof(DiscordEmbed[]),
					5
				},
				{
					typeof(NewsListItem[]),
					6
				},
				{
					typeof(List<string>),
					7
				},
				{
					typeof(ServerListItem[]),
					8
				},
				{
					typeof(AuthenticateResponse),
					9
				},
				{
					typeof(AuthenticationToken),
					10
				},
				{
					typeof(AuthenticatiorAuthReject),
					11
				},
				{
					typeof(AuthenticatorPlayerObject),
					12
				},
				{
					typeof(AuthenticatorPlayerObjects),
					13
				},
				{
					typeof(AuthenticatorResponse),
					14
				},
				{
					typeof(BadgeToken),
					15
				},
				{
					typeof(CreditsListMember),
					16
				},
				{
					typeof(CreditsListCategory),
					17
				},
				{
					typeof(CreditsList),
					18
				},
				{
					typeof(DiscordEmbedField),
					19
				},
				{
					typeof(DiscordEmbed),
					20
				},
				{
					typeof(DiscordWebhook),
					21
				},
				{
					typeof(GlobalBanningResponse),
					22
				},
				{
					typeof(NewsListItem),
					23
				},
				{
					typeof(NewsList),
					24
				},
				{
					typeof(NewsRaw),
					25
				},
				{
					typeof(PlayerListSerialized),
					26
				},
				{
					typeof(PublicKeyResponse),
					27
				},
				{
					typeof(RenewResponse),
					28
				},
				{
					typeof(SignedToken),
					29
				},
				{
					typeof(RequestSignatureResponse),
					30
				},
				{
					typeof(ServerListItem),
					31
				},
				{
					typeof(ServerList),
					32
				},
				{
					typeof(ServerListSigned),
					33
				},
				{
					typeof(Token),
					34
				},
				{
					typeof(TranslationManifest),
					35
				}
			};
		}

		internal static object GetFormatter(Type t)
		{
			if (!lookup.TryGetValue(t, out var value))
			{
				return null;
			}
			return value switch
			{
				0 => new ListFormatter<AuthenticatorPlayerObject>(), 
				1 => new ArrayFormatter<AuthenticatiorAuthReject>(), 
				2 => new ArrayFormatter<CreditsListMember>(), 
				3 => new ArrayFormatter<CreditsListCategory>(), 
				4 => new ArrayFormatter<DiscordEmbedField>(), 
				5 => new ArrayFormatter<DiscordEmbed>(), 
				6 => new ArrayFormatter<NewsListItem>(), 
				7 => new ListFormatter<string>(), 
				8 => new ArrayFormatter<ServerListItem>(), 
				9 => new AuthenticateResponseFormatter(), 
				10 => new AuthenticationTokenFormatter(), 
				11 => new AuthenticatiorAuthRejectFormatter(), 
				12 => new AuthenticatorPlayerObjectFormatter(), 
				13 => new AuthenticatorPlayerObjectsFormatter(), 
				14 => new AuthenticatorResponseFormatter(), 
				15 => new BadgeTokenFormatter(), 
				16 => new CreditsListMemberFormatter(), 
				17 => new CreditsListCategoryFormatter(), 
				18 => new CreditsListFormatter(), 
				19 => new DiscordEmbedFieldFormatter(), 
				20 => new DiscordEmbedFormatter(), 
				21 => new DiscordWebhookFormatter(), 
				22 => new GlobalBanningResponseFormatter(), 
				23 => new NewsListItemFormatter(), 
				24 => new NewsListFormatter(), 
				25 => new NewsRawFormatter(), 
				26 => new PlayerListSerializedFormatter(), 
				27 => new PublicKeyResponseFormatter(), 
				28 => new RenewResponseFormatter(), 
				29 => new SignedTokenFormatter(), 
				30 => new RequestSignatureResponseFormatter(), 
				31 => new ServerListItemFormatter(), 
				32 => new ServerListFormatter(), 
				33 => new ServerListSignedFormatter(), 
				34 => new TokenFormatter(), 
				35 => new TranslationManifestFormatter(), 
				_ => null, 
			};
		}
	}
}

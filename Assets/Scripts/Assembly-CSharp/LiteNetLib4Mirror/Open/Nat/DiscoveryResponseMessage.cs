using System;
using System.Collections.Generic;
using System.Linq;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class DiscoveryResponseMessage
	{
		private readonly IDictionary<string, string> _headers;

		public string this[string key] => _headers[key.ToUpperInvariant()];

		public DiscoveryResponseMessage(string message)
		{
			var source = from h in message.Split(new string[1] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries).Skip(1)
				let c = h.Split(':')
				let key = c[0]
				let value = (c.Length > 1) ? string.Join(":", c.Skip(1).ToArray()) : string.Empty
				select new
				{
					Key = key,
					Value = value.Trim()
				};
			_headers = source.ToDictionary(x => x.Key.ToUpperInvariant(), x => x.Value);
		}
	}
}

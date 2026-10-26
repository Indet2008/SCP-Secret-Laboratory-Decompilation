using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace LiteNetLib4Mirror.Open.Nat
{
	public abstract class NatDevice
	{
		private readonly HashSet<Mapping> _openedMapping = new HashSet<Mapping>();

		protected DateTime LastSeen { get; private set; }

		internal void Touch()
		{
			LastSeen = DateTime.Now;
		}

		public abstract Task CreatePortMapAsync(Mapping mapping);

		public abstract Task DeletePortMapAsync(Mapping mapping);

		public abstract Task<IEnumerable<Mapping>> GetAllMappingsAsync();

		public abstract Task<IPAddress> GetExternalIPAsync();

		public abstract Task<Mapping> GetSpecificMappingAsync(NetworkProtocolType networkProtocolType, int port);

		protected void RegisterMapping(Mapping mapping)
		{
			_openedMapping.Remove(mapping);
			_openedMapping.Add(mapping);
		}

		protected void UnregisterMapping(Mapping mapping)
		{
			_openedMapping.RemoveWhere((Mapping x) => x.Equals(mapping));
		}

		internal void ReleaseMapping(IEnumerable<Mapping> mappings)
		{
			int num = mappings.ToArray().Length;
			NatDiscoverer.TraceSource.LogInfo("{0} ports to close", num);
			for (int i = 0; i < num; i++)
			{
				Mapping mapping = _openedMapping.ElementAt(i);
				try
				{
					DeletePortMapAsync(mapping);
					NatDiscoverer.TraceSource.LogInfo(mapping?.ToString() + " port successfully closed");
				}
				catch (Exception)
				{
					NatDiscoverer.TraceSource.LogError(mapping?.ToString() + " port couldn't be close");
				}
			}
		}

		internal void ReleaseAll()
		{
			ReleaseMapping(_openedMapping);
		}

		internal void ReleaseSessionMappings()
		{
			IEnumerable<Mapping> mappings = _openedMapping.Where((Mapping m) => m.LifetimeType == MappingLifetime.Session);
			ReleaseMapping(mappings);
		}

		internal async Task RenewMappings()
		{
			IEnumerable<Mapping> source = _openedMapping.Where((Mapping x) => x.ShoundRenew());
			Mapping[] array = source.ToArray();
			foreach (Mapping mapping in array)
			{
				await RenewMapping(mapping);
			}
		}

		private async Task RenewMapping(Mapping mapping)
		{
			Mapping renewMapping = new Mapping(mapping);
			try
			{
				renewMapping.Expiration = DateTime.UtcNow.AddSeconds(mapping.Lifetime);
				NatDiscoverer.TraceSource.LogInfo("Renewing mapping {0}", renewMapping);
				await CreatePortMapAsync(renewMapping);
				NatDiscoverer.TraceSource.LogInfo("Next renew scheduled at: {0}", renewMapping.Expiration.ToLocalTime().TimeOfDay);
			}
			catch (Exception)
			{
				NatDiscoverer.TraceSource.LogWarn("Renew {0} failed", mapping);
			}
		}
	}
}

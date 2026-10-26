using System;

namespace Utils.Http.SDR
{
	internal class SDRHttpRequest
	{
		public string Url { get; set; }

		public string Method { get; set; }

		public string Payload { get; set; }

		public string ContentType { get; set; }

		public bool Base64 { get; set; }

		public Action<int, string> OnComplete { get; set; }

		public bool Log { get; set; }

		public int RequestId { get; set; }
	}
}

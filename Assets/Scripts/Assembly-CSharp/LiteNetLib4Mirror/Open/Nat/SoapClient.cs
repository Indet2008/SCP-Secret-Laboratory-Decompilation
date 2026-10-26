using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class SoapClient
	{
		private readonly string _serviceType;

		private readonly Uri _url;

		public SoapClient(Uri url, string serviceType)
		{
			_url = url;
			_serviceType = serviceType;
		}

		public async Task<XmlDocument> InvokeAsync(string operationName, IDictionary<string, object> args)
		{
			byte[] messageBody = BuildMessageBody(operationName, args);
			HttpWebRequest request = BuildHttpWebRequest(operationName, messageBody);
			if (messageBody.Length != 0)
			{
				using Stream stream = await request.GetRequestStreamAsync();
				await stream.WriteAsync(messageBody, 0, messageBody.Length);
			}
			using WebResponse webResponse = await GetWebResponse(request);
			Stream responseStream = webResponse.GetResponseStream();
			long contentLength = webResponse.ContentLength;
			StreamReader streamReader = new StreamReader(responseStream, Encoding.UTF8);
			string response = ((contentLength != -1) ? streamReader.ReadAsMany((int)contentLength) : streamReader.ReadToEnd());
			XmlDocument xmlDocument = GetXmlDocument(response);
			webResponse.Close();
			return xmlDocument;
		}

		private static async Task<WebResponse> GetWebResponse(WebRequest request)
		{
			WebResponse webResponse;
			try
			{
				webResponse = await request.GetResponseAsync();
			}
			catch (WebException ex)
			{
				webResponse = ex.Response as HttpWebResponse;
				if (webResponse == null)
				{
					throw;
				}
			}
			return webResponse;
		}

		private HttpWebRequest BuildHttpWebRequest(string operationName, byte[] messageBody)
		{
			HttpWebRequest httpWebRequest = WebRequest.CreateHttp(_url);
			httpWebRequest.KeepAlive = false;
			httpWebRequest.Method = "POST";
			httpWebRequest.ContentType = "text/xml; charset=\"utf-8\"";
			httpWebRequest.Headers.Add("SOAPACTION", "\"" + _serviceType + "#" + operationName + "\"");
			httpWebRequest.ContentLength = messageBody.Length;
			return httpWebRequest;
		}

		private byte[] BuildMessageBody(string operationName, IEnumerable<KeyValuePair<string, object>> args)
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("<s:Envelope ");
			stringBuilder.AppendLine("   xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" ");
			stringBuilder.AppendLine("   s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">");
			stringBuilder.AppendLine("   <s:Body>");
			stringBuilder.AppendLine("\t  <u:" + operationName + " xmlns:u=\"" + _serviceType + "\">");
			foreach (KeyValuePair<string, object> arg in args)
			{
				stringBuilder.AppendLine("\t\t <" + arg.Key + ">" + Convert.ToString(arg.Value, CultureInfo.InvariantCulture) + "</" + arg.Key + ">");
			}
			stringBuilder.AppendLine("\t  </u:" + operationName + ">");
			stringBuilder.AppendLine("   </s:Body>");
			stringBuilder.Append("</s:Envelope>\r\n\r\n");
			string s = stringBuilder.ToString();
			return Encoding.UTF8.GetBytes(s);
		}

		private XmlDocument GetXmlDocument(string response)
		{
			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.LoadXml(response);
			XmlNamespaceManager xmlNamespaceManager = new XmlNamespaceManager(xmlDocument.NameTable);
			xmlNamespaceManager.AddNamespace("errorNs", "urn:schemas-upnp-org:control-1-0");
			XmlNode node;
			if ((node = xmlDocument.SelectSingleNode("//errorNs:UPnPError", xmlNamespaceManager)) != null)
			{
				int num = Convert.ToInt32(node.GetXmlElementText("errorCode"), CultureInfo.InvariantCulture);
				string xmlElementText = node.GetXmlElementText("errorDescription");
				NatDiscoverer.TraceSource.LogWarn("Server failed with error: {0} - {1}", num, xmlElementText);
				throw new MappingException(num, xmlElementText);
			}
			return xmlDocument;
		}
	}
}

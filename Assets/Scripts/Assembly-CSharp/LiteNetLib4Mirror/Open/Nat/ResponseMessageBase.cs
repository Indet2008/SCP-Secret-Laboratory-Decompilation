using System;
using System.Xml;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal abstract class ResponseMessageBase
	{
		private readonly XmlDocument _document;

		protected string ServiceType;

		private readonly string _typeName;

		protected ResponseMessageBase(XmlDocument response, string serviceType, string typeName)
		{
			_document = response;
			ServiceType = serviceType;
			_typeName = typeName;
		}

		protected XmlNode GetNode()
		{
			XmlNamespaceManager xmlNamespaceManager = new XmlNamespaceManager(_document.NameTable);
			xmlNamespaceManager.AddNamespace("responseNs", ServiceType);
			string typeName = _typeName;
			string text = typeName.Substring(0, typeName.Length - "Message".Length);
			return _document.SelectSingleNode("//responseNs:" + text, xmlNamespaceManager) ?? throw new InvalidOperationException("The response is invalid: " + text);
		}
	}
}

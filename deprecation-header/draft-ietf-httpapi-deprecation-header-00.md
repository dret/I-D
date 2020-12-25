---
coding: utf-8
abbrev:
title: The Deprecation HTTP Header
docname: draft-ietf-httpapi-deprecation-header-00
category: std

ipr: trust200902
area: Applications and Real-Time
workgroup: HTTPAPI
keyword: Internet-Draft

stand_alone: yes
pi: [toc, tocindent, sortrefs, symrefs, strict, compact, comments, inline]

author:
  -
    ins: S. Dalal
    name: Sanjay Dalal
    email: sanjay.dalal@cal.berkeley.edu
    uri: https://github.com/sdatspun2
  -    
    ins: E. Wilde
    name: Erik Wilde
    email: erik.wilde@dret.net
    uri: http://dret.net/netdret

normative:


informative:


--- abstract

The HTTP Deprecation Response Header can be used to signal to consumers of a URI-identified resource that the resource has been deprecated. Additionally, the deprecation link relation can be used to link to a resource that provides additional context for the deprecation, and possibly ways in which clients can find a replacement for the deprecated resource.


--- middle



# Introduction

Deprecation of an HTTP resource as defined in Section 2 of {{!RFC7231}} is a technique to communicate information about the lifecycle of a resource. It encourages applications to migrate away from the resource, discourages applications from forming new dependencies on the resource, and informs applications about the risk of continuing dependence upon the resource.

The act of deprecation does not change any behavior of the resource. It just informs client of the fact that a resource is deprecated. The Deprecation HTTP response header field MAY be used to convey this fact at runtime to clients. The header field can carry information indicating since when the deprecation is in effect.

In addition to the Deprecation header field the resource provider can use other header fields to convey additional information related to deprecation. For example, information such as where to find documentation related to the deprecation or what should be used as an alternate and when the deprecated resource would be unreachable, etc. Alternates of a resource can be similar resource(s) or a newer version of the same resource.


##  Notational Conventions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 {{!RFC2119}} {{!RFC8174}} when, and only when, they appear in all capitals, as shown here.

This specification uses the Augmented Backus-Naur Form (ABNF) notation of {{!RFC5234}} and includes, by reference, the IMF-fixdate rule as defined in Section 7.1.1.1 of {{!RFC7231}}.

The term "resource" is to be interpreted as defined in Section 2 of {{!RFC7231}}, that is identified by an URI.

# The Deprecation HTTP Response Header

The `Deprecation` HTTP response header field allows a server to communicate to a client that the resource in context of the message is or will be deprecated.

## Syntax

The `Deprecation` response header field describes the deprecation. It either shows the deprecation date, which may be in the future (the resource context will be deprecated at that date) or in the past (the resource context has been deprecated at that date), or it simply flags the resource context as being deprecated:

    Deprecation = IMF-fixdate / "true"

Servers MUST NOT include more than one `Deprecation` header field in the same response.

The date, if present, is the date when the resource context was or will be deprecated. It is in the form of an IMF-fixdate timestamp.

The following example shows that the resource context has been deprecated on Friday, November 11, 2018 at 23:59:59 GMT:

    Deprecation: Sun, 11 Nov 2018 23:59:59 GMT

The deprecation date can be in the future. If the value of `date` is in the future, it means that the resource will be deprecated at the given date in future.

If the deprecation date is not known, the header field can carry the simple string "true", indicating that the resource context is deprecated, without indicating when that happened:


	Deprecation: true





# The Deprecation Link Relation Type

In addition to the Deprecation HTTP header field, the server can use links with the "deprecation" link relation type to communicate to the client where to find more information about deprecation of the context. This can happen before the actual deprecation, to make a deprecation policy discoverable, or after deprecation, when there may be documentation about the deprecation, and possibly documentation of how to manage it.

This specification places no restrictions on the representation of the interlinked deprecation policy. In particular, the deprecation policy may be available as human-readable documentation or as machine-readable description.


## Documentation

For a resource, deprecation could involve one or more parts of request, response or both. These parts could be one or more of the following.

* URI - deprecation of one ore more query parameter(s) or path element(s)
* method - HTTP method for the resource is deprecated
* request header - one or more HTTP request header(s) is deprecated
* response header - HTTP response header(s) is deprecated
* request body - request body contains one or more deprecated element(s)
* response body - response body contains one or more deprecated element(s)

The purpose of the `Deprecation` header is to provide just enough "hints" about the deprecation to the client application developer. It is safe to assume that on reception of the `Deprecation` header, the client developer would look up the resource's documentation in order to find deprecation related semantics. The resource developer could provide a link to the resource documentation using a `Link` header with relation type `deprecation` as shown below.

    Link: <https://developer.example.com/deprecation>;
          rel="deprecation"; type="text/html"

In this example the interlinked content provides additional information about the deprecation of the resource context. There is no Deprecation header field in the response, and thus the resource is not deprecated. However, the resource already exposes a link where information is available how deprecation is managed for the context. This may be documentation explaining the use of the Deprecation header field, and also explaining under which circumstances and with which policies (announcement before deprecation; continued operation after deprecation) deprecation might be happening.

The following example uses the same link header, but also announces a deprecation date using a Deprecation header field.

    Deprecation: Sun, 11 Nov 2018 23:59:59 GMT
    Link: <https://developer.example.com/deprecation>;
          rel="deprecation"; type="text/html"

Given that the deprecation date is in the past, the linked resource may have been updated to include information about the deprecation, allowing clients to discover information about the deprecation that happened.


# Recommend Replacement

The `Link` {{!RFC8288}} header field can be used in addition to the `Deprecation` header field to inform the client about available alternatives to the deprecated resource. The following relation types as defined in {{!RFC8288}} are RECOMMENDED to use for this purpose:

* `successor-version`: Points to a resource containing the successor version. {{?RFC5829}}
* `latest-version`: Points to a resource containing the latest (e.g., current) version. {{?RFC5829}}
* `alternate`: Designates a substitute. [W3C.REC-html401-19991224]

The following example provides link to the successor version of the requested resource that is deprecated.

    Deprecation: Sun, 11 Nov 2018 23:59:59 GMT
    Link: <https://api.example.com/v2/customers>; rel="successor-version"

This example provides link to an alternate resource to the requested resource that is deprecated.

    Deprecation: Sun, 11 Nov 2018 23:59:59 GMT
    Link: <https://api.example.com/v1/clients>; rel="alternate"


# Sunset


In addition to the deprecation related information, if the resource provider wants to convey to the client application that the deprecated resource is expected to become unresponsive at a specific point in time, the Sunset HTTP header field {{?RFC8594}} can be used in addition to the `Deprecation` header.

The timestamp given in the `Sunset` header field MUST be the later or the same as the one given in the `Deprecation` header field.

The following example shows that the resource in context has been deprecated since Sunday, November 11, 2018 at 23:59:59 GMT and its sunset date is Wednesday, November 11, 2020 at 23:59:59 GMT.

    Deprecation: Sun, 11 Nov 2018 23:59:59 GMT
    Sunset: Wed, 11 Nov 2020 23:59:59 GMT

# Resource Behavior

The act of deprecation does not change any behavior of the resource. Deprecated resources SHOULD keep functioning as before, allowing consumers to still use the resources in the same way as they did before the resources were declared deprecated.

# IANA Considerations

## The Deprecation HTTP Response Header

The `Deprecation` response header should be added to the permanent registry of message header fields (see {{!RFC3864}}), taking into account the guidelines given by HTTP/1.1 {{!RFC7231}}.

    Header Field Name: Deprecation

    Applicable Protocol: Hypertext Transfer Protocol (HTTP)

    Status: Standard

    Author: Sanjay Dalal <sanjay.dalal@cal.berkeley.edu>,
            Erik Wilde <erik.wilde@dret.net>

    Change controller: IETF

    Specification document: this specification,
                Section 2 "The Deprecation HTTP Response Header"



## The Deprecation Link Relation Type

The `deprecation` link relation type should be added to the permanent registry of link relation types according to Section 4.2 of {{!RFC8288}}:

    Relation Type: deprecation

    Applicable Protocol: Hypertext Transfer Protocol (HTTP)

    Status: Standard

    Author: Sanjay Dalal <sanjay.dalal@cal.berkeley.edu>,
            Erik Wilde <erik.wilde@dret.net>

    Change controller: IETF

    Specification document: this specification,
            Section 3 "The Deprecation Link Relation Type"



# Implementation Status

Note to RFC Editor: Please remove this section before publication.

This section records the status of known implementations of the protocol defined by this specification at the time of posting of this Internet-Draft, and is based on a proposal described in {{?RFC7942}}.  The description of implementations in this section is intended to assist the IETF in its decision processes in progressing drafts to RFCs.  Please note that the listing of any individual implementation here does not imply endorsement by the IETF. Furthermore, no effort has been spent to verify the information presented here that was supplied by IETF contributors.  This is not intended as, and must not be construed to be, a catalog of available implementations or their features.  Readers are advised to note that
other implementations may exist.

According to RFC 7942, "this will allow reviewers and working groups to assign due consideration to documents that have the benefit of running code, which may serve as evidence of valuable experimentation and feedback that have made the implemented protocols more mature. It is up to the individual working groups to use this information as they see fit".

## Implementing the Deprecation Header

This is a list of implementations that implement the deprecation header field:

Organization: Apollo

- Description: Deprecation header is returned when deprecated functionality (as declared in the GraphQL schema) is accessed
- Reference: https://www.npmjs.com/package/apollo-server-tools

Organization: Zalando

- Description: Deprecation header is recommended as the preferred way to communicate API deprecation in Zalando API designs.
- Reference: https://opensource.zalando.com/restful-api-guidelines/#deprecation

Organization: Palantir Technologies

- Description: Deprecation header is incorporated in code generated by conjure-java, a CLI to generate Java POJOs and interfaces from Conjure API definitions
- Reference: https://github.com/palantir/conjure-java

Organization: IETF Internet Draft, Registration Protocols Extensions

- Description: Deprecation link relation is returned in Registration Data Access Protocol (RDAP) notices to indicate deprecation of jCard in favor of JSContact.
- Reference: https://tools.ietf.org/html/draft-loffredo-regext-rdap-jcard-deprecation

Organization:  E-Voyageurs Technologies

* Description: Deprecation header is incorporated in Hesperides, a configuration management tool providing universal text file templating and properties editing through a REST API or a webapp.
* Reference: https://github.com/voyages-sncf-technologies/hesperides/blob/master/documentation/lightweight-architecture-decision-records/deprecated_endpoints.md

Organization: Open-Xchange

* Description: Deprecation header is used in Open-Xchange appsuite-middleware
* Reference: https://github.com/open-xchange/appsuite-middleware

Organization: MediaWiki

* Description: Core REST API of MediaWiki would use Deprecation header for endpoints that have been deprecated because a new endpoint provides the same or better functionality.
* Reference: https://phabricator.wikimedia.org/T232485



## Implementing the Concept

This is a list of implementations that implement the general concept, but do so using different mechanisms:

Organization: Zapier

- Description: Zapier uses two custom HTTP headers named `X-API-Deprecation-Date` and `X-API-Deprecation-Info`
- Reference:  https://zapier.com/engineering/api-geriatrics/

Organization: IBM

- Description: IBM uses a custom HTTP header named `Deprecated`
- Reference: https://www.ibm.com/support/knowledgecenter/en/SS42VS_7.3.1/com.ibm.qradar.doc/c_rest_api_getting_started.html

Organization: Ultipro

- Description: Ultipro uses the HTTP `Warning` header as described in Section 5.5 of {{!RFC7234}} with code `299`
- Reference:  https://connect.ultipro.com/api-deprecation

Organization: Clearbit

- Description: Clearbit uses a custom HTTP header named `X-API-Warn`
- Reference: https://blog.clearbit.com/dealing-with-deprecation/

Organization: PayPal

- Description: PayPal uses a custom HTTP header named `PayPal-Deprecated`
- Reference: https://github.com/paypal/api-standards/blob/master/api-style-guide.md#runtime


# Security Considerations

The Deprecation header field SHOULD be treated as a hint, meaning that the resource is indicating (and not guaranteeing with certainty) that it is deprecated. Applications consuming the resource SHOULD check the resource documentation to verify authenticity and accuracy. Resource documentation SHOULD provide additional information about the deprecation including recommendation(s) for replacement.

In cases, where the Deprecation header field value is a date in future, it can lead to information that otherwise might not be available. Therefore, applications consuming the resource SHOULD verify the resource documentation and if possible, consult the resource developer to discuss potential impact due to deprecation and plan for possible transition to recommended resource.

In cases where `Link` header is used to provide more documentation and/or recommendation for replacement, one should assume that the content of the  `Link` header field may not be secure, private or integrity-guaranteed, and due caution should be exercised when using it. Applications consuming the resource SHOULD check the referred resource documentation to verify authenticity and accuracy.

The suggested `Link` header fields make extensive use of IRIs and URIs. See {{!RFC3987}} for security considerations relating to IRIs. See {{!RFC3986}} for security considerations relating to URIs. See {{!RFC7230}} for security considerations relating to HTTP headers.

Applications that take advantage of typed links should consider the attack vectors opened by automatically following, trusting, or otherwise using links gathered from the HTTP headers. In particular, Link headers that use the `successor-version`, `latest-version` or `alternate` relation types should be treated with due caution. See {{?RFC5829}} for security considerations relating to these link relation types.



# Examples

The first example shows a deprecation header field without date information:

    Deprecation: true

The second example shows a deprecation header with date information and a link to the successor version:

    Deprecation: Sun, 11 Nov 2018 23:59:59 GMT
    Link: <https://api.example.com/v2/customers>; rel="successor-version"

The third example shows a deprecation header field with links for the successor version and for the API's deprecation policy. In addition, it shows the sunset date for the deprecated resource:

    Deprecation: Sun, 11 Nov 2018 23:59:59 GMT
    Sunset: Wed, 11 Nov 2020 23:59:59 GMT
    Link: <https://api.example.com/v2/customers>; rel="successor-version",
          <https://developer.example.com/deprecation>; rel="deprecation"



--- back


# Acknowledgments


The authors would like to thank Nikhil Kolekar, Mark Nottingham, and Roberto Polli for their contributions.

The authors take all responsibility for errors and omissions.

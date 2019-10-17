# Communicating Warning Information in HTTP APIs

Clients that are communicating with modern HTTP APIs are relying on the fact, that calls either are
successful or they fail. But what about those (edge) cases, when the original intent was successful
but there where also warnings? API consumers should be able to receive and identify them as easy as
possible.

This document proposes a standard response format for HTTP API warning information, that should
make things easier for users of an API.

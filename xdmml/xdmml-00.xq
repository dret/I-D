module namespace xdmml = "urn:ietf:rfc:XXXX" ;

declare function xdmml:write($items as item()*) as element()
{ <items xmlns="urn:ietf:rfc:XXXX">
    { for $item in $items
        return <item> { $item } </item>
    }
    </items>
} ;
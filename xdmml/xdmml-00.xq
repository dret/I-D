module namespace xdmml = "urn:ietf:rfc:XXXX" ;

declare function xdmml:write($items as item()*) as element()
{ <items xmlns="urn:ietf:rfc:XXXX">
    { for $item in $items
        return <item>
            { typeswitch ($item)
                case document-node()
                    return ( attribute {'type'} {'document()'}, $item )
                case element()
                    return ( attribute {'type'} {'element()'}, $item )
                case attribute()
                    return ( attribute {'type'} {'attribute()'}, <dummy> { $item } </dummy> )
(:                case namespace-node()
                    return ( attribute {'type'} {'namespace'}, $item ) :)
                case processing-instruction()
                    return ( attribute {'type'} {'processing-instruction()'}, $item )
                case comment()
                    return ( attribute {'type'} {'comment()'}, $item )
                case text()
                    return ( attribute {'type'} {'text()'}, $item )
                default 
                    return ( attribute {'type'} {'dunno'}, $item )
            }
            </item>
    }
    </items>
} ;
import module namespace xdmml = "urn:ietf:rfc:XXXX" at "xdmml-00.xq" ;

for $i in <root att="42">content</root> return xdmml:write(( $i, $i//@att, 42, "hello" ))
import module namespace xdmml = "urn:ietf:rfc:XXXX" at "xdmml-00.xq" ;

for $i in <elem att="42">content</elem> return xdmml:write(( $i, $i//root, $i//@att, 42, "hello" ))
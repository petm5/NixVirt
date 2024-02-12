pkgs: lib:
let
  test = xlib: dirpath:
    let
      found = xlib.writeXML ((import "${dirpath}/input.nix") lib);
      expected = "${dirpath}/expected.xml";
    in
    pkgs.runCommand "check" { }
      ''
        diff -u ${expected} ${found}
        echo "pass" > $out
      '';
in
{
  network-empty = test lib.network network/empty;
  network-bridge = test lib.network network/bridge;

  domain-empty = test lib.domain domain/empty;
  domain-sample-q35 = test lib.domain domain/sample-q35;
  domain-sample-windows = test lib.domain domain/sample-windows;
  domain-win11 = test lib.domain domain/win11;

  pool-empty = test lib.pool pool/empty;
}

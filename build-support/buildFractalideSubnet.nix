{ stdenv, genName, writeTextFile #, fvm
  }:
  { src
    , subnetDeps
    , ... } @ args:
  let
  name = genName src;
  text = src + "/lib.subnet";
  subnet-txt = writeTextFile {
    name = name;
    text = builtins.readFile text;
    executable = false;
  };
  in stdenv.mkDerivation  (args // {
    name = name;
    unpackPhase = "true";
    installPhase = ''
    mkdir -p $out/lib
    ${stdenv.lib.concatMapStringsSep "\n"
      (dep: "ln -s ${dep.outPath}/lib/*.* $out/lib/${dep.name};")
      (stdenv.lib.flatten subnetDeps)}
    cp ${subnet-txt} $out/lib/lib.subnet'';
    #checkPhase = "fvm test $out/lib/lib.subnet";
  })

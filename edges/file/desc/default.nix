{ edge, edges }:

edge {
  src = ./.;
  edges =  with edges; [];
  schema = with edges; ''
    @0xaf73df75f011fbb3;

    struct FileDesc {
        union {
          start @0 :Text;
          text @1 :Text;
          end @2 :Text;
        }
    }
  '';
}

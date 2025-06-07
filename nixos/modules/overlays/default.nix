{
  nixpkgs.overlays = [
    (self: super: {
      oh-my-posh = super.callPackage ./packages/oh-my-posh.nix { };
    })
  ];
}

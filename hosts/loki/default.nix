{lib, ...}:
with lib.custom; {
  imports = [
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  # Add your SSH public key to the default user
  # Enable QEMU guest agent (optional but recommended)
  services.qemuGuest.enable = true;
}

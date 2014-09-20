{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./common/base.nix
    ./common/sshd.nix
  ];
  boot = {
    initrd.supportedFilesystems = [ "btrfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader.grub.device = "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z5006BG5";
  };
  fileSystems."/" = {
    label = "root";
    fsType = "btrfs";
    options = "defaults,noatime,compress=lzo,space_cache";
  };
  networking.hostName = "hunter";
  services.udev.extraRules = ''
    KERNEL=="eth*", ATTR{address}=="00:a0:d1:ec:a7:10", NAME="1g1"
    KERNEL=="eth*", ATTR{address}=="00:a0:d1:ec:a7:11", NAME="1g2"
    KERNEL=="eth*", ATTR{address}=="00:02:c9:3c:e3:10", NAME="10g1"
    KERNEL=="eth*", ATTR{address}=="00:02:c9:3c:e3:11", NAME="10g2"
  '';
  time.timeZone = "America/Los_Angeles";
}

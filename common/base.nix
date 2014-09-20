{ config, pkgs, ... }:
{
  imports = [
    ./sub/base.dns.nix
    ./sub/base.firewall.nix
  ];
  boot = {
    extraModprobeConfig = ''
      options kvm-amd nested=1
      options kvm-intel nested=1
    '';
    kernel.sysctl = {
      "net.ipv6.conf.all.use_tempaddr" = 2;
      "net.ipv6.conf.default.use_tempaddr" = 2;
    };
  };
  environment.systemPackages = with pkgs; [
    acpi
    atop
    dnstop
    fish
    git
    gptfdisk
    htop
    iftop
    iotop
    iperf
    iptables
    mtr
    nmap
    config.programs.ssh.package
    openssl
    psmisc
    sysstat
    tcpdump
    tmux
    vim
  ];
  hardware.cpu.intel.updateMicrocode = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    nrBuildUsers = config.nix.maxJobs * 10;
    useChroot = true;
    binaryCaches = pkgs.lib.mkBefore [ "http://cache.nixos.org" "http://hydra.nixos.org" ];
  };
  programs = {
    bash = {
      enableCompletion = true;
      promptInit = "PS1=\"[\\u@\\h:\\w]\\\\$ \"\n";
    };
    ssh.startAgent = false;
  };
  security.sudo.enable = false;
  services = {
    cron.enable = false;
    journald.extraConfig = "SystemMaxUse=50M";
  };
  users = {
    mutableUsers = false;
    extraUsers.root.hashedPassword = null;
  };
}

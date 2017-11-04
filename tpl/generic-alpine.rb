# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # config.vm.box = "generic/bazinga"
  # config.vm.hostname = "bazinga.box"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.box_check_update = true
  config.vm.box_download_checksum = true
  
  config.vm.box_download_checksum_type = "sha256"
  # config.vm.provision "shell", run: "always", inline: <<-SHELL
  # SHELL

  # Adding a second CPU and increasing the RAM to 2048MB will speed
  # things up considerably should you decide to do anythinc with this box.
  config.vm.provider :hyperv do |v, override|
    v.maxmemory = 2048
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provider :libvirt do |v, override|
    v.driver = "kvm"
    v.video_vram = 256
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provider :parallels do |v, override|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provider :virtualbox do |v, override|
    v.gui = false
    v.functional_vboxsf = false
    v.check_guest_additions = false
    v.customize ["modifyvm", :id, "--cpus", 2]
    v.customize ["modifyvm", :id, "--memory", 2048]
  end

  ["vmware_fusion", "vmware_workstation", "vmware_desktop"].each do |provider|
    config.vm.provider provider do |v, override|
      v.gui = false
      v.functional_hgfs = false
      v.vmx["numvcpus"] = "2"
      v.vmx["memsize"] = "2048"
      v.vmx["cpuid.coresPerSocket"] = "1"
    end
  end

end
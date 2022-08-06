variable "headless" {
  type    = string
  default = "true"
}

variable "shutdown_command" {
  type    = string
  default = "sudo /sbin/halt -p"
}

variable "version" {
  type    = string
  default = "8.4-2105"
}

variable "url" {
  type    = string
  default = "http://f.p2x-3yz.us/ISOs/Rocky-8.6-x86_64-dvd1.iso"
}

variable "checksum" {
  type    = string
  default = "1d48e0af63d07ff4e582a1819348e714c694e7fd33207f48879c2bc806960786"
}

source "vmware-iso" "vmware" {
  boot_command                   = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
  disk_size                      = "100000"
  guest_os_type                  = "centos-64"
  headless                       = "${var.headless}"
  http_directory                 = "http"
  iso_checksum                   = "sha256:${var.checksum}"
  iso_url                        = "${var.url}"
  shutdown_command               = "${var.shutdown_command}"
  ssh_password                   = "vagrant"
  ssh_timeout                    = "20m"
  ssh_username                   = "vagrant"
  tools_upload_flavor            = "linux"
  vmx_remove_ethernet_interfaces = "true"
}

build {
  sources = ["source.vmware-iso.vmware"]

  provisioner "shell" {
    execute_command = "sudo {{ .Vars }} sh {{ .Path }}"
    scripts         = ["scripts/vagrant.sh", "scripts/update.sh", "scripts/vmtools.sh", "scripts/zerodisk.sh"]
  }

  post-processor "vagrant" {
    output = "Rocky-${var.version}-x86_64-${source.name}.box"
  }
}


resource "libvirt_volume" "test1_disk" {
  name = "test1.qcow2"
  source = "/var/lib/libvirt/images/noble-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_domain" "test1" {
    name   = "test1"
    memory = 2048
    vcpu   = 2

    network_interface {
        network_name = "default"
    }

    disk {
        volume_id = libvirt_volume.test1_disk.id
    }

    console {
        type         = "pty"
        target_type  = "serial"
        target_port  = "0"
    }

    graphics {
        type           = "vnc"
        listen_type    = "address"
        listen_address = "0.0.0.0"
        autoport       = true
    }
}
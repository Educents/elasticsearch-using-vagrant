VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", 1536]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    config.vm.define "ubuntu" do |ubuntu|
        ubuntu.vm.hostname = "elastic1"
        ubuntu.vm.box = "ubuntu/trusty64"
        ubuntu.vm.network :forwarded_port, guest: 9200, host: 9200
        ubuntu.vm.network :forwarded_port, guest: 5601, host: 5601
        ubuntu.vm.provision :shell, :path => "ubuntubootstrap.sh"
        ubuntu.vm.provision :shell, :path => "plugins.sh"
        ubuntu.vm.provider :virtualbox do |v|
            v.name = "ubuntu_elasticsearch"
        end
    end

    config.vm.define "centos", autostart: false do |centos|
        centos.vm.hostname = "elastic2"
        centos.vm.box = "centos/7"
        centos.vm.network :forwarded_port, guest: 9200, host: 9202
        centos.vm.network :forwarded_port, guest: 5601, host: 5603
        centos.vm.provision :shell, :path => "centosbootstrap.sh"
        centos.vm.provision :shell, :path => "plugins.sh"
        centos.vm.provider :virtualbox do |v|
            v.name = "centos_elasticsearch"
        end
    end
end

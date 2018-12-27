VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", 4096]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    config.vm.define "elastic" do |elastic|
        elastic.vm.hostname = "elastic"
        elastic.vm.box = "ubuntu/xenial64"
        elastic.vm.network :forwarded_port, guest: 9200, host: 9200
        elastic.vm.network :forwarded_port, guest: 5601, host: 5601
        elastic.vm.provision :shell, :path => "ubuntubootstrap.sh"
        elastic.vm.provider :virtualbox do |v|
            v.name = "elasticsearch_ubuntu"
        end
    end
end

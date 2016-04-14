VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", 1536]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    config.vm.define "es1" do |es1|
        es1.vm.hostname = "elastic1"
        es1.vm.box = "ubuntu/trusty64"
        es1.vm.network :forwarded_port, guest: 9200, host: 9200
        es1.vm.network :forwarded_port, guest: 5601, host: 5601
        es1.vm.provision :shell, :path => "bootstrap.sh"
        es1.vm.provider :virtualbox do |v|
            v.name = "es1"
        end
    end
end

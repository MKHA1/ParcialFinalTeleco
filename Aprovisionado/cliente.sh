
sudo -i

sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*

sudo sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*

sudo dnf clean all

sudo dnf swap centos-linux-repos centos-stream-repos

sudo dnf update -y rpm

sudo yum install -y vi

sysctl net.ipv4.ip_forward=1

sudo systemctl restart NetworkManager

sudo systemctl start firewalld

iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.50.3:8080

iptables -t nat -A POSTROUTING -j MASQUERADE

firewall-cmd --zone=internal --change-interface=eth1

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eth0 -j MASQUERADE

firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth0 -j ACCEPT

firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
 
firewall-cmd --zone=public --add-service=http
  
firewall-cmd --zone=public --add-service=https


firewall-cmd --zone=public --add-service=dns


firewall-cmd --zone=internal --add-service=dns

firewall-cmd --zone=internal --add-service=http

firewall-cmd --zone=internal --add-service=https
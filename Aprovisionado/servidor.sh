
sudo -i
sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*

sudo sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*

sudo dnf clean all

sudo dnf swap centos-linux-repos centos-stream-repos

sudo dnf update -y rpm

sudo dnf -y update

sudo yum install -y java-1.8.0-openjdk-headless

sudo yum install -y java-1.8.0-openjdk-devel

sudo yum install -y vi

sudo vi /etc/environment  

echo "JAVA_HOME=/etc/alternatives/jre" >> /etc/environment

source /etc/environment

yum -y install wget

wget https://github.com/dularion/streama/releases/download/v1.1/streama-1.1.war

mkdir /opt/streama

mv streama-1.1.war /opt/streama/streama.war
 
mkdir /opt/streama/media

chmod 664 /opt/streama/media

 

echo "[Unit]
Description=Streama Server
After=syslog.target
After=network.target

[Service]
User=root
Type=simple
ExecStart=/bin/java -jar /opt/streama/streama.war
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=Streama

[Install]
WantedBy=multi-user.target" >> /etc/environment
 
systemctl start streama

systemctl enable streama

systemctl status streama

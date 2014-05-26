FROM centos
RUN yum install -y http://swupdate.openvpn.org/as/openvpn-as-1.8.5-CentOS6.x86_64.rpm
ADD start.sh /start_ovpnas
RUN echo "openvpn" | passwd --stdin openvpn
VOLUME /usr/local/openvpn_as
EXPOSE 443 1194
ENTRYPOINT ["/start_ovpnas"]

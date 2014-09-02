FROM     centos:centos6

RUN yum update -y

RUN yum -y install openssh openssh-server openssh-clients
RUN service sshd start; service sshd stop
RUN sed -i '/pam_loginuid\.so/s/required/optional/' /etc/pam.d/sshd

RUN yum -y install tar wget rpm-build xterm
RUN yum -y install autoconf automake libtool
RUN yum -y install gcc gcc-c++

ADD startup.sh /src/startup.sh
ADD rpmmacros /etc/skel/.rpmmacros

RUN mkdir -p /etc/skel/rpm/BUILD /etc/skel/rpm/SRPMS /etc/skel/rpm/SOURCES /etc/skel/rpm/SPECS /etc/skel/rpm/RPMS/x86_64 /etc/skel/rpm/RPMS/noarch

EXPOSE 22
CMD ["/src/startup.sh"]

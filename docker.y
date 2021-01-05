- hosts: mylb
  tasks:
  - yum_repository: 
      description: "repo to install docker"
      name: "docker"
      baseurl: https://download.docker.com/linux/centos/7/x86_64/stable
      gpgcheck: no
  - package:
      name: "docker-ce-18.09.1-3.el7.x86_64"
      state: present
  - service:
      name: "docker"
      state: started
      enabled: yes
  - pip:
      name: "docker"
  - docker_image:
      name: httpd
      source: pull
  - file:
      path: "/root/sites"
      state: directory

  - copy: 
      src: "profile.html"
      dest: "/root/sites"
  - docker_container:
      name: "testingos"
      image: "httpd"
      exposed_ports:
         - "80"
      ports: 
         - "8080:80"
      state: started
      volumes: "/root/sites:/usr/local/apache2/htdocs/"
  - firewalld:
        state: enabled
        permanent: yes
        immediate: yes
   
     

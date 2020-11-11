FROM centos:7

RUN yum -y update
RUN yum -y install epel-release

#php7.2をインストール
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
ADD php72/remi-php72.repo /etc/yum.repos.d/
RUN yum -y install php
RUN yum -y install php-fpm php-mbstring php-gd php-opcache php-xml php-mysqlnd
#Apacheをインストール
RUN yum -y install httpd
#mariadbをインストール
RUN yum -y install mariadb mariadb-server
#設定ファイルを反映
ADD httpd/httpd.conf /etc/httpd/conf/
ADD php72/php.ini /etc/
RUN mkdir /opt/www
ADD app/phpinfo.php /opt/www/
#常に起動させておく
RUN systemctl enable httpd
RUN systemctl enable php-fpm
RUN systemctl enable mariadb
#ポート開放
EXPOSE 3306
EXPOSE 80
CMD ["/sbin/init"]
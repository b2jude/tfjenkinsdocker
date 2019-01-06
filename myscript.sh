#!/bin/bash
yum update -y && \
yum install -y httpd && \
service httpd start && \
chkconfig httpd on && \
#echo "<h1>Welcome to Revport application version 1.1</h1>" > /var/www/html/index.html && \
echo '<H1 style="color:red;">Welcome to application version 2.0</H1>' > /var/www/html/index.html && \
chmod 644 /var/www/html/index.html && \
chown root:root /var/www/html/index.html && \
echo "installation was successfull in green server" \
echo "installation failed on green server"

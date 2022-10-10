user www-data;

events {}

http {

 include mime.types;

 log_format compression '$remote_addr - $remote_user [$time_local]'
                        '"$request" $status $body_bytes_sent '
                        '"$http_referer" "$http_user_agent" "$gzip_ratio"';

#upstream fastcgi_params {
#server unix:/run/php/php8.1-fpm.sock;
#}


 server {
  listen 80;
  server_name 10.0.0.8;

  root /site/demo;

  index index.php;

  access_log /var/log/nginx/10.0.0.8.access.log compression;
  error_log /var/log/nginx/10.0.0.8.error.log;

location ~* \.php$ {
    fastcgi_index   index.php;
    #fastcgi_pass    10.0.0.8:80;
    include         fastcgi_params;
    fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
    fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
}

#  location ~\.php$ {
#   include fastcgi_params;
#   fastcgi_pass unix:/run/php/php8.1-fpm.sock;
#  }

 }
}

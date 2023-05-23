server {
        #listen 80 default_server;
        #listen [::]:80 default_server;

        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/example.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name example.com www.example.com;

        location / {
                try_files $uri $uri/ =404;
        }
}

uncomment line from file /etc/nginx/nginx.conf "server_names_hash_bucket_size 64;"

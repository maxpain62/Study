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

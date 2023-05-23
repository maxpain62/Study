server {
        #listen 80 default_server;
        #listen [::]:80 default_server;
        #"default_server" directive is used for Only one of our server blocks on the server can have the default_server option enabled. 
        #This specifies which block should serve a request if the server_name requested does not match any of the available server blocks.

        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/example.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name example.com www.example.com;

        location / {
                try_files $uri $uri/ =404;
        }
}

#uncomment line from file /etc/nginx/nginx.conf "server_names_hash_bucket_size 64;"

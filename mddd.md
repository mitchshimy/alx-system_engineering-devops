USER ACTION
===========
[User's Web Browser]
        |
        |-- Types "www.foobar.com"
        v

DNS RESOLUTION
==============
[DNS Resolver]
        |
        |-- Queries authoritative DNS for "www.foobar.com"
        |-- Receives IP: 8.8.8.8
        v

HTTP REQUEST
============
[Web Browser]
        |
        |-- Sends HTTP request to 8.8.8.8
        v

NGINX HANDLING
==============
[Nginx Web Server]
        |
        |-- Is it a STATIC file (e.g., .js, .css, .jpg)?
        |         |
        |         |---> Yes ---> [Serve from Application Files] ---> Done ✔
        |
        |-- No ---> Dynamic Request (e.g., PHP, API call)
        v

APPLICATION SERVER
==================
[App Server]
        |
        |-- Processes request
        |-- Needs data?
        |         |
        |         |---> Yes ---> Query MySQL
        |                         v
        |                    [MySQL Database]
        |                         |
        |                         |-- Returns result set
        |                         v
        |                    [App Server continues...]
        |
        |-- Generates final HTML response
        v

BACK TO NGINX
=============
[Nginx Web Server]
        |
        |-- Receives HTML from App Server
        v

HTTP RESPONSE
=============
[Web Browser]
        |
        |-- Receives rendered HTML or static content
        v
      [✔ Page Loaded]

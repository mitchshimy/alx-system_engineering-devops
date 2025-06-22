# Simple Web Stack - Infrastructure Explanation

## 🧠 Key Concepts Explained

### 🔌 What is a Server?
A **server** is a powerful computer that provides services, resources, or data to other computers (called clients) over a network. In our case, it's the machine hosting Nginx, the application code, and the database.

---

### 🌐 What is the Role of the Domain Name?
A **domain name** like `www.foobar.com` serves as a human-friendly alias to access a web server. Instead of typing the IP address (e.g., 8.8.8.8), users type the domain name, which gets resolved to the IP address via DNS.

---

### 📇 What Type of DNS Record is `www` in `www.foobar.com`?
The `www` subdomain is typically represented by an **A record** (Address Record) in DNS.  
It maps the hostname `www.foobar.com` to the IP address of the server (`8.8.8.8`).

---

### 🌍 What is the Role of the Web Server (Nginx)?
The **web server (Nginx)** listens for HTTP requests. It:
- Serves **static files** directly (images, CSS, JS)
- Forwards **dynamic requests** (e.g., `.php`, `.py`) to the application server

---

### ⚙️ What is the Role of the Application Server?
The **application server** processes dynamic content and business logic.
- It handles requests that require computation or interaction with a database
- It returns generated HTML back to Nginx to serve to the user

---

### 🗄️ What is the Role of the Database?
The **MySQL database** stores and manages structured data.
- The application server queries it for information
- It returns results needed to build the final HTML response

---

### 🧵 What is the Server Using to Communicate with the User’s Computer?
The server communicates over the **HTTP (or HTTPS)** protocol using **TCP/IP**.
- HTTP is used for data exchange between the client (browser) and the server
- HTTPS adds encryption for secure transmission

---

## ⚠️ Infrastructure Limitations

### 🧨 SPOF (Single Point of Failure)
- This setup uses only **one server**
- If that server crashes or goes offline, the entire website becomes inaccessible

### 🛠️ Downtime During Maintenance
- Updates or deployments require restarting services like Nginx
- This causes **temporary downtime** for all users

### 📈 Cannot Scale with Traffic
- One server handles **all requests**
- Under high traffic, the server can become overwhelmed (CPU, RAM, bandwidth)
- No load balancing or horizontal scaling is possible in this setup

---

## 💡 Summary

This simple infrastructure is great for small applications or prototypes, but lacks:
- High availability
- Fault tolerance
- Scalability
- Security hardening

Improvements will be addressed in the next stages of this project, including distributed architectures and secured environments.


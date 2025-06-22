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


# Distributed Web Infrastructure

## 🧱 Components Overview

### 🔹 Load Balancer (HAProxy)
**Why?**  
To distribute incoming traffic across servers and avoid overloading a single point. Ensures high availability and scalability.

---

### 🔹 Web & Application Server (Nginx + App)
**Why?**  
Combines static file serving and dynamic content generation into one server to reduce latency and cost in a small distributed setup.

---

### 🔹 MySQL Database
**Why?**  
Stores application data in a structured format and allows persistent storage across sessions.

---

## 🔀 Load Balancer Algorithm

We use the **Round Robin** distribution algorithm.

### 🔁 How it works:
- Each incoming request is forwarded to the next available backend server in a circular order.
- This method provides **simple and fair load distribution**, assuming backend servers are equally powerful.

---

## ⚖️ Active-Active vs Active-Passive

### ✅ Active-Active
- **Multiple servers are online and serving traffic simultaneously**
- Load is distributed across all servers
- If one fails, others continue without interruption

### ❌ Active-Passive
- **One server handles traffic**, others remain on standby
- If the active one fails, a passive server takes over
- **Less efficient use of resources**

**This infrastructure uses an _Active-Active_ setup** (web server handles traffic, database is still single-writer though)

---

## 🗃️ Primary-Replica (Master-Slave) Database Cluster

While **not implemented in this current version**, understanding replication is key:

### 🔄 How it works:
- The **Primary (Master)** handles **write operations**
- The **Replica (Slave)** handles **read operations** and **replicates changes** from the master in real-time or asynchronously

### 🤝 Application Interaction:
- **Writes** (e.g., user registration, updates) → go to **Primary**
- **Reads** (e.g., user profiles, listings) → can go to **Replica** to reduce load

---

## ⚠️ Infrastructure Issues

### 🧨 SPOF (Single Point of Failure)
- The **database** is still a **SPOF**
- If the DB fails, the entire app becomes unusable

---

### 🔐 Security Issues
- **No firewalls**: Open ports can expose servers to attacks
- **No HTTPS**: Unencrypted traffic is vulnerable to man-in-the-middle (MITM) attacks

---

### 📉 Lack of Monitoring
- There's no system to:
  - Track traffic
  - Detect downtime
  - Measure resource usage (CPU, RAM, Disk)
- Makes debugging and scaling decisions much harder

---

## 🧠 Summary

| Component          | Purpose                                  |
|-------------------|------------------------------------------|
| HAProxy           | Distributes requests (Round Robin)       |
| Nginx             | Serves static content / proxies dynamic  |
| App Server        | Processes logic and DB interaction       |
| MySQL             | Persistent storage for app data          |

# Secured and Monitored Web Infrastructure

## 🔧 Why Each Additional Element Was Added

### 🔐 SSL Certificate (HTTPS)
- **Why?** To encrypt all communication between the client and the server, ensuring data confidentiality and protecting against man-in-the-middle attacks.

### 🔥 Firewalls (3 Total)
- **Why?** To restrict access to only necessary ports and authorized IPs between system components, reducing the attack surface.

### 📊 Monitoring Clients
- **Why?** To track system health, detect anomalies, and analyze performance metrics for all three servers (Load Balancer, Web/App Server, Database).

---

## 🔥 What Are Firewalls For?

Firewalls act as gatekeepers between networks or services. In this infrastructure, they are used to:

- **Block unauthorized traffic** (e.g., SSH access, irrelevant ports)
- **Enforce network boundaries** (e.g., DB only accepts traffic from App Server)
- **Protect internal components from external exposure**

Each server has its own firewall tailored to its function.

---

## 🔒 Why Is the Traffic Served Over HTTPS?

HTTPS provides:

- **End-to-end encryption**, protecting sensitive user data (e.g., login credentials)
- **Authentication**, ensuring users are connecting to the genuine `foobar.com`
- **Data integrity**, preventing request/response tampering

It's essential for user trust and compliance with modern web standards.

---

## 🧠 What Is Monitoring Used For?

Monitoring tools serve several critical roles:

- **Real-time visibility** into system performance
- **Alerting** for failures or anomalies (e.g., high CPU usage, DB downtime)
- **Historical analysis** for capacity planning and debugging
- **Security auditing** (e.g., tracking suspicious traffic patterns)

---

## 📡 How the Monitoring Tool Is Collecting Data

Each server runs a **monitoring agent**, such as:

- `SumoLogic`, `Prometheus Node Exporter`, or `Datadog Agent`

These agents:

- Collect metrics like CPU, memory, disk I/O, network usage
- Scrape logs (e.g., Nginx access/error logs, MySQL slow queries)
- Send data to a central **monitoring backend or dashboard** over secure channels

---

## 🔍 How to Monitor Web Server QPS (Queries Per Second)

To monitor QPS:

1. **Enable logging** in your web server (Nginx/Apache).
2. Use a **metrics collector** like:
   - Prometheus with `nginx_exporter`
   - SumoLogic log parsing
3. Query or visualize:
   - Count the number of requests over time
   - Example: `rate(http_requests_total[1m])` in Prometheus

Set up **dashboards or alerts** when QPS exceeds thresholds.

---

## ⚠️ Infrastructure Limitations & Issues

### 🚨 Terminating SSL at the Load Balancer Level

- **Problem**: SSL termination (decrypting HTTPS) at HAProxy means internal traffic (to app servers) may be unencrypted.
- **Risk**: If internal traffic is intercepted (e.g., misconfigured firewalls), sensitive data could leak.
- **Solution**: Use **end-to-end encryption** (re-encrypt from LB → App) or use **SSL passthrough** mode.

---

### 🚨 Single Write-Capable MySQL Server

- **Problem**: All writes go to one DB server. If it fails, **writes are blocked**, breaking application logic.
- **Risk**: Downtime and potential data loss if failover is not configured.
- **Solution**: Use **MySQL replication** with automatic failover, or switch to a clustered DB like Galera.

---

### 🚨 Homogeneous Servers (All-in-One Setup)

- **Problem**: Having each server run **web, app, and DB** logic increases:
  - **Attack surface**
  - **Resource contention**
  - **Configuration complexity**
- **Risk**: A failure in one service can bring down the others; hard to isolate issues.
- **Solution**: Keep services **separated by role** for clarity, security, and scalability.






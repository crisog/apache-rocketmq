# Deploy and Host Apache RocketMQ on Railway

Apache RocketMQ is a distributed messaging and streaming platform with low latency, high performance, reliability, and trillion-level capacity. It provides asynchronous communication between distributed systems and supports message ordering, transaction messages, scheduled messages, and message filtering for enterprise-grade applications.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/deploy/apache-rocketmq?referralCode=crisog)

## About Hosting Apache RocketMQ

Hosting Apache RocketMQ requires two core components working together: a NameServer for routing and coordination, and a Broker for message storage and delivery. The NameServer provides lightweight service discovery and routing information, while the Broker handles message persistence, replication, and delivery with configurable storage options. This template deploys both components with the HTTP Proxy enabled on the Broker, allowing REST API access for modern web applications. RocketMQ excels at handling high-throughput messaging workloads with minimal latency while maintaining message durability through persistent storage. Railway provides scalable CPU, RAM, and persistent storage volumes for the Broker's message store, ensuring reliable message delivery and data persistence.

## Common Use Cases

- **Event-Driven Architectures**: Building microservices that communicate asynchronously through events, enabling loose coupling and independent scaling of services across distributed systems.

- **Order Processing and E-commerce**: Managing transaction messages for payment processing, inventory updates, and order fulfillment workflows that require exactly-once delivery guarantees.

- **Real-time Data Pipelines**: Streaming log data, user activity events, and IoT sensor data for analytics, monitoring dashboards, and real-time notifications.

- **Message Queuing for Background Jobs**: Handling asynchronous task processing, scheduled message delivery, and retry mechanisms for failed operations in web applications.

## Dependencies for Apache RocketMQ Hosting

- **NameServer** - Provides routing information and service discovery for the messaging cluster
- **Broker** - Handles message storage, delivery, and the HTTP Proxy for REST API access

### Deployment Dependencies

- The official Apache RocketMQ image version 5.3.2 - https://hub.docker.com/r/apache/rocketmq
- GitHub repository for this template - https://github.com/crisog/apache-rocketmq

### Implementation Details

**NameServer Configuration**

The NameServer uses a minimal Dockerfile based on the official Apache RocketMQ 5.3.2 image. It runs the `mqnamesrv` command with automatic log directory creation to ensure proper operation on Railway's infrastructure.

**Broker with HTTP Proxy**

The Broker Dockerfile extends the base RocketMQ image with an entrypoint script that:
- Creates and properly configures the `/home/rocketmq/store` directory for persistent message storage (mounted from Railway volume)
- Sets correct permissions for the RocketMQ user (UID 3000)
- Enables the HTTP Proxy when `ENABLE_PROXY` environment variable is set, allowing REST API access on port 8081
- Uses `gosu` for proper privilege dropping to run as a non-root user

The HTTP Proxy enables modern applications to interact with RocketMQ using simple HTTP requests without requiring the Java SDK.

**Volume Configuration**

The Broker requires a persistent volume mounted at `/home/rocketmq/store` to ensure message durability across deployments and restarts.

## Why Deploy Apache RocketMQ on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Apache RocketMQ on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.

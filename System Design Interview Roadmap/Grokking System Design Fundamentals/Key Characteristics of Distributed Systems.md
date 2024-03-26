# Key Characteristics of Distributed Systems
## Scalability
### Horizontal scaling vs. Vertical scaling
- **Horizontal scaling (a.k.a scaling out)**  
    involves adding more machines or nodes to a system to distribute the workload evenly. This approach allows the system to handle an increased number of requests without overloading individual nodes. Horizontal scaling is particularly useful in distributed systems because it provides a cost-effective way to manage fluctuating workloads and maintain high availability.
  - provides a cost-effective way to manage fluctuating workloads and maintain high availability

- **Vertical scaling (a.k.a scaling up)**  
  refers to increasing the capacity of individual nodes within a system
  - limited to the capacity of a single server
  - often involves downtime (while upgrading server)
  - can lead to a single point of failure

![](./assets/vertical%20scaling%20vs%20horizontal%20scaling.webp)


## Availability
Availability is a measure of how accessible and reliable a system is to its users.  
High availability is crucial to ensure that the system remains operational even in the face of failures or increased demand

### Definition of Availability
High availability is often measured in terms of uptime, which is the ratio of time that a system is operational to the total time it is supposed to be operational.  
Achieving high availability involves minimizing planned and unplanned downtime, eliminating single points of failure, and implementing redundant systems and processes.

### Strategies for Achieving High Availability
- through Redundancy and Replication
- through Load Balancing
- through Health Monitoring and Alerts
- through Regular System Maintenance and Updates
  - hardware inspections
  - software updates
  - routine checks
  - ...etc.
- different Consistency Models(Strong, Weak, Eventual)  
Consistency models define how a distributed system maintains a coherent and up-to-date view of its data across all replicas. Different consistency models provide different trade-offs between availability, performance, and data correctness. Strong consistency ensures that all replicas have the same data at all times, at the cost of reduced availability and performance. Weak consistency allows for temporary inconsistencies between replicas, with the advantage of improved availability and performance. Eventual consistency guarantees that all replicas will eventually converge to the same data, providing a balance between consistency, availability, and performance.

### Latency and Performance
- Data Locality  
  Data locality refers to the organization and distribution of data within a distributed system to minimize the amount of data that needs to be transferred between nodes. By storing related data close together or near the nodes that access it most frequently, you can reduce the latency associated with data retrieval and improve overall performance. Techniques to achieve data locality include data partitioning, sharding, and data replication.
- Load Balancing  
  Load balancing is the process of distributing incoming network traffic or computational workload across multiple nodes or resources to ensure that no single node is overwhelmed.
- Caching Strategies  
  Caching is a technique used to store frequently accessed data or computed results temporarily, allowing the system to quickly retrieve the data from cache instead of recalculating or fetching it from the primary data source. By implementing effective caching strategies, you can significantly reduce latency and improve the performance of your distributed system. Common caching strategies include in-memory caching, distributed caching, and content delivery networks (CDNs).

## Concurrency and Coordination
### Concurrency Control and Synchronization
- Concurrency Control  
  Concurrency control is the process of managing simultaneous access to shared resources or data in a distributed system.
  - Locking
  - Optimistic concurrency control:   
    This approach assumes that conflicts are rare and allows multiple processes to work simultaneously. Conflicts are detected and resolved later, usually through a validation and rollback mechanism.
  - Transactional memory:  
    This technique uses transactions to group together multiple operations that should be executed atomically, ensuring data consistency and isolation.
- Synchronization  
  Synchronization is the process of coordinating the execution of multiple processes or threads in a distributed system to ensure correct operation.
  - Barriers:  
    Barriers are used to synchronize the execution of multiple processes or threads, ensuring that they all reach a specific point before proceeding.
  - Semaphores:  
    Semaphores are signaling mechanisms that control access to shared resources and maintain synchronization among multiple processes or threads.
  - Condition variables:  
    Condition variables allow processes or threads to wait for specific conditions to be met before proceeding with their execution.
#### Concurrency Control vs. Synchronization
- Concurrency Control:  
  - **Primary Goal**: The main objective of concurrency control is to manage access to shared resources (like data or hardware resources) in an environment where multiple processes or threads are executing simultaneously.
  - **Focus**: It is concerned with how to handle situations where multiple processes need to access or modify shared data at the same time.
- Synchronization:  
  - **Primary Goal**: The purpose of synchronization is to coordinate the timing of multiple concurrent processes or threads. It's about managing the execution order and timing of processes to ensure correct operation.
  - **Focus**: It ensures that concurrent processes execute in a way that respects certain timing constraints, like making sure certain operations happen before others or that operations do not interfere destructively with one another.

### Coordination Services
Coordination services are specialized components or tools that help manage distributed systems' complexity by providing a set of abstractions and primitives for tasks like configuration management, service discovery, leader election, and distributed locking. Examples of coordination services include Apache ZooKeeper, etcd, and Consul.

### Consistency Models
In distributed systems, consistency models define the rules for maintaining data consistency across multiple nodes or components.  
It defining the rules for how and when changes made by one operation (like a write) become visible to other operations (like reads).  
Different models offer various trade-offs between consistency, availability, and partition tolerance.
The choice of a consistency model often depends on the specific requirements of the application and the nature of the data being managed.
- Strong Consistency
  - **Definition**: After a write operation completes, any subsequent read operation will immediately see the new value.
  - **Example**: Traditional relational databases (RDBMS) like MySQL or PostgreSQL typically offer strong consistency. If a record is updated in one transaction, any subsequent transaction will see that update.
- Eventual Consistency
  - **Definition**: Over time, all accesses to a particular data item will eventually return the last updated value. The time it takes to achieve consistency after a write is not guaranteed.
  - **Example**: Amazon's DynamoDB uses eventual consistency. If you update a data item, the change might not be immediately visible to all users, but it will eventually propagate to all nodes.
- a lot of other models...

## Monitoring and Observability
Monitoring and observability are essential aspects of managing distributed systems, as they help identify issues, understand system behavior, and ensure optimal performance.
### Metrics Collection
Metrics are quantitative measurements that provide insights into the performance, health, and behavior of a distributed system. Collecting and analyzing metrics, such as latency, throughput, error rates, and resource utilization, can help identify performance bottlenecks, potential issues, and areas for improvement. Tools like Prometheus, Graphite, or InfluxDB can be used to collect, store, and query metrics in distributed systems.
### Distributed Tracing
Distributed tracing is a technique for tracking and analyzing requests as they flow through a distributed system, allowing you to understand the end-to-end performance and identify issues in specific components or services. Implementing distributed tracing using tools like Jaeger, Zipkin, or OpenTelemetry can provide valuable insights into the behavior of your system, making it easier to debug and optimize.
### Logging
Logs are records of events or messages generated by components of a distributed system, providing a detailed view of system activity and helping identify issues or anomalies. Collecting, centralizing, and analyzing logs from all services and nodes in a distributed system can provide valuable insights into system behavior and help with debugging and troubleshooting. Tools like Elasticsearch, Logstash, and Kibana (ELK Stack) or Graylog can be used for log aggregation and analysis.
### Alerting and Anomaly Detection
Alerting and anomaly detection involve monitoring the distributed system for unusual behavior or performance issues and notifying the appropriate teams when such events occur. By setting up alerts based on predefined thresholds or detecting anomalies using machine learning algorithms, you can proactively identify issues and take corrective actions before they impact users or system performance. Tools like Grafana, PagerDuty, or Sensu can help you set up alerting and anomaly detection for your distributed system.
### Visualization and Dashboards
Visualizing metrics, traces, and logs in an easy-to-understand format can help you better comprehend the state of your distributed system and make data-driven decisions. Dashboards are an effective way to aggregate and display this information, providing a unified view of your system's performance and health. Tools like Grafana, Kibana, or Datadog can be used to create customizable dashboards for monitoring and observability purposes.

## Resilience and Error Handling
Resilience and error handling help minimize the impact of failures and ensure that the system can recover gracefully from unexpected events.
### Fault Tolerance
Fault tolerance is the ability of a system to continue functioning correctly in the presence of faults or failures. Designing a fault-tolerant system involves incorporating redundancy at various levels (data, services, nodes) and implementing strategies like replication, sharding, and load balancing to ensure that the system can withstand failures without impacting users or overall performance.
### Graceful Degradation
Graceful degradation refers to the ability of a system to continue providing limited functionality when certain components or services fail. Instead of completely shutting down or becoming unavailable, a gracefully degrading system can continue serving user requests, albeit with reduced functionality or performance. Techniques like circuit breakers, timeouts, and fallbacks can be employed to implement graceful degradation in distributed systems.
### Retry and Backoff Strategies
In distributed systems, transient failures like network issues, timeouts, or service unavailability are common. Implementing retry and backoff strategies can help improve resilience by automatically reattempting failed operations with an increasing delay between retries. This can increase the likelihood of successful operation completion while preventing excessive load on the system during failure scenarios.
### Error Handling and Reporting
Proper error handling and reporting are crucial for understanding and addressing issues in distributed systems. By consistently logging errors, categorizing them, and generating alerts when necessary, you can quickly identify and diagnose problems in the system. Additionally, exposing error information through monitoring and observability tools can help provide insights into system health and behavior.
### Chaos Engineering
Chaos engineering is the practice of intentionally injecting failures into a distributed system to test its resilience and identify weaknesses. By simulating real-world failure scenarios, you can evaluate the system's ability to recover and adapt, ensuring that it can withstand various types of failures. Tools like Chaos Monkey or Gremlin can be used to implement chaos engineering in your distributed system.

## Fault Tolerance vs. High Availability
While both fault tolerance and high availability are about ensuring reliable system operations, they address different levels of resilience and operational continuity.  
The choice between them depends on the specific requirements, criticality, and budget constraints of the business or application in question.

### Fault Tolerance
  - **Definition**  
    Fault Tolerance refers to a system's ability to continue operating without interruption when one or more of its components fail. Fault-tolerant systems are designed to handle hardware, software, and network failures seamlessly
  - **Characteristics**  
    - **Redundancy**: Incorporates redundancy in system components (like servers, networks, storage) to ensure no single point of failure.
    - **Automatic Failover**: Automatically switches to a redundant or standby system upon the failure of a system component.
    - **No Data Loss**: Ensures that no data is lost in the event of a failure.
    - **Cost**: Generally more expensive due to the need for redundant components.
  - **Use Cases**  
    Critical applications in sectors like finance, healthcare, and aviation, where system downtime can have severe consequences.
### High Availability
  - **Definition**  
  High Availability refers to a system's ability to remain operational and accessible for a very high percentage of the time, minimizing downtime as much as possible.
  - **Characteristics**  
    - **Uptime Guarantee**: Designed to ensure a high level of operational performance and uptime (often quantified in terms of “nines” – for example, 99.999% availability).
    - **Load Balancing and Redundancy**: Achieved through techniques like load balancing, redundant systems, and clustering.
    - **Rapid Recovery**: Focuses on quickly restoring service after a failure, though a brief disruption is acceptable.
    - **Cost-Effectiveness**: Balances cost against the desired level of availability.
  - **Use Cases**  
    Online services, e-commerce platforms, and enterprise applications where availability is critical for customer satisfaction and business continuity.

### Key Differences
- **Objective**
  - **Fault Tolerance** is about **continuous operation without failure being noticeable** to the end-user. It is about designing the system to handle failures as they occur.
  - **High Availability** is about ensuring that the system is operational and accessible over a specified period, with minimal downtime. It focuses on **quick recovery from failures**.
- **Downtime**:
  - **Fault Tolerance**: No downtime even during failure.
  - **High Availability**: Minimal downtime, but brief interruptions are acceptable.
- **Data Integrity**:
  - **Fault Tolerance**: Maintains data integrity even in failure scenarios.
  - **High Availability**: Prioritizes system uptime, with potential for minimal data loss in certain failure conditions.
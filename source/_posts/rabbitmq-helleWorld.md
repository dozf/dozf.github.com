---
layout: post
title: "RabbitMQ 入门--- Hello World"
date: 2017-09-14 17:45:19
comments: true
tags: [技术, RabbitMQ]
---

## 一、专业术语介绍
#### 1. 生产者
生产者只发送。发送消息的程序称之为一个生产者。
<div align=center>
![](/assets/images/blogs/rabbitmq/consumer.png)
</div>

#### 2.队列
队列就好比邮箱。虽然消息通过 RabbitMQ 在你的应用中传递，但是它们只能存储在队列中。队列只受主机的内存和磁盘的限制，它本质上是一个大的消息缓冲区。多个生产者可以将消息发送到同一个队列中，多个消费者也可以只从同一个队列接收数据。队列用下面的图表示：
<div align=center>
![](/assets/images/blogs/rabbitmq/queue.png)
</div>

<!-- more -->

#### 3. 消费者
等待接收消息的程序是一个消费者。
<div align=center>
![](/assets/images/blogs/rabbitmq/consumer.png)
</div>

### 注意：
生产者，消费者和队列（RabbitMQ）不必部署在同一台机器上。实际在生产环境的大多数应用中，他们都是分开部署的。

## 二、“Hello World”（使用Java客户端）
在下图中，“P”是我们的生产者，“C”是我们的消费者。中间的框是队列代表消费者的消息缓冲区。
<div align=center>
![](/assets/images/blogs/rabbitmq/java-one.png)
</div>

创建Maven项目，只需要添加如下依赖：
```xml
<dependency>
      <groupId>com.rabbitmq</groupId>
      <artifactId>amqp-client</artifactId>
      <version>4.2.0</version>
    </dependency>
```

### 消息生产者

```java
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

/**
 * 消息生产者
 **/
public class Send {
    private final static String QUEUE_NAME = "hello";

    public static void main(String[] argv) throws Exception {
        // 创建连接工厂
        ConnectionFactory factory = new ConnectionFactory();
//      设置RabbitMQ地址
        factory.setHost("localhost");
        /**
         * 设置用户密码，也可以不设置
         *  默认的用户密码是guest/guest
         */
        factory.setUsername("test");
        factory.setPassword("123456");

//      创建一个新的连接
        Connection connection = factory.newConnection();
//      创建一个频道
        Channel channel = connection.createChannel();

//      声明一个队列 -- 在RabbitMQ中，队列声明是幂等性的（一个幂等操作的特点是其任意多次执行所产生的影响均与一次执行的影响相同），也就是说，如果不存在，就创建，如果存在，不会对已经存在的队列产生任何影响。
        // queueDeclare(String queue, boolean durable, boolean exclusive, boolean autoDelete, Map<String, Object> arguments)
        // 参数1 queue ：队列名
        // 参数2 durable ：是否持久化
        // 参数3 exclusive ：仅创建者可以使用的私有队列，断开后自动删除
        // 参数4 autoDelete : 当所有消费客户端连接断开后，是否自动删除队列
        // 参数5 arguments
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        String message = "Hello World!";
//      发送消息到队列中
		// basicPublish(String exchange, String routingKey, BasicProperties props, byte[] body)
        // 参数1 exchange ：交换器
        // 参数2 routingKey ： 路由键
        // 参数3 props ： 消息的其他参数
        // 参数4 body ： 消息体，是一个字节数组，也就意味着可以传递任何数据。
        channel.basicPublish("", QUEUE_NAME, null, message.getBytes("UTF-8"));
        System.out.println("消息生产者 P [x] Sent '" + message + "'");
//      关闭频道和连接
        channel.close();
        connection.close();
    }
}

```
### 消息消费者

```java
import com.rabbitmq.client.*;

import java.io.IOException;

/**
 * 消息消费者
 **/
public class Recv {
    private final static String QUEUE_NAME = "hello";

    public static void main(String[] argv) throws Exception {
        // 创建连接工厂
        ConnectionFactory factory = new ConnectionFactory();
//      设置RabbitMQ地址
        factory.setHost("localhost");
        /**
         * 设置用户密码，也可以不设置
         *  默认的用户密码是guest/guest
         */
        factory.setUsername("test");
        factory.setPassword("123456");

//      创建一个新的连接
        Connection connection = factory.newConnection();
//      创建一个频道
        Channel channel = connection.createChannel();
//      声明要关注的队列 -- 在RabbitMQ中，队列声明是幂等性的（一个幂等操作的特点是其任意多次执行所产生的影响均与一次执行的影响相同），也就是说，如果不存在，就创建，如果存在，不会对已经存在的队列产生任何影响。
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        System.out.println("消息消费者 C [*] Waiting for messages. To exit press CTRL+C");
//      DefaultConsumer类实现了Consumer接口，通过传入一个频道，告诉服务器我们需要那个频道的消息，如果频道中有消息，就会执行回调函数handleDelivery
        Consumer consumer = new DefaultConsumer(channel) {
            @Override
            public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body) throws IOException {
                String message = new String(body, "UTF-8");
                System.out.println("消息消费者 C [x] Received '" + message + "'");
            }
        };
//      自动回复队列应答 -- RabbitMQ中的消息确认机制
       // basicConsume(String queue, boolean autoAck, Consumer callback)
        // 参数1 queue ：队列名
        // 参数2 autoAck ： 是否自动ACK
        // 参数3 callback ： 消费者对象的一个接口，用来配置回调
        channel.basicConsume(QUEUE_NAME, true, consumer);
    }
}
```


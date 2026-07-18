# 1. 使用轻量级的 JDK 17 作为基础镜像
FROM openjdk:17-jdk-alpine

# 2. 把 Maven 编译打包好的 jar 包，复制到容器内部并改名为 app.jar
COPY target/*.jar app.jar

# 3. 告诉容器启动时，执行 java -jar /app.jar 命令
ENTRYPOINT ["java", "-jar", "/app.jar"]
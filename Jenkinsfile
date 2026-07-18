pipeline {
    agent any

    environment {
        // 【你可以根据需要修改这里】
        IMAGE_NAME = "my-devops-app:latest"       // 要生成的 Docker 镜像名字
        CONTAINER_NAME = "my-devops-container"   // 要运行的容器名字
        PORT_MAPPING = "8082:8080"               // 宿主机 8082 端口映射容器内的 8080 端口
    }

    stages {
        stage('1. 拉取代码') {
            steps {
                // checkout scm 会自动去你配置的 GitHub 仓库拉代码
                checkout scm
            }
        }

    stage('2. Maven 打包') {
            steps {
                // 给 mvnw 赋予执行权限，然后直接用它打包！免去一切 Docker 挂载路径的烦恼
                sh 'chmod +x mvnw'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('3. 构建 Docker 镜像') {
            steps {
                // 调用服务器上的 Docker 命令，根据项目里的 Dockerfile 编译成镜像
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('4. 自动化部署') {
            steps {
                // 如果服务器上已经有同名的老容器在跑，先强制删掉，然后用新镜像启动新容器
                sh """
                    docker rm -f ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} -p ${PORT_MAPPING} ${IMAGE_NAME}
                """
            }
        }
    }
}
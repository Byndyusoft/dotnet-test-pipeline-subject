podTemplate(yaml: '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:20.10.7-dind
    securityContext:
      privileged: true
    env:
      - name: DOCKER_TLS_CERTDIR
        value: ""
''') {
    node(POD_LABEL) {
        checkout scm
        String registryUrl = "container.k8s.byndyusoft.com"
        String branchName = env.BRANCH_NAME
        withCredentials([
            usernamePassword(credentialsId: '534bb51a-7be9-489d-93a9-68b3578405b3', 
            usernameVariable: 'user_nexus', 
            passwordVariable: 'pass_nexus'
        )]) {
            container("docker") {
                sh "docker login -u ${user_nexus} -p ${pass_nexus} ${registryUrl}"
            }
        }

        def allPackageJsonFiles = sh(returnStdout: true, script: "find -name '*.dockerfile'").trim().split("\n")
        for (def item : allPackageJsonFiles) {
            directory = sh(returnStdout: true, script: "dirname ${item}").trim()
            dockerFile = sh(returnStdout: true, script: "basename ${item}").trim()
            String image = ""
            stage("Build Image ${dockerFile}") {
                image = BuildImage(directory, dockerFile, registryUrl, branchName)
            }
            stage("Push Image ${image}") {
                PushImage(image)
            }
        }
        container("docker") {
            sh "docker logout"
        }
    }
}

String BuildImage(String dirPath, String dockerFile, String registryUrl, String branchName) {
    println(dockerFile)
    String appName = dockerFile.split(/\./)[0]
    String image = "${registryUrl}/${appName}:${branchName.replace("/", "-")}"
    dir(dirPath) {
        container("docker") { 
            sh "DOCKER_BUILDKIT=1 docker build -t ${image} --file ${dockerFile}  ."
        }
    }
    return image
}

void PushImage(String image) {
    container("docker") {
        sh "docker push ${image}"
        sh "docker rmi ${image}"
    }
}
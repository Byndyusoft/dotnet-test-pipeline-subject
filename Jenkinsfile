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
        /*String nexusUrl = "container.k8s.byndyusoft.com"
        String imageTag =  sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        String serviceName = "extractor_expert"
        String branchName = env.BRANCH_NAME*/
        /*withCredentials([
            usernamePassword(credentialsId: '534bb51a-7be9-489d-93a9-68b3578405b3', 
            usernameVariable: 'user_nexus', 
            passwordVariable: 'pass_nexus'
        )]) {*/
          container("docker") { 
              // docker build -t <repoName>/<imageName>:<tagName> .
          // docker push yourRegistryHost:<port>/tremaine/hello-world:1.0.0-SNAPSHOT
                def allPackageJsonFiles = findFiles(glob: '**/*.dockerfile')
                for (def item : allPackageJsonFiles) {
                    println(item)
                    directory = sh(returnStdout: true, script: "dirname ${item.path}").trim()
                    appName = sh(returnStdout: true, script: "basename ${item.path}").trim()
                    
                }
              /*sh "docker login -u ${user_nexus} -p ${pass_nexus} ${nexusUrl}"
              stage("Build Image") {
                sh "DOCKER_BUILDKIT=1 docker build -t ${nexusUrl}/${serviceName}:${branchName} ."
              }
              stage("Push Image") {
                sh "docker image ls"
                sh "docker push ${nexusUrl}/${serviceName}:${branchName}"
              }
              sh "docker rmi ${nexusUrl}/${serviceName}:${branchName}"
              sh "docker logout"*/
            }
          //}
    }
}

String build_image(dirPath, appName, branchName) {
    println("todo")
}